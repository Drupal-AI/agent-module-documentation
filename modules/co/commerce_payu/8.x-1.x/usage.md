<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce PayU integrates the PayU payment provider with Drupal Commerce as an off-site redirect gateway (plugin id `payu_redirect_checkout`), using the OpenPayU PHP SDK.

---

At checkout the `PayuPaymentForm` plugin form builds the PayU order (amounts converted to integer minor units with `bcmul`, buyer/billing data, product lines, continue/cancel/notify URLs) and POST-redirects the customer to PayU's hosted page. PayU then calls back to the gateway's notify URL: `CommercePayu::onNotify()` decodes the JSON body, loads the matching Drupal order by `extOrderId`, and — before doing anything financial — verifies the `Openpayu-Signature` header against the configured `signature_key` via `PayuNotificationHelper::areValidSignatures()` (which calls `OpenPayU_Util::verifySignature`). Only on a valid signature and a `COMPLETED` status does it create the `commerce_payment` and apply the workflow transition; an invalid signature cancels the PayU order and throws. The recorded payment amount is taken from the local Drupal order total, not from the callback body, so a tampered notification cannot set an arbitrary price.

Configuration lives on the gateway: POS ID, signature key, OAuth client id/secret, and sandbox/live mode (mapped to the OpenPayU `sandbox`/`secure` environments). Credentials are stored in the payment gateway config entity (standard for Commerce, but plaintext in config — not a Key entity). Setup is: enable the module, add a PayU gateway under Commerce payment gateways, fill in the PayU merchant credentials, and expose it at checkout.
---
- Accept PayU payments on a Drupal Commerce store.
- Add a PayU off-site redirect gateway under Commerce > Payment gateways.
- Configure PayU POS ID, signature key, and OAuth client id/secret.
- Switch between PayU sandbox and live (secure) environments.
- Redirect customers to PayU's hosted payment page at checkout.
- Receive signature-verified IPN notifications at the gateway notify URL.
- Automatically place/validate an order when PayU reports COMPLETED.
- Reject spoofed notifications whose PayU signature fails verification.
- Convert Commerce prices to PayU minor-unit integers safely with bcmul.
- Pass buyer name, email, and billing/delivery address to PayU.
- Send order line items (name, unit price, quantity) to PayU.
- Map order-type workflows to `place` vs `validate` transitions on completion.
- Cancel the PayU order automatically when a bad signature is detected.
- Handle the customer return flow via `onReturn()` with a payment-exists check.
- Localize buyer language from the billing country code.
- Test the gateway with the bundled functional tests.
- Store PayU credentials per gateway for multi-store setups.
- Troubleshoot failed PayU order creation via the `commerce_payu` logger channel.
