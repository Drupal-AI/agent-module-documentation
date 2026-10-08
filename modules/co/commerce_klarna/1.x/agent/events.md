<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events & event subscribers

## Events (`src/Event/KlarnaEvents.php`)

All except the shipments event carry a `KlarnaRequestEvent` (`getOrder()`, `getPayload()`,
`setPayload()`), letting subscribers enrich the request body before it is sent to Klarna.

| Constant | Event name | Fired from |
|---|---|---|
| `CREATE_PAYMENT_SESSION` | `commerce_klarna.create_payment_session` | `KlarnaManager::createPaymentSession` / `getKlarnaSettings` |
| `UPDATE_PAYMENT_SESSION` | `commerce_klarna.update_payment_session` | `updatePaymentSession` |
| `CREATE_ORDER_REQUEST` | `commerce_klarna.create_order_request` | `createOrder` / `updateOrder` |
| `CREATE_EXPRESS_ORDER_REQUEST` | `commerce_klarna.create_express_order_request` | `getKlarnaSettings` (express cart) |
| `PAYMENT_CAPTURE_REQUEST` | `commerce_klarna.payment_capture_request` | `captureOrder` |
| `PAYMENT_REFUND_REQUEST` | `commerce_klarna.payment_refund_request` | `refundOrder` |
| `CREATE_CARD_PROMISE` | `commerce_klarna.create_card_promise` | `createCardPromise` (MCS) |
| `EXPRESS_CHECKOUT_SHIPMENTS` | `commerce_klarna.express_checkout_shipments` | `KlarnaExpressCheckout::onCreate` |

`KlarnaShipmentsEvent` (for `EXPRESS_CHECKOUT_SHIPMENTS`) carries `getOrder()`, `getShippingProfile()`,
and `get/setShipments()`.

## Subscribers shipped by this module (`commerce_klarna.services.yml`)

- **`CheckoutCompletionSubscriber`** (`commerce_checkout.completion`, priority -100) — when a completed
  order uses a Klarna gateway and the payment method has no billing profile, it fetches the Klarna order
  and backfills the billing profile onto the method (and the order if it lacks one). Used mainly for
  express checkout where billing isn't collected up front.
- **`OrderCancelSubscriber`** (`commerce_order.cancel.post_transition`, priority -100) — on order
  cancel, voids every non-already-voided Klarna payment on the order (`$plugin->voidPayment()`).
- **`KlarnaExpressShipments`** (submodule `commerce_klarna_shipping`) — see
  [express-checkout.md](express-checkout.md).

## Extending

Subscribe to any `*_REQUEST` / session event and mutate `$event->setPayload($event->getPayload() + [...])` to
add fields (e.g. custom `merchant_data`, attachment, or extra order lines) without patching the module.
The README points integrators at `\Drupal\commerce_klarna\Event\KlarnaEvents` as the canonical list.
