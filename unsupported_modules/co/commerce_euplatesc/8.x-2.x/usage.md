<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce EuPlatesc provides an off-site Commerce payment gateway for the Romanian EuPlatesc.ro card processor.

---

The `EuPlatescCheckout` plugin builds a signed POST redirect to `https://secure.euplatesc.ro/tdsprocess/tranzactd.php`. Every outbound request is fingerprinted with an HMAC-MD5 `fp_hash` (`hashData()`, using the merchant's hex secret key and EuPlatesc's length-prefixed field concatenation), and each transaction includes a fresh `timestamp` and a random 16-byte `nonce`. The payment amount is derived from the order/payment entity, not from client-supplied form values.

Both the browser return (`onReturn`) and the server-to-server notification (`onNotify`) call `verifySignature()`, which recomputes the fingerprint and compares it with `hash_equals()`, throwing a `PaymentGatewayException` on mismatch. `assertOrderContext()` further asserts that the signed `invoice_id` matches the order, that the order belongs to this gateway, and that the signed amount/currency equal the order total — so a valid signature cannot be replayed against a different order or amount (there is a kernel `PaymentGatewayReplayTest`). On success the order is advanced to `place`/captured; on failure it is unlocked. Configure the gateway with your EuPlatesc merchant id and secret key.

---

- Add an EuPlatesc Checkout payment gateway in Commerce.
- Enter the EuPlatesc merchant id and secret key.
- Choose GET or POST redirect method for the off-site form.
- Redirect customers to EuPlatesc's secure 3-D Secure page at checkout.
- Sign each payment request with an HMAC-MD5 `fp_hash`.
- Include a per-transaction timestamp and random nonce.
- Verify the browser return signature before trusting the result.
- Verify the server notification (IPN) signature independently.
- Reject responses whose `invoice_id` does not match the order.
- Reject responses whose amount/currency differ from the order total.
- Prevent replaying a transaction against a different order.
- Capture the payment automatically on a successful authorised return.
- Void/unlock the order on a failed transaction.
- Place a draft order once payment succeeds via notify.
- Dispatch PAYMENT_SUCCESS / PAYMENT_FAILURE events for custom reactions.
- Record a Commerce payment entity with the EuPlatesc remote id.
- Support mastercard, visa and maestro card types.
- Show gateway help text via the module's help hook.
- Keep the secret key write-only (blank leaves the stored value).
- Run the bundled kernel replay test to validate signature handling.
