-- CONTRA BY NIRO commerce schema (Supabase/Postgres)
-- Apply only to a dedicated store project after reviewing the migration.
create extension if not exists pgcrypto;

create type public.order_status as enum ('pending_payment','paid','processing','shipped','delivered','cancelled','refunded');
create type public.payment_status as enum ('created','pending','succeeded','failed','cancelled','refunded');

create table public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text,
  phone text,
  preferred_locale text not null default 'en',
  preferred_currency text not null default 'BDT',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.products (
  id uuid primary key default gen_random_uuid(),
  slug text unique not null,
  sku text unique,
  name jsonb not null default '{"en":""}'::jsonb,
  description jsonb not null default '{"en":""}'::jsonb,
  brand text,
  category text not null,
  images text[] not null default '{}',
  price_bdt bigint not null check(price_bdt >= 0),
  compare_at_bdt bigint check(compare_at_bdt is null or compare_at_bdt >= price_bdt),
  stock_on_hand integer not null default 0 check(stock_on_hand >= 0),
  active boolean not null default true,
  metadata jsonb not null default '{}',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.addresses (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  recipient_name text not null,
  phone text not null,
  country_code char(2) not null,
  address_line1 text not null,
  address_line2 text,
  city text not null,
  region text,
  postal_code text,
  is_default boolean not null default false,
  created_at timestamptz not null default now()
);

create table public.orders (
  id uuid primary key default gen_random_uuid(),
  order_number text unique not null default ('CN-' || upper(substr(replace(gen_random_uuid()::text,'-',''),1,12))),
  user_id uuid references auth.users(id) on delete set null,
  customer_email text not null,
  customer_name text not null,
  customer_phone text not null,
  country_code char(2) not null,
  currency char(3) not null,
  subtotal_bdt bigint not null check(subtotal_bdt >= 0),
  shipping_bdt bigint not null default 0 check(shipping_bdt >= 0),
  discount_bdt bigint not null default 0 check(discount_bdt >= 0),
  tax_bdt bigint not null default 0 check(tax_bdt >= 0),
  total_bdt bigint not null check(total_bdt >= 0),
  status public.order_status not null default 'pending_payment',
  shipping_address jsonb not null,
  customer_note text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.order_items (
  id uuid primary key default gen_random_uuid(),
  order_id uuid not null references public.orders(id) on delete cascade,
  product_id uuid references public.products(id) on delete set null,
  sku text,
  product_name text not null,
  unit_price_bdt bigint not null check(unit_price_bdt >= 0),
  quantity integer not null check(quantity > 0),
  line_total_bdt bigint generated always as (unit_price_bdt * quantity) stored
);

create table public.payment_attempts (
  id uuid primary key default gen_random_uuid(),
  order_id uuid not null references public.orders(id) on delete cascade,
  provider text not null,
  method text not null,
  provider_payment_id text,
  idempotency_key text not null unique,
  amount_minor bigint not null check(amount_minor > 0),
  currency char(3) not null,
  status public.payment_status not null default 'created',
  checkout_url text,
  provider_response jsonb not null default '{}',
  verified_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique(provider, provider_payment_id)
);

create table public.wishlist_items (
  user_id uuid not null references auth.users(id) on delete cascade,
  product_id uuid not null references public.products(id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key(user_id, product_id)
);

create table public.inventory_movements (
  id uuid primary key default gen_random_uuid(),
  product_id uuid not null references public.products(id),
  order_id uuid references public.orders(id),
  quantity_delta integer not null check(quantity_delta <> 0),
  reason text not null,
  created_at timestamptz not null default now()
);

create index products_active_category_idx on public.products(active, category);
create index orders_user_created_idx on public.orders(user_id, created_at desc);
create index orders_status_created_idx on public.orders(status, created_at desc);
create index payments_order_idx on public.payment_attempts(order_id, created_at desc);

alter table public.profiles enable row level security;
alter table public.products enable row level security;
alter table public.addresses enable row level security;
alter table public.orders enable row level security;
alter table public.order_items enable row level security;
alter table public.payment_attempts enable row level security;
alter table public.wishlist_items enable row level security;
alter table public.inventory_movements enable row level security;

create policy "Profiles are readable by owner" on public.profiles for select to authenticated using (auth.uid() = id);
create policy "Profiles are editable by owner" on public.profiles for update to authenticated using (auth.uid() = id) with check (auth.uid() = id);
create policy "Active products are public" on public.products for select to anon, authenticated using (active = true);
create policy "Owners manage addresses" on public.addresses for all to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "Owners read orders" on public.orders for select to authenticated using (auth.uid() = user_id);
create policy "Owners read order items" on public.order_items for select to authenticated using (exists(select 1 from public.orders o where o.id = order_id and o.user_id = auth.uid()));
create policy "Owners manage wishlist" on public.wishlist_items for all to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
-- Intentionally no client insert/update policies for orders, payments, inventory, or stock.
-- Only trusted server functions using the service role may mutate those tables.
