<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce PayU — notification (IPN) & return flow

## onNotify(Request) — server-to-server callback from PayU
Location: `src/Plugin/Commerce/PaymentGateway/CommercePayu.php::onNotify()`.

Sequence:
1. `json_decode($request->getContent())` → the PayU order object; NULL body throws `PaymentGatewayException`.
2. Load the Drupal order by `extOrderId` (the Commerce order id) via `commerce_order` storage. Missing order → HTTP 500 "Waiting for creation of drupal order".
3. **Signature check:** `PayuNotificationHelper::areValidSignatures($request, $config)` parses the `Openpayu-Signature` header and calls `OpenPayU_Util::verifySignature($rawBody, $sig, $signature_key, $algo)`. On failure it calls `OpenPayU_Order::cancel()` and throws — no payment is created.
4. On a valid signature **and** `status == 'COMPLETED'`, it creates a `commerce_payment` with `amount = $drupalOrder->getTotalPrice()` (local total, **not** the callback amount), `remote_id`, `remote_state`, then applies the workflow transition returned by `getTransitionName()` (`validate` for `*_validation` workflows, else `place`).

Security notes:
- The notify route provided by Commerce for an off-site gateway is effectively anonymous — expected for an IPN — but the signature verification above authenticates it, so it is **not** an unauthenticated payment bypass.
- Because the payment amount is read from the local order total, a valid-signature replay cannot inflate/deflate the charged amount. There is no explicit cross-check that PayU's reported `totalAmount` equals the order total, but the recorded figure is the trusted local one.

## onReturn(OrderInterface, Request) — browser return
Only asserts that at least one `commerce_payment` exists for the order, otherwise throws "Payment failed try again". Actual fulfilment happens in `onNotify()`.

## Operating checklist
- Set the correct `signature_key` (PayU second key) or every notification is rejected.
- Use `live`/secure only with production PayU credentials; `sandbox` otherwise.
- Remove the `syslog(LOG_ERR, ...)` debug line in `PayuPaymentForm` before production to avoid logging return URLs.
