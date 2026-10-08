# Configure the Purchase Order payment gateway

There is no module settings form. You add/edit a payment gateway entity at
`admin/commerce/config/payment-gateways` and pick plugin **Purchase Orders**
(`purchase_order_gateway`). The gateway plugin's form is built by
`PurchaseOrderGateway::buildConfigurationForm()`.

## Gateway configuration fields

| Form field | Config key | Type | Default | Effect |
|---|---|---|---|---|
| Limit maximum open purchase orders | `limit_open` | integer | `1` | At checkout authorization the payment is denied if the customer already has this many (or more) `authorized`/unpaid PO payments. `#min` is 1. |
| Purchase order users require approval… | `user_approval` | boolean | `TRUE` | When TRUE, the customer's `field_purchase_orders_authorized` value is checked at authorization; an unapproved customer is declined. See [user-approval.md](user-approval.md). |
| Payment instructions | `instructions` | text_format (`value` + `format`) | empty / `plain_text` | Formatted text shown at end of checkout and in the order-receipt email. Rendered as `#type => processed_text`. |
| Allow file upload for purchase order payment method | `file_upload` | boolean | `FALSE` | Lets the customer attach a PO document. **Force-disabled unless a Drupal private file system is configured** (`PrivateStream::basePath()`); `submitConfigurationForm()` re-forces it to FALSE when private files are absent. |
| Allowed file extensions | `file_extensions` | string | `pdf` | Space/comma separated allowlist, validated by core `FileItem::validateExtensions` (`::validateExtensions` wrapper). Only visible when `file_upload` is checked. |

`defaultConfiguration()` also seeds `payment_method_types => ['purchase_order']` plus the
`OnsitePaymentGatewayBase` defaults (`display_label`, `mode`, `collect_billing_information`, etc.).

## Config schema

`config/schema/commerce_purchase_order.schema.yml` →
`commerce_payment.commerce_payment_gateway.plugin.purchase_order_gateway` (extends
`commerce_payment_gateway_configuration`). Stored inside the gateway entity's `configuration` mapping.

## Set the plugin configuration with PHP

```php
$gateway = \Drupal\commerce_payment\Entity\PaymentGateway::create([
  'id' => 'purchase_order',
  'label' => 'Purchase Orders',
  'plugin' => 'purchase_order_gateway',
]);
$gateway->setPluginConfiguration([
  'limit_open' => 3,
  'user_approval' => TRUE,
  'instructions' => ['value' => 'Mail your remittance to…', 'format' => 'basic_html'],
  'file_upload' => TRUE,
  'file_extensions' => 'pdf doc docx',
  'display_label' => 'Purchase Orders',
  'mode' => 'live',
]);
$gateway->save();
```

## Restricting who is offered the gateway

Enabling `user_approval` only *declines* an unapproved customer at authorization (they can still see
and start the PO checkout). To hide the gateway entirely from unapproved customers when several
gateways are enabled, add the **Customer → Limit by field: Purchase Orders Authorized** condition
(`commerce_purchase_order_auth`) on the gateway's Conditions. See
[../plugins/plugins.md](../plugins/plugins.md).
