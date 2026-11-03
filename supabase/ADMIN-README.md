# STAR1 content admin — four areas only

Login: `/admin/login/`. Separate pages: `/admin/events/`, `/admin/banners/`, `/admin/gallery/`, `/admin/partners/`. `/admin/` also opens the login entry. This setup manages **upcoming events, banners, gallery photos and partners**. The existing general-purpose schema/seed files are legacy; you do not need them for this panel.

## 1. Create the four tables and upload bucket

Run **`admin-all-in-one.sql`** in your Supabase SQL Editor. This single file includes the four-table schema, Storage bucket/policies, starter banners and commented admin-access instructions. `admin-setup.sql` is the schema-only alternative. It creates/extends:

- `events`: bilingual event cards, IST schedule, status, image and publication/order controls.
- `banners`: bilingual two-line homepage headlines, description/button, image and order.
- `gallery`: bilingual captions/alt text and uploaded photos.
- `partners`: bilingual company names/subtitles, logos, optional company website and order.

It also creates the public `site-media` Storage bucket and admin-only write policies. This works on a new project or the earlier STAR1 schema. It does not remove other tables or existing content. If your project has unrelated tables or policies with these names, review them first. Remove any pre-existing broad write policies: PostgreSQL permissive policies combine with OR, so they could defeat admin-only access.

The combined file initializes the current three homepage slides. With the schema-only alternative, optionally run `admin-starter-banners.sql` to initialize them. It uses existing bundled website images and never overwrites an existing banner slug. Other areas start empty so sample dates and companies do not become real content.

`admin-queries.sql` contains SELECT examples for these four tables only.

## 2. Fill in the env file

Copy `.env.example` to `.env.local` in the project root. Set:

```dotenv
NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY=sb_publishable_your_key
NEXT_PUBLIC_SITE_URL=http://localhost:3000
```

The existing `.env.local` has not been overwritten. Replace its placeholders locally. Do not paste your database password, admin password or secret/service-role key into public variables. This browser-based admin does not need a secret key.

Restart `npm run dev`. Production hosting must receive the public URL/key **before** `npm run build`, because this site is a static export. Simply editing a local env file cannot update an already published site. Set the production site URL when publishing.

## 3. Create your admin login

1. Supabase Dashboard → Authentication → Users → Add user. Create your administrator email and password. Ensure the email is confirmed through your chosen Auth settings.
2. Copy that user's UID.
3. Open `admin-access.sql`, replace the UID in the commented UPDATE, uncomment that UPDATE, and run it in the SQL Editor as project owner.
4. Visit `/admin/login/` and sign in. If already signed in, sign out and back in so the JWT receives the new role.

Authorization uses trusted `app_metadata.role = 'admin'`. Users cannot grant themselves access through public signup or user metadata. The client verifies the account with Supabase Auth and RLS enforces access to records and files. Admin revocation requires terminating Auth sessions; a valid issued access JWT remains usable until expiry.

There is no default admin email/password, public admin signup or password-reset workflow in this panel. Use the Supabase Dashboard to manage administrator accounts.

## 4. Manage content

Choose a section, click **Add**, upload the image, fill in English and Kannada fields, set order and choose draft/published. For event date/time, enter **India Standard Time**; the panel converts it to UTC for storage and the site displays IST.

Supported uploads: JPG, PNG, WebP or AVIF, up to **5 MB**. SVG is not accepted. New content requires an image; edits can keep the current image. Draft rows stay hidden from visitors. Only events with `status = upcoming` and `is_published = true` appear in the upcoming-events carousel. To remove an item from the public site without deleting it, choose **Hide**.

Uploaded files are public website media, even while their content row is a draft. Do not upload private documents. Gallery captions open into a full-image viewer. Images use unique paths so replacing one does not overwrite a cached file.

The panel uploads first, saves the record second, then removes a replaced upload. If saving fails, it attempts to remove the unused new upload. If cleanup fails, a message tells you to remove the orphan in Storage. Deleting an item removes its row and attempts to remove its uploaded file. Bundled starter images are never deleted from Storage.

The public site reads the database at runtime (no rebuild for normal content edits). Refresh it or refocus its tab after publishing; it also checks every 60 seconds. Connected, empty tables remain empty: no hardcoded content is silently reintroduced. If Supabase is **not configured**, the existing visual preview remains; the admin shows setup instructions. Public login/signup and donations remain separate preview flows.

## Verification

Build/type checks and local PostgreSQL policy tests can run without credentials. Real Supabase login, physical uploads and live publishing require your project URL/key, SQL setup and admin user. No remote project was modified by creating these files.

Official references: [API keys](https://supabase.com/docs/guides/getting-started/api-keys), [Storage access policies](https://supabase.com/docs/guides/storage/security/access-control), [Upload API](https://supabase.com/docs/reference/javascript/storage-from-upload).


## What email and password should I use?

Use **the email and password you create in your Supabase project's Authentication → Users screen**. There are no preassigned or demo credentials in the deployed site. The current env values are placeholders, so real login is not enabled yet. Set the public project URL/key in `.env.local`, run the combined SQL, create the Auth account, then grant that specific account the admin role with the UPDATE at the end of the SQL file. Do not put the login password in `.env` or SQL source.
