-- These are the ONLY four content tables used by the admin panel and homepage.
select * from public.events where is_published and status='upcoming' order by sort_order,starts_at;
select * from public.banners where is_published order by sort_order,id;
select * from public.gallery where is_published order by sort_order,id;
select * from public.partners where is_published order by sort_order,id;
-- Admin-only examples (authenticate as an admin or run in SQL Editor):
-- select * from public.events order by sort_order;  -- includes drafts
-- update public.banners set is_published=false where id='YOUR_BANNER_UUID'::uuid;
-- update public.partners set sort_order=1 where id='YOUR_PARTNER_UUID'::uuid;
-- Always upload/delete physical images with the Supabase Storage SDK or Dashboard.
-- Do not INSERT/DELETE storage.objects rows with SQL to manage physical files.
