-- Run this once in Supabase SQL Editor when you are ready for phone <-> laptop sync.
create table if not exists products (
  id uuid primary key,
  name text not null,
  category text default '',
  sku text default '',
  target_qty numeric default 0,
  reorder_qty numeric default 0,
  purchase_price numeric default 0,
  selling_price numeric default 0,
  opening_qty numeric default 0,
  updated_at timestamptz default now(),
  updated_by text default ''
);
create table if not exists stock_transactions (
  id uuid primary key,
  type text not null check (type in ('SALE','PURCHASE','ADJUSTMENT')),
  product_id uuid not null,
  qty numeric not null,
  unit_price numeric default 0,
  supplier text default '',
  note text default '',
  transaction_date date not null,
  device_id text not null,
  created_at timestamptz default now()
);
create table if not exists sync_devices (
  device_id text primary key,
  device_name text default '',
  last_seen timestamptz default now()
);
alter table products enable row level security;
alter table stock_transactions enable row level security;
alter table sync_devices enable row level security;
-- For the first private test project only. Tighten policies before public deployment.
create policy "test products" on products for all using (true) with check (true);
create policy "test transactions" on stock_transactions for all using (true) with check (true);
create policy "test devices" on sync_devices for all using (true) with check (true);
