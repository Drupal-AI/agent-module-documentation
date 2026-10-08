<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Order entity, statuses, access & order mail

## `order` content entity — `Entity\Order`

Revisionable `@ContentEntityType` (`id = order`), base table `arch_order`, revision table
`arch_order_revision`, `translatable = FALSE`. Entity keys: `id = oid`, `label = order_number`,
`revision = vid`, `status = status`, `uid = uid`. Handlers: storage `OrderStorage` (+
`OrderStorageSchema`), view builder `OrderViewBuilder`, list builder `OrderListBuilder`, access
`OrderAccessControlHandler`, views data `OrderViewsData`, form `OrderForm` (default/add/edit), route
provider `Routing\OrderRouteProvider`. Links: collection `/admin/store/orders`, canonical
`/order/{order}`, edit `/admin/store/order/{order}/edit`, revisions.

### Base fields

`order_number`, `erp_id`, `status` (→ `order_status`), `uid` (customer/owner), `mail`,
`payment_method`, `shipping_method`, `subtotal_net` / `subtotal_gross` / `subtotal_vat_amount`,
`grandtotal_net` / `grandtotal_gross` / `grandtotal_vat_amount`, `currency`, `created`, `changed`,
`billing_address`, `shipping_address`, `line_items` (field type `order_line_item`), `data`.
`Order::updateTotal()` recomputes totals from line items + shipping/payment fees.

Addresses are also mirrored into the `arch_order_address` table (`arch_order_schema()` install hook)
by `Services\OrderAddressService` (`order.address`), keyed by `order_id` + `address_type`.

## `order_status` config entity — `Entity\OrderStatus`

`@ConfigEntityType` (`id = order_status`, admin perm `administer order status configuration`),
`config_export`: `id, label, weight, description, default, locked`. Managed at
`/admin/store/order-statuses` (list/add/edit/delete forms). Shipped statuses (`config/install`):

| id | label | default | locked |
|---|---|---|---|
| `cart` | Cart | **true** | true |
| `processing` | Processing | false | true |
| `completed` | Completed | false | true |

`Services\OrderStatusService` (`order.statuses`): `load()`, `getDefaultOrderStatus()` (the one with
`default: true` → `cart`), `getOrderStatuses($locked)` (ALL / LOCKED / UNLOCKED, sorted by weight).
New orders start in the default (`cart`) status; `arch_checkout` transitions to `completed`.

## Access — grant based

`OrderAccessControlHandler` (extends `EntityAccessControlHandler`):

- `bypass order access` → always allowed.
- Requires `view order` at minimum (else forbidden).
- `checkAccess()`: an **authenticated** owner (`$account->id() == $order->getOwnerId()`) may `view`
  their own order; otherwise access is decided by `OrderGrantDatabaseStorage` (`order.grant_storage`)
  — a node-style realm/gid grant table populated from `hook_order_access_records` (default grant:
  realm `all`, gid 0, `grant_view = 1`).
- `checkFieldAccess()`: administrative fields (`uid`, `status`, `created`, `promote`, `sticky`) are
  editable only with `administer orders`; `revision_timestamp`/`revision_uid` are read-only.
- `createAccess()` needs `create order`.

Permissions of note: `administer orders`, `view any order`, `list orders`,
`view/revert/delete all order revisions`, `administer order settings`,
`administer order email settings`.

## Order mail — `OrderMail` plugin type

Manager `arch_order_mail` (`OrderMail\OrderMailManager`, discovery `OrderMail/Plugin`, annotation
`@OrderMail`, interface `OrderMailInterface`, base `OrderMailBase`). Shipped plugins:

- `OrderConfirmationToUserMail` — confirmation to the customer.
- `OrderConfirmationToShopMail` — notification to the shop.
- `OrderModificationMail` — order changed.
- `OrderStatusChangeMail` — status changed.

Admin UI at `/admin/store/settings/mail…` (perm `administer order email settings`): list, view,
enable/disable, add/edit/delete per-language translations (`OrderMail\Controller\*` + `Form\MailForm`).
Bodies run through core `token`.

## Dashboard panel

`Plugin\StoreDashboardPanel\OrderCount` renders an order counter on the `/admin/store` dashboard
(the `store_dashboard_panel` type from the base `arch` module).
