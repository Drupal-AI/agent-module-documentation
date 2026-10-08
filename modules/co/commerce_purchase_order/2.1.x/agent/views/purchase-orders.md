# Purchase Orders admin View

Config `config/install/views.view.purchase_orders.yml` (View id `purchase_orders`).

- Base table: `commerce_payment`.
- Page display path: `admin/commerce/purchase-orders`, menu link "Purchase Orders" (menu
  `admin`), description "A list of purchase orders."
- Access: permission `administer commerce_payment`.
- Pager: mini, 10/page. Cache: tag.
- Contextual filter / relationship scopes rows to payment type `payment_purchase_order` (joined to
  `commerce_order` for the order link).

Displayed fields: **Authorized** (timestamp), **Amount** (`commerce_price_default`), **Status**
(payment state), **Order** (entity link to the order), **Purchase Order** (the payment method
rendered via `entity_reference_entity_view`, i.e. its `Purchase Order# <number>` label), and
**Operations**.

The PO number reaches this View only through the payment-method label built by
`PaymentMethodType\PurchaseOrder::buildLabel()`.
