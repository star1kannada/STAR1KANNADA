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
