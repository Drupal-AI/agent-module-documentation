<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Gateway plugin: config, modes, capture/void/refund

Class: `Drupal\commerce_klarna_checkout\Plugin\Commerce\PaymentGateway\KlarnaCheckout`
(extends `OffsitePaymentGatewayBase`, implements `KlarnaCheckoutInterface`).

Plugin annotation: id `klarna_checkout`, label/display_label "Klarna Checkout",
`requires_billing_information = FALSE`, offsite form
`PluginForm\OffsiteRedirect\KlarnaCheckoutForm`. Configured as a
`commerce_payment.commerce_payment_gateway.plugin.klarna_checkout` config entity.

## Configuration fields

Defaults from `defaultConfiguration()`; schema in
`config/schema/commerce_klarna_checkout.schema.yml`:

| Key | Type | Default | Meaning |
| --- | --- | --- | --- |
| `username` | string | `''` | Klarna/Kustom API username (merchant id). Required. |
| `password` | string | `''` | Klarna/Kustom API shared secret. Required. |
| `capture` | bool | `FALSE` | Transaction mode. `TRUE` = authorize **and** capture on acknowledge; `FALSE` = authorize only (manual capture later). |
| `purchase_country` | string | `''` | Purchase country (AT/AU/DK/FI/DE/NL/NO/SE/CH/GB/US). Required. |
| `locale` | string | `sv-se` | Klarna checkout locale (e.g. `en-gb`, `de-de`). Required. |
| `terms_path` | path | `''` | Terms & conditions page; internal path or external URL. Required. |
| `enable_order_validation` | bool | `FALSE` | Add a validation merchant URL so Klarna calls back before completing (see checkout-flow.md). |
| `update_billing_profile` | bool | `TRUE` | Copy the address the customer entered at Klarna into the Commerce billing profile on acknowledge. |
| `update_shipping_profile` | bool | `FALSE` | Same for the shipping profile; form field only shown when `commerce_shipping` is enabled. |
| `allowed_customer_types` | sequence | `[]` | `person` and/or `organization`. |
| `allow_separate_shipping_address` | bool | `FALSE` | Allow different billing/shipping addresses in the Klarna widget. |
| `log_requests` | bool | `FALSE` | Log Klarna API request payloads to the `commerce_klarna_checkout` channel (debug). |

`mode` (`test`/`live`) is the inherited Commerce gateway field; `KlarnaManager::initConnector()`
maps it to `ConnectorInterface::TEST_BASE_URL` vs `::BASE_URL` (library constants — the endpoint
is not otherwise configurable).

## Payment operations

- **Acknowledge / create payment** — `acknowledgeOrder()` (called from `onNotify`/`onReturn`).
  Skips if a payment already exists for the remote id (`loadByRemoteId`, idempotent). Otherwise
  re-fetches the Klarna order via `KlarnaManager::acknowledgeKlarnaOrder()` and creates a payment
  in state `authorization` with amount = Klarna `order_amount`/`purchase_currency`,
  `remote_id` = Klarna order id, `remote_state` = Klarna status. If `capture` is on, immediately
  calls `capturePayment()`.
- **capturePayment()** — asserts `authorization` state; `captured_amount` in minor units via
  `KlarnaManager::createCapture()`; sets payment `completed`. On failure it re-fetches the Klarna
  order (`loadCompletedOrder`) and, if already `CAPTURED`, reconciles the payment as completed
  instead of throwing.
- **voidPayment()** — asserts `authorization`; `cancelKlarnaOrder()`; state → `voided`.
- **refundPayment()** — asserts `completed`/`partially_refunded`; `createRefund()` with
  `refunded_amount` (minor units); sets `partially_refunded` or `refunded`.
- **cancelOrder()** — voids all Klarna payments of the order (used by `OrderSubscriber` on order
  cancel).

## URLs

- `getNotifyUrl()` → Commerce notify route with `?klarna_order_id={checkout.order.id}` (Klarna
  substitutes the placeholder) — the **push** URL.
- `getValidationUrl()` → same notify route with `?callback=validation&klarna_order_id=...` — used
  only when `enable_order_validation` is on.
