<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Arch Order defines the Order entity for the Arch suite — a revisionable record of a customer's purchase (line items, addresses, totals, currency and status) — plus configurable order statuses, an order access-grant system, admin management screens and per-status order emails.

---

`arch_order` provides the `order` content entity (`Entity\Order`, base table `arch_order`,
revisionable, label = order number) with base fields for order number, ERP id, status, customer
(uid) and email, payment/shipping method, subtotal and grand-total net/gross/VAT amounts, currency,
billing and shipping addresses, line items (a custom `order_line_item` field type) and a free-form
`data` field. Order status is a config entity (`order_status`, e.g. the shipped `cart`, `processing`,
`completed`) managed at `/admin/store/order-statuses`; the `order.statuses` service
(`OrderStatusService`) loads and sorts them and exposes the default. Access uses a node-style grant
system: `OrderAccessControlHandler` + `OrderGrantDatabaseStorage` (hooks `order_access_records` /
`order_grants`), with permissions such as `view order` (own), `view any order`, `administer orders`
and `bypass order access`; a customer can view their own order, and modules can widen access via
grants. Admin routes cover an order collection/list, add/edit forms, a full revision history
(view/revert), order settings and order-status CRUD. Order emails are plugins of the `OrderMail`
type (`arch_order_mail` manager) — the module ships confirmation-to-customer, confirmation-to-shop,
order-modification and status-change mails, editable/translatable at `/admin/store/settings/mail`.
It also supplies field widgets/formatters for line items and status, a `views` data integration,
optional order views, and an `OrderCount` store-dashboard panel. Addresses are persisted in a
dedicated `arch_order_address` table via `OrderAddressService`. Depends on `entity`, `views`,
`editor`, `arch` and `arch_product`.

---

- Store each purchase as a revisionable Order entity.
- Record customer, email, billing address and shipping address per order.
- Store order line items with quantities and prices.
- Track order subtotal, grand total and VAT amounts in a currency.
- Move orders through configurable statuses (cart, processing, completed, custom).
- Add, edit, reorder and delete order statuses in the UI.
- Mark a default order status new orders receive.
- List and search all orders in the admin at `/admin/store/orders`.
- Add or edit an order manually as a shop operator.
- View an order's full revision history and revert to an earlier revision.
- Let customers view their own orders but not others' (grant-based access).
- Grant "view any order" or full "administer orders" to staff roles.
- Widen or restrict order visibility via `hook_order_access_records` / `hook_order_grants`.
- Send an order confirmation email to the customer.
- Send an order notification email to the shop.
- Send an email when an order is modified.
- Send an email when an order's status changes.
- Translate and customise each order email per language.
- Expose orders to Views (including the shipped orders / user-orders views).
- Show an order-count panel on the store dashboard.
- Store an ERP id on an order for external-system integration.
- Attach arbitrary structured data to an order via its `data` field.
- Provide the Order entity that cart, checkout, payment and statistics submodules read and write.
