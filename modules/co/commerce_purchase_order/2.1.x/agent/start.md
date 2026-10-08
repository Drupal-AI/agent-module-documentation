<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Purchase Order — agent index

Adds a "pay by Purchase Order" payment gateway to Drupal Commerce checkout: an (optionally
pre-approved) customer enters a PO number — and optionally uploads a PO document — the order is
placed as an offline/manual payment (state `authorized`, not paid), and staff mark it received
later. Depends on `commerce`, `commerce_payment`, `profile`, core `file`.

No dedicated settings page (`configure` is null) — everything is configured on the payment
**gateway** entity at `admin/commerce/config/payment-gateways`. Defines one permission, config
schema, four Commerce plugins (gateway / payment-method-type / payment-type / condition), a payment
workflow, an admin View, and several hooks. No Drush commands.

- **Configure the gateway (PO instructions, open-PO limit, approval requirement, file upload)** →
  [configure/payment-gateway.md](configure/payment-gateway.md)
- **Require per-customer approval (the `field_purchase_orders_authorized` user field + form-display)** →
  [configure/user-approval.md](configure/user-approval.md)
- **The permission** → [permissions/permissions.md](permissions/permissions.md)
- **The Commerce plugins, payment workflow, and payment lifecycle** →
  [plugins/plugins.md](plugins/plugins.md)
- **Hooks it implements (field access, receipt instructions, private-file access)** →
  [hooks/hooks.md](hooks/hooks.md)
- **The Purchase Orders admin View** → [views/purchase-orders.md](views/purchase-orders.md)

Key facts:
- Gateway plugin id `purchase_order_gateway` (class `PurchaseOrderGateway`, extends
  `OnsitePaymentGatewayBase`; implements `HasPaymentInstructionsInterface`, `SupportsVoidsInterface`,
  `SupportsRefundsInterface`). Config schema:
  `commerce_payment.commerce_payment_gateway.plugin.purchase_order_gateway` with keys
  `instructions` (value/format), `limit_open` (int, default 1), `user_approval` (bool, default TRUE),
  `file_upload` (bool), `file_extensions` (string, default `pdf`).
- Payment-method-type plugin id `purchase_order` (fields `po_number` string, `po_file` file ref);
  payment-type plugin id `payment_purchase_order`; workflow id `payment_purchase_order`.
- Condition plugin id `commerce_purchase_order_auth` (category Customer) — offer the gateway only to
  approved customers.
- Permission string: `authorize user purchase orders`.
- User field `field_purchase_orders_authorized` (boolean, on `user.user`, installed by this module,
  hidden by default).
- Admin View `purchase_orders` at path `admin/commerce/purchase-orders` (access
  `administer commerce_payment`).
