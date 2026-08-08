create table public.portfolio_comments (
    id uuid primary key default gen_random_uuid(),
    display_name text not null check (char_length(display_name) between 1 and 40),
    content text not null check (char_length(content) between 1 and 1000),
    created_at timestamptz not null default now()
);

alter table public.portfolio_comments enable row level security;

create policy "Anyone can read portfolio comments"
on public.portfolio_comments
for select
to anon, authenticated
using (true);

create policy "Anyone can add portfolio comments"
on public.portfolio_comments
for insert
to anon, authenticated
with check (
    char_length(display_name) between 1 and 40
    and char_length(content) between 1 and 1000
);
