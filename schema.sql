-- EYU_VISUAL: Supabase schema starter
-- Run in Supabase SQL Editor after creating a project.
-- IMPORTANT: create your Auth user first, then insert its UUID into admin_users.
create table if not exists public.admin_users (
  user_id uuid primary key references auth.users(id) on delete cascade,
  created_at timestamptz not null default now()
);

create table if not exists public.designs (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  description text not null default '',
  category text not null check (category in ('Branding','Poster','Thumbnail','Other')),
  image_url text not null,
  published boolean not null default true,
  sort_order integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.orders (
  id uuid primary key default gen_random_uuid(),
  customer_name text not null,
  customer_contact text not null,
  service_type text not null,
  package_name text not null,
  project_details text not null default '',
  created_at timestamptz not null default now()
);

alter table public.admin_users enable row level security;
alter table public.designs enable row level security;
alter table public.orders enable row level security;

-- Only authenticated admins can read the admin allowlist.
create policy "admins can read admin list"
on public.admin_users for select to authenticated
using (exists (select 1 from public.admin_users a where a.user_id = auth.uid()));

-- Public visitors can see published portfolio items.
create policy "public can view published designs"
on public.designs for select to anon, authenticated
using (published = true or exists (select 1 from public.admin_users a where a.user_id = auth.uid()));

-- Admin-only write operations.
create policy "admins can add designs"
on public.designs for insert to authenticated
with check (exists (select 1 from public.admin_users a where a.user_id = auth.uid()));

create policy "admins can update designs"
on public.designs for update to authenticated
using (exists (select 1 from public.admin_users a where a.user_id = auth.uid()))
with check (exists (select 1 from public.admin_users a where a.user_id = auth.uid()));

create policy "admins can delete designs"
on public.designs for delete to authenticated
using (exists (select 1 from public.admin_users a where a.user_id = auth.uid()));

-- Public order writes can be abused if exposed directly; this starter intentionally
-- does not allow anonymous database inserts. Current form opens Telegram instead.
-- If saving orders to the database later, use a server-side Edge Function with validation,
-- rate limiting, and spam protection rather than enabling unrestricted anonymous INSERT.

-- After creating your own auth user, run this with your actual user UUID:
-- insert into public.admin_users (user_id) values ('YOUR-AUTH-USER-UUID');
