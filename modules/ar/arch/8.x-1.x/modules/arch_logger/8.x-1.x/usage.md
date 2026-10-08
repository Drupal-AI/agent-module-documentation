Records and displays a per-order audit log of order and cart changes in an Arch store.

---

`arch_logger` keeps a history of what happened to each Arch order. It creates an `arch_log` table (`hook_schema()`) and an `arch_logger` service that inserts a row on order insert ("Order created."), on order update ("Order changed." / "Order status changed."), and for cart activity. An `EventSubscriber` (kernel REQUEST + FINISH_REQUEST) snapshots the cart before and after POSTs to the cart add/quantity/remove routes, records human-readable messages, and stashes them in a private tempstore; those pending cart logs are flushed into the database against the new order when it is created. Each log row stores the acting user, order id, order status, message, timestamp, and a serialized `data` field holding an old-values/new-values diff of the order. Store staff review the history per order at `/order/{order}/log` (list) and `/order/{order}/log/{log_id}` (detail), reachable via a "History" order operation, all gated by the `view order history` permission plus per-order revision view access.

---

- Keep an audit trail of every change to an order.
- Log when an order is created, edited, or has its status changed.
- Record cart activity (product added, quantity changed, product removed) leading up to an order.
- Attach pre-checkout cart history to the order it becomes.
- Show a per-order "Logs" page listing all history entries with message, status, user and date.
- Drill into a single log entry to see the exact old/new field diff.
- Add a "History" operation link to orders in admin listings.
- Restrict who can read order history via the `view order history` permission.
- Enforce per-order access on the history pages (revision view access).
- Capture who made each change (the acting user id is stored on every row).
- Track order-status transitions over time for fulfilment auditing.
- Provide a serialized details blob for debugging what changed on an order.
- Support customer-service workflows ("what did this customer do before ordering?").
- Index logs by order and by user for efficient retrieval.
- Integrate automatically with `arch_cart` and `arch_order` (no configuration required).
- Give merchants a lightweight built-in alternative to a full external audit system.
