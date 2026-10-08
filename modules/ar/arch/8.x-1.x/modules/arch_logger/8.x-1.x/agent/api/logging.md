<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Arch Logger — service API & log storage

## Install & enable

```bash
drush en arch_logger -y
```

Pulls in `arch_cart` and `arch_order` (both required Arch submodules). `hook_schema()`
(`arch_logger.install`) installs the **`arch_log`** table on enable; uninstall drops it.

## The `arch_log` table

Fields (`arch_logger_schema()`): `lid` (serial PK), `uid` (int), `oid` (int, default 0),
`status` (varchar 50 — the order status machine name), `message` (varchar 255), `data`
(text, `serialize => TRUE`), `created` (int, request time). Indexes: `log_uid` (uid),
`log_oid` (oid). Declared foreign keys to `arch_order.oid` and `users.uid`.

## Service: `arch_logger` (`Services\ArchLogger`)

Constructor args: `@database`, `@tempstore.private`, `@current_user`. Constants
`TABLE_NAME = 'arch_log'`, `CART_STORE_NAME = 'cart_log'`.

| Method | Purpose |
|---|---|
| `storeCartLog(array $original, array $new, $message, ?array $data = NULL)` | Append a `status = 'cart'` entry to the private tempstore buffer. If `$data` is null it is computed as `buildDefaultData($original, $new)`. |
| `saveCartLogs(OrderInterface $order)` | Flush every buffered cart log into `arch_log` (stamping each with the new `oid`), then delete the tempstore buffer. |
| `insert(OrderInterface $order, $message, ?array $data = NULL)` | Insert one row (uid, oid, status = order status, message, serialized data, created). Default `$data` diffs `$order->original` vs current. |
| `getByOrder(OrderInterface $order)` | `SELECT * FROM arch_log WHERE oid = :oid` → `fetchAll()`. |
| `getByOrderAndId(OrderInterface $order, $lid)` | Same filtered by `lid` (cast to int) → `fetch()`. |

Private helpers `buildDefaultData()` / `arrayDiff()` produce `{old_values, new_values}` diffs after
stripping ignored keys (`vid`, `revision_timestamp`, `created`, `changed`).

## When rows are written (hooks in `arch_logger.module`)

- `hook_ENTITY_TYPE_insert` (`order`): if the order's `uid` equals the current user, flush cart logs;
  always `insert(..., 'Order created.')`.
- `hook_ENTITY_TYPE_update` (`order`): compare `original` status to new status → log
  `'Order status changed.'` when they differ, else `'Order changed.'`.
- `hook_entity_operation_alter`: adds a **History** operation (weight 60) linking to
  `entity.order.history` for `order` entities the user can `view` and who hold `view order history`.

## Cart snapshot subscriber (`Services\EventSubscriber`)

Only acts on **POST** requests whose route is one of `arch_cart.content`,
`arch_cart.api.cart_add`, `arch_cart.api.cart_quantity`, `arch_cart.api.cart_remove`. On
`KernelEvents::REQUEST` it stores `cartHandler->getCart()->getValues()` as the original; on
`KernelEvents::FINISH_REQUEST` it reads the new values, maps the route to a message, and calls
`storeCartLog()`. Nothing is persisted to the DB until the order is created.

## Display

`LogController::listView($order)` builds a `#theme => table` of every row for the order (message and
id are `Link::createFromRoute()` to the detail route, status label from `order_status` storage, user
`toLink()`, formatted date). `LogController::view($order, $log_id)` loads one row
(`getByOrderAndId`, 404 if missing) and renders the value diff via
`var_export(unserialize($log->data), TRUE)` inside a `#type => html_tag` `pre`.

## Extending

Any module can inject the `arch_logger` service and call `insert($order, $yourMessage, $yourData)`
to add domain-specific entries (e.g. a payment or shipping event) to the same order history.
