<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Logger (arch_logger) — agent index

Records a per-order **audit history** (order + cart changes) for Arch. Package `Arch`. Depends on
`arch_cart`, `arch_order`. Core `^9.4 || ^10 || ^11`. License GPL-2.0-or-later. Version dir `8.x-1.x`
(installed `8.x-1.0-alpha26`). One permission, one DB table, no config schema, no Drush.

## Storage

- `hook_schema()` (`arch_logger.install`) → table **`arch_log`**: `lid` (serial), `uid`, `oid`,
  `status` (varchar 50), `message` (varchar 255), `data` (serialized text), `created`; indexes on
  `uid` and `oid`.

## Service `arch_logger` (`Services\ArchLogger`, extends `UserCacheContextBase`)

- `insert($order, $message, $data = NULL)` — write a row for an order; when `$data` is null and the
  order has an `original`, `buildDefaultData()` stores an `old_values`/`new_values`
  diff (`arrayDiff()`), ignoring `vid`/`revision_timestamp`/`created`/`changed`.
- `storeCartLog($original, $new, $message, $data)` — buffer a cart-change log in private tempstore
  (`arch_logger` / key `cart_log`).
- `saveCartLogs($order)` — flush buffered cart logs into `arch_log` bound to the new order id.
- `getByOrder($order)` / `getByOrderAndId($order, $lid)` — read back (parameterised `select`, `$lid`
  cast to int).

## Hooks (`arch_logger.module`)

- `hook_ENTITY_TYPE_insert(order)` — saves buffered cart logs (when the order owner is the current
  user) then logs "Order created.".
- `hook_ENTITY_TYPE_update(order)` — logs "Order changed." or "Order status changed." on a status
  transition.
- `hook_entity_operation_alter()` — adds a **History** operation (to `entity.order.history`) on
  orders the user can `view` and holds `view order history`.

## Event subscriber (`Services\EventSubscriber`)

On `KernelEvents::REQUEST` / `FINISH_REQUEST`, for **POST** requests to `arch_cart.content` /
`arch_cart.api.cart_add` / `cart_quantity` / `cart_remove`, snapshots the cart before/after
(`@arch_cart_handler`) and calls `storeCartLog()` with a route-specific message.

## Routes & permission

- `entity.order.history` — `/order/{order}/log` (`LogController::listView`).
- `entity.order.history_item` — `/order/{order}/log/{log_id}` (`LogController::view`; 404 on unknown
  log id).
- Both require **`view order history`** (`arch_logger.permissions.yml`) **and**
  `_access_order_revision: 'view'` (per-order access, enforced by `arch_order`), `order: \d+`.

## Notes

- `LogController::view()` renders the stored `data` via `var_export(unserialize($log->data), TRUE)`.
  The `data` column is always produced by the module's own `serialize()` of order/cart **arrays**
  (server-side), so it round-trips to arrays, not injectable objects.
