-- ════════════════════════════════════════════════════════════
--  YAFAST JOBS SITE — Supabase Database Setup
--  Run this in: Supabase Dashboard → SQL Editor → New query
-- ════════════════════════════════════════════════════════════

-- 1. TABLES

create table if not exists vacancies (
  id          uuid primary key default gen_random_uuid(),
  title       text not null,
  sector      text default 'General',
  location    text default 'UAE',
  salary      text,
  slots       integer,
  status      text default 'Active',
  description text,
  created_at  timestamptz default now()
);

create table if not exists applications (
  id          uuid primary key default gen_random_uuid(),
  name        text,
  job         text,
  company     text,
  nationality text,
  phone       text,
  email       text,
  experience  text,
  message     text,
  type        text default 'apply',
  created_at  timestamptz default now()
);

create table if not exists enquiries (
  id             uuid primary key default gen_random_uuid(),
  name           text,
  company        text,
  email          text,
  phone          text,
  sector         text,
  workers_needed integer,
  destination    text,
  travel_date    text,
  message        text,
  type           text default 'employer',
  read           boolean default false,
  created_at     timestamptz default now()
);

-- 2. ROW LEVEL SECURITY

alter table vacancies    enable row level security;
alter table applications enable row level security;
alter table enquiries    enable row level security;

-- Allow anonymous key to read/write all tables
-- (admin auth is handled client-side via localStorage password)
create policy "public_all" on vacancies    for all to anon using (true) with check (true);
create policy "public_all" on applications for all to anon using (true) with check (true);
create policy "public_all" on enquiries    for all to anon using (true) with check (true);

-- 3. SEED — existing active vacancies

insert into vacancies (title, sector, location, salary, slots, status, description)
values
  (
    'Housemaid',
    'Domestic',
    'Dubai, UAE',
    'AED 1,000 – 1,200 / mo',
    5,
    'Active',
    'Direct placement at IMDAD Center for Domestic Workers, UAE. Accommodation and meals included.'
  ),
  (
    'Cleaner',
    'Cleaning',
    'Dubai, UAE',
    'AED 1,100 – 1,400 / mo',
    10,
    'Active',
    'Professional cleaning role at SERVEU Union Properties PJSC. Transport and uniform included.'
  );
