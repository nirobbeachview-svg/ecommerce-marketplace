-- CONTRA BY NIRO: query-planning improvements for the initial commerce schema
create index if not exists addresses_user_id_idx on public.addresses(user_id);
create index if not exists inventory_movements_order_id_idx on public.inventory_movements(order_id);
create index if not exists inventory_movements_product_id_idx on public.inventory_movements(product_id);
create index if not exists order_items_order_id_idx on public.order_items(order_id);
create index if not exists order_items_product_id_idx on public.order_items(product_id);
create index if not exists wishlist_items_product_id_idx on public.wishlist_items(product_id);

drop policy if exists "Profiles are readable by owner" on public.profiles;
create policy "Profiles are readable by owner" on public.profiles for select to authenticated using ((select auth.uid()) = id);
drop policy if exists "Profiles are editable by owner" on public.profiles;
create policy "Profiles are editable by owner" on public.profiles for update to authenticated using ((select auth.uid()) = id) with check ((select auth.uid()) = id);
drop policy if exists "Owners manage addresses" on public.addresses;
create policy "Owners manage addresses" on public.addresses for all to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
drop policy if exists "Owners read orders" on public.orders;
create policy "Owners read orders" on public.orders for select to authenticated using ((select auth.uid()) = user_id);
drop policy if exists "Owners read order items" on public.order_items;
create policy "Owners read order items" on public.order_items for select to authenticated using (exists(select 1 from public.orders o where o.id = order_id and o.user_id = (select auth.uid())));
drop policy if exists "Owners manage wishlist" on public.wishlist_items;
create policy "Owners manage wishlist" on public.wishlist_items for all to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
