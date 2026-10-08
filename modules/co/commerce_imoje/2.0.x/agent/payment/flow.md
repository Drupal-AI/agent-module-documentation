<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Payment flows: offsite redirect, BLIK, IPN & API client

Two checkout flows share one IPN handler and one API client.

## 1. Off-site redirect (`imoje_redirect`)

`PluginForm/ImojeRedirect/ImojePaymentForm::buildConfigurationForm()` builds the parameters
POSTed to imoje's paywall, entirely from server-side order/payment data:

- `serviceId`, `merchantId`, `service_key` — from the gateway configuration;
- `amount` — `(int) $plugin->getPriceInLowestNominal($payment->getAmount())->getNumber()`
  (minor units; `getPriceInLowestNominal()` multiplies by `10^fractionDigits` of the
  currency), `currency` from the payment;
- `orderId`, `orderDescription`, `customerEmail`, optional `customerFirstName`/`LastName`
  from the billing profile;
- `urlSuccess` = `getReturnUrl()` (`commerce_payment.checkout.return`),
  `urlReturn`/`urlFailure` = `getCancelUrl()` (`commerce_payment.checkout.cancel`);
- `visibleMethod` = the configured `payment_methods` joined by commas, when set.

It then computes a **signature** with
`ImojeOffsitePaymentGatewayBase::createSignature($parameters, $service_key, 'sha256')` and
appends `signature = <hash>;sha256`. `createSignature()` calls `prepareData()` which
`ksort()`s the array, flattens nested keys as `prefix[key]=value`, joins with `&`, and
returns `hash($hashMethod, $data . $serviceKey)`. The redirect target is
`ImojeRedirect::FRONT_SANDBOX_URL` (`sandbox.paywall.imoje.pl/payment`) or
`FRONT_PROD_URL` (`paywall.imoje.pl/payment`) by `getMode()`. Delivered via Commerce's
`buildRedirectForm()`.

`onReturn()` / `onCancel()` (in `ImojeOffsitePaymentGatewayBase`) add a status/error
message. The authoritative payment record is created by the IPN (section 3).

## 2. On-site BLIK (`imoje_blik`)

- `commerce_imoje_form_commerce_checkout_flow_alter()` (`.module`) adds the BLIK text input
  to the **review** step when the order's gateway base id is `imoje_blik` and the total is
  positive, hiding the default checkout actions. `ImojeBlikForm` is the offsite-payment
  fallback used when there is no review step.
- `BlikPaymentFormBuilder::build()` renders a 6-digit `maxlength` textfield, attaches the
  `commerce_imoje/blik_payment_form` library, and passes two per-order URLs in
  `drupalSettings.blikPaymentForm`: `onCreateUrl` and `onCheckUrl`.
- `js/blik-payment-form.js`: on a valid 6-digit code it POSTs the code to `onCreateUrl`,
  shows a "confirm in your app" overlay, then polls `onCheckUrl` every 10s (up to 120s).
- Routes (`commerce_imoje.routing.yml`), both `_format: json` and guarded by
  **`_entity_access: 'commerce_order.update'`**:
  - `commerce_imoje.blik_transaction.create` →
    `BlikController::createTransaction()` — reads the BLIK code from the JSON body and calls
    `ImojeGateway::createBlikTransaction($order, $gateway, $blik_code, $request->getClientIp())`,
    returning the imoje transaction `id`. API/other errors are logged and returned as a
    generic 400 JSON message.
  - `commerce_imoje.blik_transaction.process` →
    `BlikController::resolveOrderStatus()` — returns `{redirectUrl: getReturnUrl()}` **only
    when `$order->isPaid()`**, otherwise `{status: 'pending'}`. So the shopper is advanced
    only after the IPN has recorded a completed payment.

`ImojeGateway::createBlikTransaction()` builds a `type: sale` request (serviceId, amount in
minor units, currency, orderId, `paymentMethod/paymentMethodCode: blik`, success/failure
return URLs, `clientIp`, `blikCode`, `validTo` = request time + 150s, optional customer
block) and POSTs it to `/merchant/{merchant_id}/transaction`.

## 3. IPN — asynchronous notification (`onNotify` → `IPNHandler::process`)

imoje POSTs notifications to Commerce's `commerce_payment.notify` route
(`/payment/notify/{payment_gateway_id}`; `getNotifyUrl()` builds this URL, shown as a warning
in the gateway form and set in the imoje panel). `ImojeOffsitePaymentGatewayBase::onNotify()`
passes the request, the configured `service_key`, and the gateway id to
`IPNHandler::process()`, which:

1. **`validateSignature()` first.** Reads `X-Imoje-Signature`, turns `;` into `&`, parses out
   `signature` and `alg`, and requires both present (else `BadRequestHttpException`).
   Recomputes `hash($alg, $rawBody . $service_key)` and rejects on mismatch — no payment is
   touched unless the signature proves the notification carries the merchant's service key.
2. Decodes the body; requires a `transaction` object (else 400). Reads
   `id/type/amount/currency/status/orderId`.
3. Looks up an existing `commerce_payment` by `(order_id, remote_id)`:
   - **none →** creates a payment (`payment_gateway`, `order_id`, `remote_id`,
     `remote_state`). Amount is converted back to standard units via
     `getPriceInStandardNominal()`. For `type: sale` it sets the amount and a state of
     `completed` when imoje reports `settled` (else the raw status); for `type: refund` it
     sets the refunded amount and `refunded`/`partially_refunded`. Then dispatches
     `ImojePaymentEvent::IMOJE_PAYMENT_RECEIVED`.
   - **exists →** updates remote state and state (`completed` on `settled`), dispatches
     `IMOJE_PAYMENT_UPDATED`. This dedups repeated notifications for the same transaction.
4. Returns `{"status":"ok"}` (HTTP 200).

## 4. imoje API client (`ImojeGateway`)

`callApi($gateway, $path, $parameters, $method)` selects the base URL by `getMode()`
(`IMOJE_SANDBOX_API_URL` = `sandbox.api.imoje.pl/v1`, `IMOJE_API_URL` = `api.imoje.pl/v1` —
fixed hosts, no request/config-supplied host), sets `Authorization: Bearer <token>` and JSON
content type, and issues the request with the core Guzzle `http_client` (TLS verification
left at Guzzle's secure default). JSON-encodes the body for non-empty parameters. On a bad
response or exception it logs to the `commerce_imoje` channel and rethrows.

Other methods: `getTransactionStatus()` (GET `/merchant/{id}/transaction/{tx}`),
`refundTransaction()` (POST `.../transaction/{remoteId}/refund` with `type: refund`,
server-computed amount, serviceId). `refundPayment()` (gateway plugin) wraps this,
`canRefundPayment()` allows refunds only from the `completed` state.

## 5. Extending — events

Subscribe to `ImojePaymentEvent::IMOJE_PAYMENT_RECEIVED`
(`commerce_imoje.imoje_payment.received`) or `::IMOJE_PAYMENT_UPDATED`
(`commerce_imoje.imoje_payment.updated`). The event exposes `getPayment()` and
`getIpnData()` (the decoded notification array).
