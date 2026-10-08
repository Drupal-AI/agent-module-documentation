<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Warehouses, the stock field, and the StockKeeper

## Enable

```bash
drush en arch_stock -y
```

Depends on `entity`, `arch`, `arch_product`. Installs the `product.stock` field storage and a locked
`default` warehouse.

## Turning stock on for a product type

Stock is only tracked for product types whose third-party setting `arch_stock.stock_enable` is TRUE
(set on the product-type form; schema `arch_product.type.*.third_party.arch_stock` also has
`out_of_stock` message text). When enabled, the `stock` field is attached to that bundle; editing a
product then shows the per-warehouse quantity table (`stock_default` widget, template
`stock-form-table.html.twig`).

## The warehouse entity

`warehouse` is a config entity (`Entity/Warehouse.php`). Config object `arch_stock.warehouse.{id}`
(schema `arch_stock.warehouse.*`):

| key | meaning |
|---|---|
| `name` / `id` / `description` / `weight` | label, machine name, description, sort order |
| `allow_negative` | permit over-booking (stock may go below zero) |
| `overbooked_availability` | product availability status to set when this warehouse is oversold |
| `locked` | locked warehouses cannot be deleted (the shipped `default` is locked) |

Admin UI is provided by `Entity/Routing/WarehouseRouteProvider`; deletion is at
`entity.warehouse.delete_form` and blocked for locked warehouses by
`WarehouseAccessControlHandler`.

## The stock field type

`Plugin/Field/FieldType/Stock.php` (id `stock`) stores three columns per delta: `warehouse`
(`varchar_ascii` 32), `quantity` (`numeric` 14,2), `cart_quantity` (`numeric` 14,2). Helpers:
`getQuantity()`, `getCartQuantity()`, `getWarehouse()`, `isAvailable()` (= `quantity -
cart_quantity > 0`). Field storage `product.stock` is unlimited-cardinality and locked.

## Access / who can buy from which warehouse

`Access\StockPermissions::permissions()` generates, per warehouse:

- `purchase from {id} stock` — a *buyer* permission (not restricted);
- `create {id} stock`, `edit {id} stock`, `delete {id} stock` — all `restrict access: true` (admins).

`WarehouseAccessControlHandler::checkViewAccess()` grants **view** of a warehouse only if the account
holds `purchase from {id} stock`. It first copies the account roles and **removes `administrator`**,
so even an administrator must be granted the explicit purchase permission to draw from a warehouse —
this is intentional (purchase access is opt-in per role), not a bypass. Non-view operations short
circuit to allowed for holders of `administer stock`.

## Computing and reducing stock — `StockKeeper`

`arch_stock.stock_keeper` (`StockKeeper`):

- `selectWarehouses($account)` — warehouse ids available to the account
  (`WarehouseManager::getAvailableWarehouses()`), alterable via
  `hook_stock_keeper_selected_warehouses_alter()`.
- `getTotalProductStock($product, $account)` — sums `quantity` over the account's warehouses; result
  passed through `hook_product_stock_alter()`.
- `hasProductEnoughStock($product, $account, $amount)` — FALSE if availability is
  `STATUS_NOT_AVAILABLE`; TRUE if a selected warehouse allows negative stock; else total ≥ amount.
- `reduceStock($product, $sold_amount, $order, $account)` → `doReduce()` — subtracts the sold amount
  across the account's warehouses, handles over-booking (only warehouses whose `allowNegative()` is
  set), optionally sets the product's availability to the warehouse's `overbooked_availability`,
  saves the product **without a new revision**, fires `hook_stock_reduced()`, and invalidates the
  product's cache tags.

All stock quantities come from the product entity's own `stock` field (admin-managed) and all
warehouse/order lookups use the entity API or the parameterised query builder
(`StockInfo::typeHasStockData()` uses `db->select('product__stock')->condition(...)`), so quantities
are computed server-side and are not client-supplied.

## In-cart reservations — `StockCartInfo`

`stock_cart.info` tracks quantities currently sitting in carts (per product and per owner/session) in
the shared tempstore `arch_stock_in_cart` (`quantityInCarts()`, `addItem()`, `updateItem()`,
`removeItem()`), so availability can subtract what is already reserved.

## Caveat (functional, not security)

`reduceStock()` wraps the work in `while ($this->lock->wait($lock_name, 0.2)) { acquire; doReduce;
release; break; }`. `LockBackend::wait()` returns FALSE when the lock is immediately free, so under no
contention the loop body can be skipped and the reduction may no-op. Treat concurrent-order stock
reduction as needing verification on your setup; the intent is a locked single reduction per product.
