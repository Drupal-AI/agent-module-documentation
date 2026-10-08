<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Order (arch_order) — agent index

Defines the Order entity, order statuses, order access grants, admin screens and order emails for
the Arch suite. Depends on `entity`, `views`, `editor`, `arch`, `arch_product`. Project `arch`
(`8.x-1.0-alpha26`). Submodules: `arch_order_invoice`, `arch_order_statistics`.

- **The Order + OrderStatus entities, access, statuses & order mail** → [entities/order.md](entities/order.md)

## Provides

- Content entity **`order`** (`Entity\Order`, base table `arch_order`, revision table
  `arch_order_revision`; entity keys id=`oid`, label=`order_number`, status=`status`, uid=`uid`).
  Storage `OrderStorage` (+ `OrderStorageSchema`), access `OrderAccessControlHandler`, route
  provider `Routing\OrderRouteProvider`, views data `OrderViewsData`.
- Config entity **`order_status`** (`Entity\OrderStatus`, admin perm
  `administer order status configuration`); ships `cart` (default), `processing`, `completed`
  (`config/install`); schema `config/schema/order_status.schema.yml`.
- Service **`order.statuses`** (`Services\OrderStatusService`), **`order.address`**
  (`Services\OrderAddressService`, table `arch_order_address` from `hook_schema`),
  **`order.grant_storage`** (`Access\OrderGrantDatabaseStorage`).
- Access checks: `access_check.order.add` (`_order_add_access`), `access_check.order.revision`
  (`_access_order_revision`).
- Plugin type **`order_mail`** — manager service `arch_order_mail`
  (`OrderMail\OrderMailManager`, discovery `OrderMail/Plugin`, annotation `@OrderMail`, interface
  `OrderMailInterface`, base `OrderMailBase`). Shipped plugins: `OrderConfirmationToUserMail`,
  `OrderConfirmationToShopMail`, `OrderModificationMail`, `OrderStatusChangeMail`.
- Field plugins: type `order_line_item` (`FieldType\OrderLineItemFieldItem`) + widget
  `OrderLineItemWidget` + formatters `OrderLineItemFormatter` / `OrderAdvancedLineItemFormatter`;
  `order_status` field item + `OrderStatusesSelectWidget` + `OrderStatusFormatter`; DataTypes
  `OrderStatus` / `OrderStatusReference`; Views filter `OrderStatusFilter`; element
  `OrderStatusesSelect`. Dashboard panel `Plugin\StoreDashboardPanel\OrderCount`.
- Permissions (`arch_order.permissions.yml`): `bypass order access`, `administer orders`,
  `administer order settings`, `administer order email settings`, `list orders`, `view order`
  (own), `view any order`, `create order`, `view/revert/delete all order revisions`,
  `administer order status configuration`.

## Key routes (`arch_order.routing.yml`)

- `entity.order.collection` `/admin/store/orders` (`administer orders`), `order.add` `/order/add`
  (`_order_add_access`), revisions `/order/{order}/revisions…` (`_access_order_revision`),
  order settings `/admin/store/orders/settings` (`OrderSettingsForm`), order-status CRUD under
  `/admin/store/order-status…`, and order-mail admin under `/admin/store/settings/mail…`
  (`administer order email settings`).
- Canonical order view `/order/{order}` (grant-checked via the access handler).
