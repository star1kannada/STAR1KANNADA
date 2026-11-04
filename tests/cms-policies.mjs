import {PGlite} from '@electric-sql/pglite';
import {readFile} from 'node:fs/promises';
import assert from 'node:assert/strict';
const read=name=>readFile(new URL('../supabase/'+name,import.meta.url),'utf8');
async function test(legacy){
 const db=new PGlite();
 await db.exec(`create role anon;create role authenticated;create role service_role bypassrls;
 create schema auth;create schema storage;
 create table auth.users(id uuid primary key,raw_user_meta_data jsonb default '{}',raw_app_meta_data jsonb default '{}');
 create function auth.jwt() returns jsonb language sql stable as $$select coalesce(nullif(current_setting('request.jwt.claims',true),''),'{}')::jsonb$$;
 create function auth.uid() returns uuid language sql stable as $$select (auth.jwt()->>'sub')::uuid$$;
 create table storage.buckets(id text primary key,name text,public boolean,file_size_limit bigint,allowed_mime_types text[]);
 create table storage.objects(id uuid primary key default gen_random_uuid(),bucket_id text,name text);
 create function storage.foldername(name text) returns text[] language sql immutable as $$select (string_to_array(name,'/'))[1:array_length(string_to_array(name,'/'),1)-1]$$;
 alter table storage.objects enable row level security;
 grant usage on schema auth,storage to anon,authenticated;
 grant execute on all functions in schema auth,storage to anon,authenticated;
 grant select,insert,update,delete on storage.objects to anon,authenticated;`);
 if(legacy){await db.exec(await read('schema.sql'));await db.exec(await read('seed.sql'));}
 for(let i=0;i<2;i++){await db.exec(await read('admin-all-in-one.sql'));}
 const row=await db.query("select public,file_size_limit,allowed_mime_types from storage.buckets where id='site-media'");
 assert.equal(row.rows[0].public,true);assert.equal(Number(row.rows[0].file_size_limit),5242880);assert(!row.rows[0].allowed_mime_types.includes('image/svg+xml'));
 await db.exec("insert into public.gallery(title_en,title_kn,image_url,is_published) values('Draft','Draft','/draft.jpg',false),('Public','Public','/public.jpg',true)");
 async function deny(sql){let denied=false;try{await db.exec(sql)}catch{denied=true}assert(denied,'Expected permission rejection: '+sql)}
 await db.exec('set role anon');
 assert.equal((await db.query('select * from public.gallery')).rows.length,1);
 assert.equal((await db.query('select * from public.banners')).rows.length,1);
 await deny("insert into public.gallery(title_en,title_kn,image_url) values('bad','bad','/bad.jpg')");
 await deny("insert into storage.objects(bucket_id,name) values('site-media','gallery/bad.jpg')");
 await db.exec('reset role;set role authenticated');
 await db.query("select set_config('request.jwt.claims',$1,false)",[JSON.stringify({sub:'11111111-1111-4111-8111-111111111111',user_metadata:{role:'admin'},app_metadata:{}})]);
 assert.equal((await db.query('select * from public.gallery')).rows.length,1);
 assert.equal((await db.query("update public.gallery set title_en='bad' returning id")).rows.length,0);
 await deny("insert into public.banners(slug,label_en,label_kn,line1_en,line1_kn,line2_en,line2_kn,image_url) values('bad','bad','bad','bad','bad','bad','bad','/bad.jpg')");
 await deny("insert into storage.objects(bucket_id,name) values('site-media','gallery/member.jpg')");
 await db.query("select set_config('request.jwt.claims',$1,false)",[JSON.stringify({sub:'11111111-1111-4111-8111-111111111111',app_metadata:{role:'admin'}})]);
 assert.equal((await db.query('select * from public.gallery')).rows.length,2);
 await db.exec("insert into public.events(slug,title_en,title_kn,image_url) values('admin-event','Admin event','Admin event','/event.jpg')");
 assert.equal((await db.query("update public.events set is_published=true where slug='admin-event' returning id")).rows.length,1);
 await db.exec("insert into storage.objects(bucket_id,name) values('site-media','events/admin.jpg')");
 await deny("insert into storage.objects(bucket_id,name) values('other-bucket','gallery/bad.jpg')");
 await deny("insert into storage.objects(bucket_id,name) values('site-media','private/bad.jpg')");
 assert.equal((await db.query("delete from storage.objects where name='events/admin.jpg' returning id")).rows.length,1);
 assert.equal((await db.query("delete from public.events where slug='admin-event' returning id")).rows.length,1);
 await db.exec('reset role');await db.exec(await read('admin-queries.sql'));
 await db.exec(await read('admin-insert-examples.sql'));await db.exec(await read('admin-insert-examples.sql'));
 assert.equal((await db.query("select * from public.banners where slug='example-banner' and not is_published")).rows.length,1);
 await db.exec(await read('replace-leadership-banner.sql'));assert.equal((await db.query('select * from public.banners')).rows.length,1);
 await db.close();console.log(`PASS: ${legacy?'existing STAR1 schema':'fresh project'} — repeatable migration, drafts hidden, public writes denied, spoofed role denied, admin CRUD, restricted Storage paths.`);
}
await test(false);await test(true);
