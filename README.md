# EYU_VISUAL Portfolio

A responsive black-and-orange graphic design portfolio starter.

## Included
- Home, About, Services, My Design, Pricing, Contact sections
- Mobile navigation and category filters
- Package selection and Telegram inquiry form
- Admin entry point placeholder (not authenticated yet)
- Supabase SQL starter for secure admin-only design management

## Run locally
Open `index.html` in a browser. For a local server, run `python -m http.server 8000` in this folder and open `http://localhost:8000`.

## Important status
This is the first front-end build, **not yet a deployed full-function website**. The gallery's sample designs are placeholders. The admin dialog is intentionally a setup notice, not a real login. Do not enter a real password into the demo.

## Enable a secure admin backend (Supabase)
1. Create a Supabase project.
2. In Authentication, enable Email + Password. Create your own user in the dashboard.
3. Run `supabase/schema.sql` in the Supabase SQL Editor.
4. Replace `YOUR_SUPABASE_URL` and `YOUR_SUPABASE_ANON_KEY` in a future client integration. These are public client values; never put a service-role key in browser code.
5. Add your user UUID to `public.admin_users` using the SQL editor after creating the account. Only that UUID receives admin privileges.
6. Configure Storage bucket `designs` as private or public according to your publishing requirements; enforce upload/delete policies for admin users only. For public portfolio images, a common setup is a public read bucket with admin-only writes.
7. Connect the site to Supabase Auth, database, and Storage. Test from a separate non-admin account to verify it cannot add, edit, or delete designs.

## Free hosting
You can deploy the static front end to a free static host such as GitHub Pages, Cloudflare Pages, or Netlify's free tier (availability and limits may change). Supabase also has a free tier with usage limits. A custom domain usually costs extra.

## Before launch
- Replace sample gallery cards with your own work.
- Confirm package deliverables and revisions.
- Test phone, Telegram, and Instagram links.
- Add privacy notice and anti-spam protections to the inquiry form.
- Set up a secure admin account and database policies before enabling design uploads.
