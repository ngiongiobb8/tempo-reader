-- Tempo Reader: bookmarks + notes (one-time add-on).
-- Paste into Supabase -> SQL Editor -> New query -> Run. Safe to run more than once.

create table if not exists public.bookmarks (
  user_id    uuid not null default auth.uid() references auth.users(id) on delete cascade,
  id         text not null,
  book_id    text not null,
  word       integer not null default 0,
  snippet    text not null default '',
  chapter    text not null default '',
  note       text not null default '',
  deleted    boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  primary key (user_id, id)
);

alter table public.bookmarks enable row level security;

drop policy if exists "own bookmarks" on public.bookmarks;
create policy "own bookmarks" on public.bookmarks
  for all to authenticated
  using (auth.uid() = user_id) with check (auth.uid() = user_id);
