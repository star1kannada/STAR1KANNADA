-- Read examples for a future Supabase client; RLS still applies to every query.
select slug,name_en,name_kn from public.categories where is_published order by sort_order;
select slug,name_en,name_kn,title_en,title_kn,roles,service_areas from public.people where is_published order by sort_order;
select * from public.organizations where is_published order by created_at;
select * from public.contact_channels where is_published order by sort_order;
select * from public.social_links where is_published order by sort_order;
select e.*,c.slug as category_slug from public.events e
left join public.categories c on c.id=e.category_id
where e.is_published and e.status in ('upcoming','ongoing') order by e.starts_at nulls last;
select p.* from public.posts p join public.categories c on c.id=p.category_id
where c.slug='magazine' and p.is_published order by p.published_at desc nulls last;

-- Authenticated user: creates only their own enquiry.
-- insert into public.enquiries(user_id,subject,message)
-- values(auth.uid(),'Programme enquiry','I would like more information.');

-- Authenticated user: update only their own preferred language.
-- update public.profiles set preferred_language='kn' where user_id=auth.uid();

-- Admin setup: run ONLY in Supabase SQL Editor as the project owner.
-- Set the intended existing user's UUID, run, then sign out/in to refresh their JWT.
-- update auth.users
-- set raw_app_meta_data=coalesce(raw_app_meta_data,'{}'::jsonb)||'{"role":"admin"}'::jsonb
-- where id='REPLACE_WITH_EXISTING_AUTH_USER_UUID'::uuid;
-- Never use user_metadata for admin authorization.
