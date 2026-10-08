<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extension points: events, request builder, shipment splitter

## Events

Constants in `Event\KlarnaCheckoutEvents`. Two event classes carry them:
`OrderRequestEvent` (mutable request data — `getRequestData()` / `setRequestData()`) and
`KlarnaOrderEvent` (read-only `getKlarnaOrder()` array + `getOrder()`).

| Constant | Value | Event class | Fired |
| --- | --- | --- | --- |
| `CREATE_ORDER_REQUEST` | `commerce_klarna_checkout.create_order_request` | `OrderRequestEvent` | Before `KlarnaOrder::create()`. |
| `UPDATE_ORDER_REQUEST` | `commerce_klarna_checkout.update_order_request` | `OrderRequestEvent` | Before updating the Klarna order. |
| `UPDATE_AUTHORIZATION_REQUEST` | `commerce_klarna_checkout.update_authorization_request` | `OrderRequestEvent` | Before `updateAuthorization()`. |
| `PAYMENT_CAPTURE_REQUEST` | `commerce_klarna_checkout.payment_capture_request` | `OrderRequestEvent` | Before `createCapture()`. |
| `PAYMENT_REFUND_REQUEST` | `commerce_klarna_checkout.payment_refund_request` | `OrderRequestEvent` | Before `refund()`. |
| `ORDER_VALIDATION` | `commerce_klarna_checkout.order_validation` | `KlarnaOrderEvent` | During the validation callback. |
| `ACKNOWLEDGE_ORDER` | `commerce_klarna_checkout.acknowledge_order` | `KlarnaOrderEvent` | During acknowledge (after re-fetch). |

Subscribe to the `*_REQUEST` events and call `setRequestData()` to alter the outgoing Klarna
payload (e.g. add attachments, custom order lines, options).

### Built-in subscribers

`EventSubscriber/KlarnaEventSubscriber`:
- `onAcknowledge` (`ACKNOWLEDGE_ORDER`) — if `update_billing_profile` / `update_shipping_profile`
  are set, populates the Commerce profile(s) from the Klarna address (field mapping in
  `populateProfile()`, creating an anonymous customer profile if none exists).
- `onValidate` (`ORDER_VALIDATION`) — throws `PaymentGatewayException` if the Klarna
  `order_amount` does not equal the Commerce order total.

`EventSubscriber/OrderSubscriber` — `commerce_order.cancel.post_transition` → cancel/void.

## RequestBuilder

`RequestBuilder` (service `commerce_klarna_checkout.request_builder`, also aliased to its
interface) turns a Commerce order into the Klarna order payload:

- `buildOrder()` — currency, store name, `order_lines`, `order_amount` (minor units),
  `merchant_reference1` (order number) / `merchant_reference2` (order **id** — the binding key),
  allowed billing/shipping countries from the store, billing address + email, and `order_tax_amount`.
- `buildOrderLines()` — one line per order item (SKU as `reference` for product variations,
  included-tax rate in basis points, promotion discounts), plus non-included adjustments
  (`tax`→`sales_tax`, `fee`→`surcharge`), plus shipping lines. Shipping with included tax across
  multiple rates is delegated to the shipment splitter.
- `buildAddress()` — maps a Commerce profile address to Klarna address keys.

`KlarnaManager::buildOrderRequest()` wraps this: validates required merchant URLs
(`checkout`/`confirmation`/`push`, and a `klarna_validation_destination` on any `validation` URL),
builds the terms URL from `terms_path`, and adds `options` (allowed customer types, separate
shipping, `require_validate_callback_success`).

## ShipmentPriceSplitter

`ShipmentPriceSplitter` (registered as `commerce_klarna_checkout.shipment_price_splitter` **only
when `commerce_shipping` is enabled**, via `CommerceKlarnaCheckoutServiceProvider`; injected
optionally into `RequestBuilder` with `setShipmentPriceSplitter`). `split()` allocates a shipment's
amount, discount, and tax across the order's tax-rate groups (proportional to each group's share of
the subtotal) so Klarna receives shipping order lines whose tax amounts match their declared rates
even when the order mixes taxed and tax-exempt items.
