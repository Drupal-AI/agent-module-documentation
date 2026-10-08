<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Order status to SynCart (syncart_order_status) — agent index

Syncart submodule adding a taxonomy-driven order-status workflow to Commerce orders.
Core `^11 || ^12`. Package Synapse. Depends on `synhelper`, `syncart`, `cache_alter`.

## Provides
- **Config install** (`config/install/**`): `order_status` taxonomy vocabulary; `field_status`
  entity-reference on `commerce_order` (default + `pos` bundles); `field_hidden` boolean on the
  `order_status` term; `commerce_order.table_management` view mode; `syncart_orders` view;
  content-translation settings.
- **Route** (`syncart_order_status.routing.yml`): `syncart_order_status.orders_list`
  → `/cart/orders/list` → `Controller\OrderStatusController::list()` (board grouped by status,
  renders order numbers). `OrderStatusController::orders()` is a DEPRECATED, unrouted method.
- **Form**: `Form\ChangeStatus` — inline AJAX status `select`; `ajaxSubmit()` calls
  `Service\Order::setOrderStatus($order_id, $status)`.
- **Service** (`syncart_order_status.services.yml`): `syncart_order_status.order` → `Service\Order`
  (`getActiveOrders`, `getStatuses`, `getOrdersByStatusId`, `getBillingInformation`, `setOrderStatus`).
- **Hooks** (`src/Hook/*`): `CommerceOrderView`, `Theme`, and a management-view preprocess.
- **Permission** (`syncart_order_status.permissions.yml`): `syncart orders status management`.
- Menu/task links: `syncart_order_status.links.menu.yml`, `.links.task.yml`.

## Parent
See `../../../3.0.x/agent/start.md` for the Syncart module.
