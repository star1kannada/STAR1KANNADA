-- STAR1 Kannada — run once in a new Supabase project's SQL Editor.
-- Repeatable for the same schema; this does not migrate an incompatible existing table.
begin;

create schema if not exists private;
revoke all on schema private from public;
grant usage on schema private to authenticated;
create or replace function private.is_admin()
returns boolean language sql stable security invoker
set search_path = ''
as $$ select coalesce((select auth.jwt()) -> 'app_metadata' ->> 'role', '') = 'admin' $$;
revoke all on function private.is_admin() from public;
grant execute on function private.is_admin() to authenticated;

create table if not exists public.organizations (
 id uuid primary key default gen_random_uuid(), slug text not null unique,
 name_en text not null, name_kn text not null, description_en text not null default '',
 description_kn text not null default '', location_en text not null default '',
 location_kn text not null default '', registration_information jsonb not null default '[]',
 is_published boolean not null default false, created_at timestamptz not null default now()
);
create table if not exists public.people (
 id uuid primary key default gen_random_uuid(), slug text not null unique,
 name_en text not null, name_kn text not null, title_en text not null, title_kn text not null,
 roles jsonb not null default '[]', service_areas jsonb not null default '[]',
 photo_url text, sort_order integer not null default 0,
 is_published boolean not null default false, created_at timestamptz not null default now()
);
create table if not exists public.categories (
 id uuid primary key default gen_random_uuid(), slug text not null unique,
 name_en text not null, name_kn text not null,
 description_en text not null default '', description_kn text not null default '',
 sort_order integer not null default 0, is_published boolean not null default false
);
create table if not exists public.posts (
 id uuid primary key default gen_random_uuid(), slug text not null unique,
 category_id uuid references public.categories(id) on delete set null,
 title_en text not null, title_kn text not null, body_en text not null default '',
 body_kn text not null default '', cover_url text, media_url text,
 published_at timestamptz, is_published boolean not null default false,
 created_at timestamptz not null default now()
);
create table if not exists public.events (
 id uuid primary key default gen_random_uuid(), slug text not null unique,
 category_id uuid references public.categories(id) on delete set null,
 title_en text not null, title_kn text not null,
 description_en text not null default '', description_kn text not null default '',
 starts_at timestamptz, ends_at timestamptz, venue_en text not null default '',
 venue_kn text not null default '', image_url text,
 status text not null default 'upcoming' check (status in ('upcoming','ongoing','completed','cancelled')),
 is_sample boolean not null default false, is_published boolean not null default false,
 created_at timestamptz not null default now(),
 check (ends_at is null or starts_at is null or ends_at >= starts_at)
);
create table if not exists public.partners (
 id uuid primary key default gen_random_uuid(), slug text not null unique,
 name_en text not null, name_kn text not null, logo_url text, website_url text,
 is_sample boolean not null default true, sort_order integer not null default 0,
 is_published boolean not null default false
);
create table if not exists public.contact_channels (
 id uuid primary key default gen_random_uuid(), slug text not null unique,
 label_en text not null, label_kn text not null, phone_e164 text,
 url text not null, sort_order integer not null default 0,
 is_published boolean not null default false
);
create table if not exists public.social_links (
 id uuid primary key default gen_random_uuid(), platform text not null unique,
 label_en text not null, label_kn text not null, url text not null,
 sort_order integer not null default 0, is_published boolean not null default false
);
create table if not exists public.profiles (
 user_id uuid primary key references auth.users(id) on delete cascade,
 full_name text not null default '', preferred_language text not null default 'en'
 check (preferred_language in ('en','kn')), created_at timestamptz not null default now()
);
create table if not exists public.enquiries (
 id uuid primary key default gen_random_uuid(),
 user_id uuid not null references auth.users(id) on delete cascade,
 category_id uuid references public.categories(id) on delete set null,
 subject text not null check (char_length(subject) between 1 and 200),
 message text not null check (char_length(message) between 1 and 5000),
 created_at timestamptz not null default now()
);
-- Write these only from a trusted payment webhook/backend after payment verification.
-- Never collect/store card numbers, CVVs, passwords, or UPI credentials in this table.
create table if not exists public.donations (
 id uuid primary key default gen_random_uuid(),
 user_id uuid references auth.users(id) on delete set null,
 amount_paise bigint not null check (amount_paise > 0), currency text not null default 'INR' check (currency = 'INR'),
 provider text not null, provider_payment_id text not null,
 status text not null check (status in ('pending','paid','failed','refunded')),
 created_at timestamptz not null default now(), unique(provider,provider_payment_id)
);

create index if not exists posts_category_idx on public.posts(category_id);
create index if not exists events_category_starts_idx on public.events(category_id,starts_at);
create index if not exists enquiries_user_idx on public.enquiries(user_id);
create index if not exists donations_user_idx on public.donations(user_id);

-- Published channel information can be read by visitors. Admins can edit content.
do $$ declare tbl text; begin
 foreach tbl in array array['organizations','people','categories','posts','events','partners','contact_channels','social_links'] loop
  execute format('alter table public.%I enable row level security',tbl);
  execute format('revoke all on table public.%I from anon, authenticated',tbl);
  execute format('grant select on table public.%I to anon, authenticated',tbl);
  execute format('grant insert, update, delete on table public.%I to authenticated',tbl);
  execute format('drop policy if exists published_read on public.%I',tbl);
  execute format('create policy published_read on public.%I for select to anon, authenticated using (is_published = true)',tbl);
  execute format('drop policy if exists admin_manage on public.%I',tbl);
  execute format('create policy admin_manage on public.%I for all to authenticated using ((select private.is_admin())) with check ((select private.is_admin()))',tbl);
 end loop;
end $$;

alter table public.profiles enable row level security;
alter table public.enquiries enable row level security;
alter table public.donations enable row level security;
revoke all on public.profiles,public.enquiries,public.donations from anon,authenticated;
grant select,insert,update on public.profiles to authenticated;
grant select,insert on public.enquiries to authenticated;
grant select on public.donations to authenticated;
grant all on public.organizations,public.people,public.categories,public.posts,public.events,public.partners,public.contact_channels,public.social_links,public.profiles,public.enquiries,public.donations to service_role;

drop policy if exists profiles_read on public.profiles;
create policy profiles_read on public.profiles for select to authenticated using (user_id=(select auth.uid()) or (select private.is_admin()));
drop policy if exists profiles_create on public.profiles;
create policy profiles_create on public.profiles for insert to authenticated with check (user_id=(select auth.uid()));
drop policy if exists profiles_update on public.profiles;
create policy profiles_update on public.profiles for update to authenticated using (user_id=(select auth.uid())) with check (user_id=(select auth.uid()));
drop policy if exists enquiries_create on public.enquiries;
create policy enquiries_create on public.enquiries for insert to authenticated with check (user_id=(select auth.uid()));
drop policy if exists enquiries_read on public.enquiries;
create policy enquiries_read on public.enquiries for select to authenticated using (user_id=(select auth.uid()) or (select private.is_admin()));
drop policy if exists donations_read on public.donations;
create policy donations_read on public.donations for select to authenticated using (user_id=(select auth.uid()) or (select private.is_admin()));
-- There is intentionally no client insert/update policy for donations.

create or replace function public.handle_new_user()
returns trigger language plpgsql security definer set search_path = '' as $$
begin
 insert into public.profiles(user_id,full_name)
 values(new.id,coalesce(new.raw_user_meta_data->>'full_name',''))
 on conflict(user_id) do nothing;
 return new;
end $$;
revoke all on function public.handle_new_user() from public;
drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created after insert on auth.users for each row execute function public.handle_new_user();
commit;
