<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Payment flow, routes & callbacks

Off-site payment gateway plugin `klarna_payments`
(`src/Plugin/Commerce/PaymentGateway/Klarna.php`, extends `OffsitePaymentGatewayBase`,
implements `SupportsAuthorizationsInterface`, `SupportsNotificationsInterface`,
`SupportsRefundsInterface`). `requires_billing_information = FALSE`.

## Checkout → authorization

1. **Offsite form** (`PluginForm/OffsiteRedirect/KlarnaOffsiteForm.php`) calls
   `ApiManager::sessionRequest($order)`, which builds a Klarna credit session from the
   **Commerce order** (server-side amounts) via `Request/Payment/RequestBuilder::createSessionRequest()`
   and creates/updates it through Klarna's authenticated Sessions API. The session response is passed to
   `drupalSettings.klarnaPayments`; the Klarna JS SDK (`js/dist/klarna.js`, riot component mounting on
   `#klarna-mount`, external `https://x.klarnacdn.net/kp/lib/v1/api.js`) renders the widget and writes
   the **authorization token** into a hidden field (`data-klarna-selector="authorization-token"`). The
   Continue button stays disabled until a token is present.
2. On submit the form redirects (GET) to route **`commerce_klarna_payments.redirect`**
   (`/commerce_klarna_payments/{commerce_order}/{commerce_payment_gateway}`), guarded by
   `_custom_access: CheckoutController::checkAccess`. `RedirectController::handleRedirect()` reads the
   posted `payment_process[offsite_payment][klarna_authorization_token]` and calls
   `ApiManager::authorizeOrder($order, $token)`, which POSTs a `CreateOrderRequest` (server-side amounts)
   to Klarna's authenticated Payments Orders API. The returned Klarna `order_id` is stored on the order
   as `klarna_order_id`, then the browser is redirected to `$response->getRedirectUrl()`.

## Marking paid — three independent paths, all API-verified

All three re-fetch the Klarna order from the authenticated Order Management API
(`ApiManager::getOrder()` uses the stored `klarna_order_id`) and only proceed on status in
`['AUTHORIZED','PART_CAPTURED','CAPTURED']`. The Commerce payment amount is the server-side
`$order->getBalance()` — never a request value. `getOrCreatePayment()` is idempotent (reloads any
existing payment for the order+gateway).

- **Browser return** — `Klarna::onReturn()` (standard `commerce_payment.checkout.return`). Re-fetches,
  validates status, `getOrCreatePayment()`, `acknowledgeOrder()`.
- **Async push** — route **`commerce_klarna_payments.push`**
  (`/commerce_klarna_payments/{commerce_order}/{commerce_payment_gateway}/push`, POST, `_access: 'TRUE'`),
  `PushEndpointController::handleRequest()`. Requires query `klarna_order_id` to strictly match the
  order's stored `klarna_order_id` (else plain 200 "does not match"); short-circuits if already paid;
  re-fetches from Klarna, validates status (else `AccessDeniedHttpException`), `getOrCreatePayment()`,
  `acknowledgeOrder()`. The push URL is registered with Klarna by `RequestBuilder` as
  `.../push&klarna_order_id={order.id}` (Klarna substitutes its order id).
- **Order completion** — `EventSubscriber/OrderTransitionSubscriber::onOrderPlace()` (pre-transition on
  `place`/`validate`/`fulfill` → `completed`) captures the payment if not already paid;
  `updateOrderNumberOnPlace()` (post `place`) writes the Commerce order number back to Klarna as
  `merchant_reference1`.

## Fraud notifications

`Klarna::onNotify()` (standard `commerce_payment.notify`) handles Klarna fraud webhooks. Loads the order
from the `commerce_order` query param, decodes the JSON body, and requires `body.order_id` to strictly
match the stored `klarna_order_id`. Dispatches a fraud event via `ApiManager::handleNotificationEvent()`;
if `cancel_fraudulent_orders` is on and the event is `FRAUD_RISK_REJECTED`/`FRAUD_RISK_STOPPED`, cancels
the order and voids the Klarna payment. `hook_form_alter()` (`.module`) surfaces PENDING/REJECTED fraud
status as warnings on the order state-transition form.

## Management operations

`capturePayment()` → `ApiManager::createCapture()` (captures via Order Management, re-fetches to resolve
the new capture id). `voidPayment()` → `cancelOrder`. `refundPayment()` → `refundOrder` with a
per-refund idempotency key derived from `payment->uuid() . '-' . newRefundedAmount`.
