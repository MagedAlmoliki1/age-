-- ============================================================
--  Supabase schema for the Age & Zodiac app
--  Run this once in: Supabase Dashboard → SQL Editor → New query
-- ============================================================

-- جدول الملفات الشخصية: صف واحد لكل مستخدم، مرتبط بـ auth.users
create table if not exists public.profiles (
  id          uuid primary key references auth.users (id) on delete cascade,
  full_name   text,
  birth_date  date,                       -- اختياري: تاريخ الميلاد لحفظه من الحاسبة
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);

-- تفعيل أمان مستوى الصف (RLS)
alter table public.profiles enable row level security;

-- سياسات: كل مستخدم يرى ويعدّل ملفه فقط
drop policy if exists "profiles_select_own" on public.profiles;
create policy "profiles_select_own"
  on public.profiles for select
  using ( auth.uid() = id );

drop policy if exists "profiles_insert_own" on public.profiles;
create policy "profiles_insert_own"
  on public.profiles for insert
  with check ( auth.uid() = id );

drop policy if exists "profiles_update_own" on public.profiles;
create policy "profiles_update_own"
  on public.profiles for update
  using ( auth.uid() = id )
  with check ( auth.uid() = id );

-- تحديث updated_at تلقائياً عند كل تعديل
create or replace function public.handle_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists profiles_updated_at on public.profiles;
create trigger profiles_updated_at
  before update on public.profiles
  for each row execute function public.handle_updated_at();

-- إنشاء صف ملف شخصي تلقائياً عند تسجيل مستخدم جديد
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer set search_path = public
as $$
begin
  insert into public.profiles (id, full_name)
  values (new.id, new.raw_user_meta_data ->> 'full_name')
  on conflict (id) do nothing;
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();
