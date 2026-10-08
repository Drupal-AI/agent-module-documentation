<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Order Amend — agent index

Back-office module that adds an **"Amend Order" tab** to *placed* (non-draft) Drupal Commerce orders,
giving staff a single guided form to **swap an item's variation, add an item, remove an item, add a
coupon, or remove a coupon** after checkout. Wraps each change with a forced order refresh, price
protection, balance-delta reporting, a Commerce Log audit entry, an amendment-type tag for Views, and
an `OrderAmendEvent` for integrations. Depends on `commerce:commerce_order` and
`commerce:commerce_promotion`; optionally integrates `commerce_stock`. Version **1.0.0**,
core `^10 || ^11`, PHP 8.1+. No Drush commands, no JS, no templates.

- **The five operations + the manager internals (refresh, price-lock, balance, snapshot/diff)** →
  [operations.md](operations.md)
- **Extending it (OrderAmendEvent, OrderAmendType enum, amendment_types field, log templates, Views)** →
  [extending.md](extending.md)

## Routes / entry points

- `commerce_order_amend.form` — `/admin/commerce/orders/{commerce_order}/amend`, renders
  `Form\AmendOrderForm`. Local task ("Amend Order" tab, weight 20) on the order canonical route.
  Access: `_custom_access` → `Access\OrderAmendAccessCheck::accessItems` = permission
  **`edit commerce order items`** AND the order's current state is in the configured `editable_states`.
- `commerce_order_amend.settings` — `/admin/commerce/config/order-amend`, renders `Form\SettingsForm`.
  Access: `_permission: 'administer commerce order amend'`. Menu link under `commerce.configuration`.

## Permissions (`commerce_order_amend.permissions.yml`)

- `edit commerce order items` — swap/add/remove items on orders in editable states. This permission
  gates access to the unified amend form (`accessItems`), which hosts all operations including the
  coupon operations; grant it to staff who should be able to amend orders.
- `edit commerce order coupons` — the module also defines this permission (with
  `OrderAmendAccessCheck::accessCoupons`) for add/remove-coupon authorization.
- `administer commerce order amend` — `restrict access: true`; gates the settings form.

## Configuration (`commerce_order_amend.settings`)

Config object with two keys (schema in `config/schema/`):
- `editable_states` (sequence of state IDs) — which order-workflow states show the tab and allow
  amending. Install default: `pending_payment, paid_order, processing, ready_to_ship`.
- `validate_stock` (bool, default `true`) — when Commerce Stock is present, block swap/add if the
  target variation lacks stock (variations flagged `commerce_stock_always_in_stock` are exempt).

`SettingsForm` builds the state checkboxes by iterating every `commerce_order_type` workflow's states
via the `plugin.manager.workflow` service.

## Services

- `commerce_order_amend.manager` → `Service\OrderAmendManager` (args: `entity_type.manager`,
  `current_user`, `event_dispatcher`, `config.factory`). Holds all business logic; the form is a thin
  UI over it. See [operations.md](operations.md).

## Key facts

- **Order refresh is forced.** Commerce core skips `OrderRefresh` on placed orders (issue #2875804);
  this module calls `setRefreshState(REFRESH_ON_SAVE)` + `save()` after every op so totals, promotions
  and taxes recompute **server-side**.
- **Prices are locked before refresh.** `refreshAndSave()` sets `overridden_unit_price` (via
  `setUnitPrice($price, TRUE)`) on all items so the refresh's price-resolver chain does not
  re-resolve them into the admin's session context (wrong country/currency). Swapped/added items keep
  the original/created price unless staff tick "Override the unit price".
- **Balance is recomputed server-side and reported.** After refresh the manager computes the total
  delta (`calculateBalanceChange`) and the form shows the order's `getBalance()` with guidance to
  collect a payment or issue a refund (`addPaymentGuidance`). Actual payment collection / refund is a
  deliberate manual staff step performed on the Payments tab (as in Commerce core), so confirm it
  after a balance-changing amendment.
- **Refresh side effects are surfaced.** `captureOrderSnapshot` before + `diffOrderSnapshot` after the
  refresh produce human-readable warnings (unit-price changes, promotions/tax added/removed/changed,
  per-item adjustments) with a link to the order edit form.
- **Audit + tracking.** Every op writes a `commerce_log` entry (templates prefixed "Order Amended",
  see `commerce_order_amend.commerce_log_templates.yml`) and appends the op type to the order's
  `amendment_types` base field (added by `hook_entity_base_field_info`, string, unlimited cardinality,
  view-configurable) for Views filtering.
- **Ownership.** Access is a store-wide permission (no per-order owner check); item operations validate
  that the selected order item actually belongs to the routed order. Grant the permissions only to
  trusted order administrators.
