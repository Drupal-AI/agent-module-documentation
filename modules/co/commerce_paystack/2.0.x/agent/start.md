<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Paystack (commerce_paystack) — agent index

**Off-site Drupal Commerce payment gateway for Paystack: redirect to Paystack at checkout, verify the transaction server-side on return.**

- **Version:** 2.0.x
- **Core:** ^9 || ^10 || ^11
- **Requires:** commerce:commerce_payment + Composer library `yabacon/paystack-php` (checked by `commerce_paystack_requirements`).
- **Gateway plugin:** `paystack_standard` (`PaystackStandard`, `OffsitePaymentGatewayBase`). Off-site form `PaystackStandardForm`.
- **Flow:** `PaystackStandardForm::buildConfigurationForm` -> `transaction->initialize()` (reference = order UUID, amount in kobo) -> redirect to `authorization_url`. `PaystackStandard::onReturn()` -> reads `trxref` -> `verifyTransaction()` (`transaction->verify()`) -> create commerce_payment, map status.
- **Config:** per-gateway `secret_key` (validated `sk_` prefix), mode test/live. No custom routes/permissions/services (uses Commerce payment permissions).

**Security:** No unauthenticated webhook/IPN route — the return handler re-verifies via an authenticated Paystack API call rather than trusting redirect data, so there is no signature-bypass surface (Paystack's `x-paystack-signature` webhook is not used because verification is pull-based). TLS is the library default (not disabled). Notable gap: `onReturn()` (`PaystackStandard.php:92-126`) records the order's own total and never compares the verified paid amount/currency to the order — no in-depth amount-tamper check. Secret Key is stored in plaintext gateway config (Commerce norm).

See [configure/gateway.md](configure/gateway.md).
