<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Paystack integrates the Paystack payment gateway into Drupal Commerce as an off-site (redirect) payment method.

---

The gateway plugin `PaystackStandard` (`src/Plugin/Commerce/PaymentGateway/`) is an `OffsitePaymentGatewayBase`. At checkout, `PaystackStandardForm::buildConfigurationForm()` calls the Paystack API `transaction->initialize()` (via the `yabacon/paystack-php` library) with the order UUID as reference, amount in kobo, customer email and the Commerce return/cancel URLs, then redirects the buyer to Paystack's `authorization_url`. On return, `PaystackStandard::onReturn()` reads the `trxref` query parameter and calls `verifyTransaction()`, which performs a server-side authenticated `transaction->verify()` against Paystack; only if the verified status is truthy does it create a `commerce_payment` and map the remote status (`success`->completed, `abandoned`->authorization_voided, `failed`->refunded).

Configuration is per payment gateway (Commerce > Configuration > Payment gateways): choose the Paystack Standard plugin, set mode (test/live) and the merchant Secret Key (validated to start with `sk_`). The library dependency `yabacon/paystack-php` must be installed via Composer (checked by `hook_requirements`). Security posture is sound: the return is not trusted blindly — it is re-verified through an authenticated API call, TLS is left at the library default (not disabled), and there is no unauthenticated webhook route to spoof. One gap to be aware of: `onReturn()` records the order's own total as the payment amount and does not compare the *verified* paid amount/currency from Paystack's response against the order — so amount/currency tampering is not defended in depth (mitigated by the reference being the server-generated order UUID). The Secret Key is stored in plain Commerce gateway config (standard for Commerce gateways; consider restricting config access).

---
- Add the Paystack Standard (Off-site) gateway to a Commerce store.
- Accept card payments via Paystack redirect checkout.
- Configure the merchant Secret Key (must start with `sk_`).
- Switch between Test and Live transaction modes.
- Redirect buyers to Paystack's hosted payment page at checkout.
- Verify each transaction server-side on return before recording payment.
- Map Paystack `success` to a completed Commerce payment.
- Handle abandoned payments as authorization-voided.
- Handle failed payments via the refunded state mapping.
- Pass the order UUID as the Paystack transaction reference.
- Send the amount to Paystack in kobo (amount x 100).
- Include billing first/last name as Paystack custom fields when a billing profile exists.
- Let buyers cancel and return via the cancel URL.
- Require the `yabacon/paystack-php` Composer library (enforced by hook_requirements).
- Use standard Commerce payment permissions to administer the gateway.
- Review commerce_paystack logs for API verification errors.
- Store the customer/payer id on the order after successful verification.
- Combine with Commerce checkout flows as an off-site payment pane.
- Consider adding paid-amount/currency verification before fulfilment for defense in depth.
- Keep the Secret Key config restricted to trusted store administrators.
