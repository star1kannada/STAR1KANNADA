# Supabase setup for STAR1 Kannada

The website currently renders from local TypeScript data. These SQL files prepare a database; they do not connect the live site or replace its preview login/donation forms. No Supabase credentials were supplied, so no remote project or tables have been created.

1. Create or select a Supabase project.
2. Run `schema.sql` in the SQL Editor, then `seed.sql`. They are repeatable against this schema. Back up and review before using in an existing project with similarly named tables.
3. Copy `.env.example` at the project root to `.env.local`. Fill in the project URL and **publishable key** from the project's API settings. Use the production site URL for `NEXT_PUBLIC_SITE_URL` when deploying. Rebuild after changing public environment values.
4. Configure the Auth Site URL and allowed redirect URLs for localhost and the production domain before implementing sign-in. Email confirmation and recovery flows still need implementation; the present UI remains a preview.
5. Use `queries.sql` for read examples and the commented owner-only admin setup. Public users can read published content. Ordinary signed-in users can only create/read their own enquiries and create/read/update their own profile. They cannot edit channel content or donation records.
6. Admin authorization uses the trusted `app_metadata.role` claim. Set it from the SQL Editor or trusted Admin API, never from user-editable metadata. Refresh the user's session after changing it.

## Tables

- `organizations`: STAR1 divisions and trust registration information as supplied.
- `people`: founder/Hema profiles, bilingual roles and service areas.
- `categories`: reality shows, awards shows, serials, magazine/e-paper, digital media.
- `posts`: articles, magazine/e-paper entries, media and programme content.
- `events`: event schedule, status, category and sample-content marker.
- `partners`: real or sample partners, logo and website.
- `contact_channels`, `social_links`: public WhatsApp contacts and supplied social URLs.
- `profiles`: Supabase Auth user profiles; new users receive a profile via a trigger.
- `enquiries`: signed-in users' private enquiries; no unauthenticated form endpoint.
- `donations`: records for a future payment provider. Only a trusted service-role backend/webhook may write verified payment status. No payment gateway is currently connected.

Seed data contains the supplied organization, people, category and contact details. It intentionally does not turn illustrative event dates or partner identities into confirmed records. Registration/approval details are user-supplied; registration IDs and supporting documents were not provided.

## Secrets and deployment

The public URL and publishable key may be used in a browser with RLS. A secret/service-role key bypasses RLS and must never be exposed via `NEXT_PUBLIC_`, client code, or Git. `.env.local` is ignored. This static-export app has no trusted server runtime for a secret key or payment webhooks. Implement a separate trusted backend or switch to a suitable server deployment before adding those capabilities.

References: [API keys](https://supabase.com/docs/guides/getting-started/api-keys), [RLS](https://supabase.com/docs/guides/database/postgres/row-level-security), [Next.js quickstart](https://supabase.com/docs/guides/getting-started/quickstarts/nextjs).
