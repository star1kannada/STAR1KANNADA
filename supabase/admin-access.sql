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
