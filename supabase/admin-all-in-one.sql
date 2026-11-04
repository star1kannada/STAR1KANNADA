-- STAR1 KANNADA: ONE-FILE ADMIN SETUP
-- Content tables, private donation proofs and Storage policies.
-- Run this whole file in Supabase SQL Editor.
-- It does not create a password or grant admin access automatically.
-- After running, create an Auth user in Dashboard and follow the final section.

-- Focused STAR1 CMS: ONLY upcoming events, banners, gallery and partners.
-- Run in Supabase SQL Editor. Compatible with the earlier STAR1 schema.
begin;
create schema if not exists private;
revoke all on schema private from public;
grant usage on schema private to authenticated;
create or replace function private.is_admin() returns boolean language sql stable security invoker set search_path='' as $$
 select coalesce((select auth.jwt())->'app_metadata'->>'role','')='admin'
$$;
revoke all on function private.is_admin() from public;
grant execute on function private.is_admin() to authenticated;

create table if not exists public.events (
 id uuid primary key default gen_random_uuid(), slug text not null unique,
 title_en text not null, title_kn text not null,
 description_en text not null default '', description_kn text not null default '',
 category_label_en text not null default '', category_label_kn text not null default '',
 starts_at timestamptz, ends_at timestamptz, venue_en text not null default '', venue_kn text not null default '',
 image_url text, image_path text, sort_order integer not null default 0,
 status text not null default 'upcoming' check(status in ('upcoming','ongoing','completed','cancelled')),
 is_sample boolean not null default false, is_published boolean not null default false,
 created_at timestamptz not null default now(),
 check(ends_at is null or starts_at is null or ends_at>=starts_at)
);
alter table public.events add column if not exists category_label_en text not null default '';
alter table public.events add column if not exists category_label_kn text not null default '';
alter table public.events add column if not exists image_path text;
alter table public.events add column if not exists sort_order integer not null default 0;

create table if not exists public.banners (
 id uuid primary key default gen_random_uuid(), slug text not null unique,
 label_en text not null, label_kn text not null,
 tag_en text not null default '', tag_kn text not null default '',
 line1_en text not null, line1_kn text not null, line2_en text not null, line2_kn text not null,
 body_en text not null default '', body_kn text not null default '',
 cta_en text not null default '', cta_kn text not null default '', link_url text not null default '#events',
 alt_en text not null default '', alt_kn text not null default '', image_url text not null, image_path text,
 sort_order integer not null default 0, is_published boolean not null default false,
 created_at timestamptz not null default now()
);
create table if not exists public.gallery (
 id uuid primary key default gen_random_uuid(), title_en text not null, title_kn text not null,
 alt_en text not null default '', alt_kn text not null default '', image_url text not null, image_path text,
 sort_order integer not null default 0, is_published boolean not null default false,
 created_at timestamptz not null default now()
);
create table if not exists public.partners (
 id uuid primary key default gen_random_uuid(), slug text not null unique,
 name_en text not null, name_kn text not null, subtitle_en text not null default '', subtitle_kn text not null default '',
 logo_url text, logo_path text, website_url text,
 sort_order integer not null default 0, is_sample boolean not null default false,
 is_published boolean not null default false
);
alter table public.partners add column if not exists subtitle_en text not null default '';
alter table public.partners add column if not exists subtitle_kn text not null default '';
alter table public.partners add column if not exists logo_path text;
alter table public.partners alter column is_sample set default false;

-- Admin-only record writes are enforced here, independently of the UI.
-- Links and image URLs are additionally checked before rendering.
do $$ declare tbl text; begin
 foreach tbl in array array['events','banners','gallery','partners'] loop
  execute format('alter table public.%I enable row level security',tbl);
  execute format('revoke all on table public.%I from anon,authenticated',tbl);
  execute format('grant select on table public.%I to anon,authenticated',tbl);
  execute format('grant insert,update,delete on table public.%I to authenticated',tbl);
  execute format('grant all on table public.%I to service_role',tbl);
  execute format('drop policy if exists published_read on public.%I',tbl);
  execute format('create policy published_read on public.%I for select to anon,authenticated using(is_published=true)',tbl);
  execute format('drop policy if exists admin_manage on public.%I',tbl);
  execute format('create policy admin_manage on public.%I for all to authenticated using((select private.is_admin())) with check((select private.is_admin()))',tbl);
  execute format('create index if not exists %I on public.%I(is_published,sort_order)',tbl||'_published_order_idx',tbl);
 end loop;
end $$;

-- Only public website images belong in this public bucket. Draft image URLs are
-- publicly retrievable too; do not upload confidential files or documents.
insert into storage.buckets(id,name,public,file_size_limit,allowed_mime_types)
values('site-media','site-media',true,5242880,array['image/jpeg','image/png','image/webp','image/avif'])
on conflict(id) do update set public=excluded.public,file_size_limit=excluded.file_size_limit,allowed_mime_types=excluded.allowed_mime_types;

drop policy if exists cms_media_read on storage.objects;
create policy cms_media_read on storage.objects for select to anon,authenticated using(bucket_id='site-media');
drop policy if exists cms_media_upload on storage.objects;
create policy cms_media_upload on storage.objects for insert to authenticated with check(
 bucket_id='site-media' and (select private.is_admin()) and (storage.foldername(name))[1] in ('events','banners','gallery','partners')
);
drop policy if exists cms_media_update on storage.objects;
create policy cms_media_update on storage.objects for update to authenticated
using(bucket_id='site-media' and (select private.is_admin()))
with check(bucket_id='site-media' and (select private.is_admin()) and (storage.foldername(name))[1] in ('events','banners','gallery','partners'));
drop policy if exists cms_media_delete on storage.objects;
create policy cms_media_delete on storage.objects for delete to authenticated using(bucket_id='site-media' and (select private.is_admin()));
commit;


-- Optional starter leadership banner. Rerunning preserves admin edits.
begin;
insert into public.banners (
  slug, label_en, label_kn, tag_en, tag_kn, line1_en, line1_kn, line2_en, line2_kn, body_en, body_kn, cta_en, cta_kn, link_url, alt_en, alt_kn, image_url, sort_order, is_published
) values (
  'star1-leadership',
  'Our leadership',
  'ನಮ್ಮ ನಾಯಕತ್ವ',
  'STAR1 KANNADA · MEDIA. ARTS. COMMUNITY.',
  'ಸ್ಟಾರ್1 ಕನ್ನಡ · ಮಾಧ್ಯಮ. ಕಲೆ. ಸಮಾಜ.',
  'Our people. Our purpose.',
  'ನಮ್ಮ ಜನರು. ನಮ್ಮ ಧ್ಯೇಯ.',
  'Our Kannada.',
  'ನಮ್ಮ ಕನ್ನಡ.',
  'Led by Sri Raasaa Abhaya Eshwara and Smt. Hema, connecting Karnataka through news, culture and community.',
  'ಶ್ರೀ ರಾಸಾ ಅಭಯ ಈಶ್ವರ ಮತ್ತು ಶ್ರೀಮತಿ ಹೇಮಾ ಅವರ ನಾಯಕತ್ವದಲ್ಲಿ ಸುದ್ದಿ, ಸಂಸ್ಕೃತಿ ಮತ್ತು ಸಮುದಾಯದ ಮೂಲಕ ಕರ್ನಾಟಕವನ್ನು ಬೆಸೆಯುತ್ತೇವೆ.',
  'Meet our leadership',
  'ನಮ್ಮ ನಾಯಕತ್ವದ ಪರಿಚಯ',
  '#founder',
  'Portrait composite of Sri Raasaa Abhaya Eshwara and Smt. Hema',
  'ಶ್ರೀ ರಾಸಾ ಅಭಯ ಈಶ್ವರ ಮತ್ತು ಶ್ರೀಮತಿ ಹೇಮಾ ಅವರ ಸಂಯೋಜಿತ ಭಾವಚಿತ್ರ',
  '/leadership-banner.png',
  1,
  true
) on conflict(slug) do nothing;
commit;



-- 1. In Supabase > Authentication > Users, create your admin email/password user.
-- 2. Copy their User UID and replace the placeholder below.
-- 3. Run ONLY in the Supabase SQL Editor as the project owner.
-- 4. Sign out/in after running this so the new role enters the session JWT.
-- No admin password or secret key is hardcoded into the website.

-- update auth.users
-- set raw_app_meta_data=coalesce(raw_app_meta_data,'{}'::jsonb)||'{"role":"admin"}'::jsonb
-- where id='REPLACE_WITH_AUTH_USER_UID'::uuid;

-- To revoke administrator access, run the following, then revoke the user's
-- existing Auth sessions in the Dashboard. Existing JWTs last until expiry.
-- update auth.users set raw_app_meta_data=raw_app_meta_data-'role'
-- where id='REPLACE_WITH_AUTH_USER_UID'::uuid;

-- OPTIONAL DRAFT INSERT EXAMPLES
-- Uncomment the following block to insert sample drafts. Replace the values first.
/*
-- OPTIONAL INSERT EXAMPLES: replace sample values and image URLs before running.
-- These examples are drafts (is_published=false). Publish from the admin panel.
-- Upload actual images using Admin or Storage Dashboard, bucket site-media.
-- image_path/logo_path is the bucket-relative path, e.g. gallery/photo.jpg.
-- image_url/logo_url is the corresponding public URL. SQL does not upload files.
-- Local bundled /newsroom.jpg is used below so the example banner has a valid image.

insert into public.banners
(slug,label_en,label_kn,tag_en,tag_kn,line1_en,line1_kn,line2_en,line2_kn,body_en,body_kn,cta_en,cta_kn,link_url,alt_en,alt_kn,image_url,sort_order,is_published)
values
('example-banner','News update','ಸುದ್ದಿ ಮಾಹಿತಿ','STAR1 KANNADA','ಸ್ಟಾರ್1 ಕನ್ನಡ','Your news. Your world.','ನಿಮ್ಮ ಸುದ್ದಿ. ನಿಮ್ಮ ಜಗತ್ತು.','In Kannada.','ಕನ್ನಡದಲ್ಲಿ.','Stories from Karnataka.','ಕರ್ನಾಟಕದ ಸುದ್ದಿಗಳು.','Explore events','ಕಾರ್ಯಕ್ರಮಗಳನ್ನು ನೋಡಿ','#events','News studio','ಸುದ್ದಿ ಸ್ಟುಡಿಯೋ','/newsroom.jpg',4,false)
on conflict(slug) do nothing;

insert into public.events
(slug,title_en,title_kn,description_en,description_kn,category_label_en,category_label_kn,starts_at,ends_at,venue_en,venue_kn,image_url,image_path,sort_order,status,is_sample,is_published)
values
('example-community-event','Sample community event','ಮಾದರಿ ಸಮುದಾಯ ಕಾರ್ಯಕ್ರಮ','Replace with your real event details.','ನಿಮ್ಮ ಕಾರ್ಯಕ್ರಮದ ವಿವರಗಳನ್ನು ಇಲ್ಲಿ ಸೇರಿಸಿ.','Community','ಸಮುದಾಯ','2027-01-15 17:00:00+05:30','2027-01-15 20:00:00+05:30','Bengaluru','ಬೆಂಗಳೂರು','/newsroom.jpg',null,1,'upcoming',true,false)
on conflict(slug) do nothing;

insert into public.gallery
(id,title_en,title_kn,alt_en,alt_kn,image_url,image_path,sort_order,is_published)
values
('fd660c34-dc91-4f26-a025-676fbce417e1','Sample studio photo','ಮಾದರಿ ಸ್ಟುಡಿಯೋ ಚಿತ್ರ','News studio sample','ಸುದ್ದಿ ಸ್ಟುಡಿಯೋ ಮಾದರಿ','/newsroom.jpg',null,1,false)
on conflict(id) do nothing;

insert into public.partners
(slug,name_en,name_kn,subtitle_en,subtitle_kn,logo_url,logo_path,website_url,sort_order,is_sample,is_published)
values
('example-partner','Sample partner','ಮಾದರಿ ಪಾಲುದಾರ','Replace with an actual partner','ನಿಜವಾದ ಪಾಲುದಾರರ ವಿವರಗಳನ್ನು ಸೇರಿಸಿ',null,null,null,1,true,false)
on conflict(slug) do nothing;

*/


-- PRIVATE DONATION PROOF WORKFLOW
-- Run AFTER admin-setup.sql (or the existing admin-all-in-one.sql).
-- Donation screenshots are PRIVATE. Only trusted app_metadata.role=admin can read them.
begin;
create table if not exists public.donation_submissions (
 id uuid primary key,
 donor_name text not null check(char_length(donor_name) between 2 and 120),
 donor_contact text not null check(char_length(donor_contact) between 5 and 200),
 purpose text not null check(purpose in ('news','culture','awareness')),
 amount numeric(12,2) not null check(amount>0),
 transaction_ref text not null check(char_length(transaction_ref) between 6 and 100),
 paid_at timestamptz not null,
 proof_path text not null unique,
 status text not null default 'pending' check(status in ('pending','verified','rejected')),
 review_note text not null default '' check(char_length(review_note)<=2000),
 reviewed_at timestamptz,
 created_at timestamptz not null default now()
);
alter table public.donation_submissions enable row level security;
revoke all on public.donation_submissions from anon,authenticated;
grant select on public.donation_submissions to authenticated;
grant update(status,review_note,reviewed_at) on public.donation_submissions to authenticated;
grant all on public.donation_submissions to service_role;
drop policy if exists donation_admin_read on public.donation_submissions;
create policy donation_admin_read on public.donation_submissions for select to authenticated using((select private.is_admin()));
drop policy if exists donation_admin_review on public.donation_submissions;
create policy donation_admin_review on public.donation_submissions for update to authenticated using((select private.is_admin())) with check((select private.is_admin()));
create index if not exists donation_review_idx on public.donation_submissions(status,created_at desc);

insert into storage.buckets(id,name,public,file_size_limit,allowed_mime_types)
values('donation-proofs','donation-proofs',false,5242880,array['image/jpeg','image/png','image/webp'])
on conflict(id) do update set public=false,file_size_limit=excluded.file_size_limit,allowed_mime_types=excluded.allowed_mime_types;
drop policy if exists donation_proof_upload on storage.objects;
create policy donation_proof_upload on storage.objects for insert to anon,authenticated with check(
 bucket_id='donation-proofs' and name ~ '^proofs/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/proof\.(png|jpg|webp)$'
);
drop policy if exists donation_proof_admin_read on storage.objects;
create policy donation_proof_admin_read on storage.objects for select to authenticated using(bucket_id='donation-proofs' and (select private.is_admin()));
-- No public SELECT, overwrite or DELETE policies for this bucket.

create or replace function public.donation_proof_ready() returns boolean language sql immutable set search_path='' as $$select true$$;
revoke all on function public.donation_proof_ready() from public;
grant execute on function public.donation_proof_ready() to anon,authenticated;

create or replace function public.submit_donation_proof(
 p_id uuid,p_donor_name text,p_donor_contact text,p_purpose text,p_amount numeric,
 p_transaction_ref text,p_paid_at timestamptz,p_proof_path text
) returns uuid language plpgsql security definer set search_path='' as $$
begin
 if p_proof_path !~ ('^proofs/'||p_id::text||'/proof\.(png|jpg|webp)$') then
  raise exception 'Invalid payment proof path';
 end if;
 if not exists(select 1 from storage.objects where bucket_id='donation-proofs' and name=p_proof_path) then
  raise exception 'Upload the payment screenshot first';
 end if;
 insert into public.donation_submissions(id,donor_name,donor_contact,purpose,amount,transaction_ref,paid_at,proof_path,status)
 values(p_id,btrim(p_donor_name),btrim(p_donor_contact),p_purpose,p_amount,btrim(p_transaction_ref),p_paid_at,p_proof_path,'pending')
 on conflict(id) do nothing;
 if not found and not exists(
  select 1 from public.donation_submissions d where d.id=p_id
  and d.donor_name=btrim(p_donor_name) and d.donor_contact=btrim(p_donor_contact)
  and d.purpose=p_purpose and d.amount=p_amount
  and d.transaction_ref=btrim(p_transaction_ref) and d.paid_at=p_paid_at and d.proof_path=p_proof_path
 ) then
  raise exception 'This reference was already submitted with different details. Contact STAR1 with your reference.';
 end if;
 return p_id;
end $$;
revoke all on function public.submit_donation_proof(uuid,text,text,text,numeric,text,timestamptz,text) from public;
grant execute on function public.submit_donation_proof(uuid,text,text,text,numeric,text,timestamptz,text) to anon,authenticated;
commit;
