Syncart submodule that adds a taxonomy-driven order-status workflow and a status-management board to Commerce orders.

---

`syncart_order_status` installs an `order_status` taxonomy vocabulary (with a `field_hidden` flag) and a `field_status` entity-reference field on `commerce_order`, then exposes an AJAX status-change select and an orders-by-status board. `OrderStatusController::list()` (route `/cart/orders/list`) renders a column-per-status board showing each order's number. The `ChangeStatus` form provides an inline AJAX select that calls `Service\Order::setOrderStatus()`. Depends on `synhelper`, `syncart`, and `cache_alter`. Ships a `syncart orders status management` permission and a `syncart_orders` view.

---

- Attach a status taxonomy term to each Commerce order via the `field_status` field.
- Maintain the list of statuses as taxonomy terms in the `order_status` vocabulary.
- Hide selected statuses from the board using the term `field_hidden` flag.
- Show a kanban-style board of orders grouped by status at `/cart/orders/list`.
- Change an order's status inline with an AJAX select (`ChangeStatus` form, `Service\Order::setOrderStatus`).
- Drive an admin orders table via the shipped `syncart_orders` view and `table_management` view mode.
- Preprocess the management orders view rows with the bundled template/hook.
- Add a `pos` order-type status display (config for `commerce_order.pos`).
- Gate status-management UI with the `syncart orders status management` permission.
- Query active orders / orders-by-status through `Service\Order` (`getActiveOrders`, `getOrdersByStatusId`, `getStatuses`).
- Localize the status board (order_status vocabulary is translatable).
