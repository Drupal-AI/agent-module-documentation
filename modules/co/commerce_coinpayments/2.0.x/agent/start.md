<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CoinPayments (commerce_coinpayments) — agent index

**Off-site (redirect) cryptocurrency payment gateway for Drupal Commerce with a signed IPN confirmation callback.**

- **Version:** 2.0.x
- **Core:** ^8 || ^9 || ^10 || ^11
- **Requires:** commerce, commerce_payment
- **Gateway plugin:** `CoinPaymentsRedirect` (offsite redirect) + `CoinPaymentsForm` plugin form
- **IPN route:** `/commerce_coinpayments/ipn` → `CoinPaymentsController::processIPN` → `IPNCPHandler`
- **Permission:** `access commerce coinpayments ipn` (must be reachable by CoinPayments' servers)

**Security:** SOUND — the IPN handler verifies the CoinPayments HMAC-SHA512 signature against the raw body plus merchant/currency/amount before transitioning payment (IPNCPHandler.php:215-244); the route permission is not the security boundary, the signature is. See [configure/gateway.md](configure/gateway.md).
