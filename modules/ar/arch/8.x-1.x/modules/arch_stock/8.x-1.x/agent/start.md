<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Stock (arch_stock) — agent index

Inventory submodule of Arch: a **`warehouse`** config entity plus a multi-value **`stock`** field on
products, with per-warehouse purchase/manage permissions and automatic stock reduction on order.
Package `Arch`. Depends on `entity`, `arch`, `arch_product`. Core `^9.4 || ^10 || ^11`. License
GPL-2.0-or-later. Version dir `8.x-1.x` (installed `8.x-1.0-alpha26`). Ships submodule
`arch_stock_search_api`.

- **Warehouses, the stock field, the StockKeeper reduction logic, permissions & settings** →
  [api/stock.md](api/stock.md)

## Entities

- **`warehouse`** — config entity (`Entity/Warehouse.php`), access handler
  `Access\WarehouseAccessControlHandler`, route provider `Entity/Routing/WarehouseRouteProvider`,
  storage `Entity/Storage/WarehouseStorage`. Config keys (schema `arch_stock.warehouse.*`): `name`,
  `id`, `description`, `weight`, `allow_negative`, `overbooked_availability`, `locked`. Install ships
  a locked `default` warehouse (`config/install/arch_stock.warehouse.default.yml`).

## Field

- Field type **`stock`** (`Plugin/Field/FieldType/Stock.php`) with properties `warehouse` (string id),
  `warehouse_entity` (computed reference), `quantity` (float), `cart_quantity` (float); list class
  `StockFieldItemList`. Widget **`stock_default`**, formatter **`stock_default`**. Field storage
  `product.stock` (cardinality -1, locked) is installed and attached to stock-enabled product types.
  `Stock::isAvailable()` = `quantity - cart_quantity > 0`.

## Services

- `arch_stock.stock_keeper` → `StockKeeper` — `getTotalProductStock()`, `hasProductEnoughStock()`,
  `reduceStock()` (locked via `@lock`), `selectWarehouses()`, over-booking handling.
- `warehouse.manager` → `WarehouseManager`; `warehouse.default` → `WarehouseDefault`.
- `arch_stock.info` → `StockInfo` (`typeHasStockData()`, parameterised `product__stock` count query).
- `stock_cart.info` → `StockCartInfo` (in-cart reservation via shared tempstore / keyvalue.expirable).

## Routes & permissions

- `arch_stock.stock.config` — `/admin/store/stock` (`StockSettingsForm`), permission
  **`administer stock`** (`restrict access`).
- `entity.warehouse.delete_form` — `/admin/store/stock/warehouse/{warehouse}/delete`,
  `_entity_access: warehouse.delete` (locked warehouses cannot be deleted).
- Static perms (`arch_stock.permissions.yml`): `administer stock`, `access warehouse overview` (both
  `restrict access`). Dynamic perms per warehouse (`Access\StockPermissions`):
  `purchase from {id} stock`, and restricted `create/edit/delete {id} stock`.

## Extension points (hooks; see `arch_stock.api.php`)

`hook_product_stock_alter()`, `hook_stock_reduced()`, `hook_stock_keeper_selected_warehouses_alter()`,
`hook_allow_negative_stock_for_warehouse_alter()`. Product-type third-party settings
(`arch_product.type.*.third_party.arch_stock`): `stock_enable`, `out_of_stock`.

## Access model (summary)

Buyable stock is computed **server-side** for the current account over only the warehouses it may
purchase from (`WarehouseAccessControlHandler::checkViewAccess()` requires `purchase from {id} stock`;
note it removes the implicit `administrator` role first). Stock is edited only on the admin product
form. Reduction runs under a lock on order. Details and a known lock-loop caveat in
[api/stock.md](api/stock.md).
