-- Tempo Reader: one-time Supabase setup.
-- Paste this whole file into Supabase -> SQL Editor -> New query -> Run.
-- Safe to run more than once.

-- 1) Your library: one row per book (title, chapters, etc.)
create table if not exists public.books (
  user_id    uuid not null default auth.uid() references auth.users(id) on delete cascade,
  id         text not null,
  title      text not null,
  author     text not null default '',
  word_count integer not null default 0,
  type       text not null default 'epub',
  chapters   jsonb,
  has_cover  boolean not null default false,
  has_epub   boolean not null default false,
  added_at   timestamptz not null default now(),
  primary key (user_id, id)
);

-- 2) Reading positions: one row per book
create table if not exists public.progress (
  user_id    uuid not null default auth.uid() references auth.users(id) on delete cascade,
  book_id    text not null,
  word       integer not null default 0,
  updated_at timestamptz not null default now(),
  primary key (user_id, book_id)
);

-- 3) Row Level Security: each signed-in user can only see and change their own rows
alter table public.books    enable row level security;
alter table public.progress enable row level security;

drop policy if exists "own books" on public.books;
create policy "own books" on public.books
  for all to authenticated
  using (auth.uid() = user_id) with check (auth.uid() = user_id);

drop policy if exists "own progress" on public.progress;
create policy "own progress" on public.progress
  for all to authenticated
  using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- 4) Private file storage for book text, covers and original EPUBs.
--    Files live at  books/<your user id>/<book id>.txt|.jpg|.epub
insert into storage.buckets (id, name, public)
values ('books', 'books', false)
on conflict (id) do nothing;

drop policy if exists "tempo read own files"   on storage.objects;
drop policy if exists "tempo add own files"    on storage.objects;
drop policy if exists "tempo update own files" on storage.objects;
drop policy if exists "tempo delete own files" on storage.objects;

create policy "tempo read own files" on storage.objects
  for select to authenticated
  using (bucket_id = 'books' and (storage.foldername(name))[1] = auth.uid()::text);

create policy "tempo add own files" on storage.objects
  for insert to authenticated
  with check (bucket_id = 'books' and (storage.foldername(name))[1] = auth.uid()::text);

create policy "tempo update own files" on storage.objects
  for update to authenticated
  using (bucket_id = 'books' and (storage.foldername(name))[1] = auth.uid()::text);

create policy "tempo delete own files" on storage.objects
  for delete to authenticated
  using (bucket_id = 'books' and (storage.foldername(name))[1] = auth.uid()::text);
