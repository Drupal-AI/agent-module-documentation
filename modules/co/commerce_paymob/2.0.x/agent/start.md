<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Paymob (commerce_paymob) — agent index
**Drupal Commerce payment gateway for Paymob with offsite Redirect and onsite Pixel flows; callbacks are HMAC-verified.**

- **Version:** 2.0.x
- **Core:** ^10 || ^11
- **Depends on:** commerce_payment
- **Gateways:** `paymob_redirect` (offsite), `paymob_pixel` (onsite, `SupportsStoredPaymentMethods`); shared base `PaymobBase` (`OffsitePaymentGatewayBase`).
- **Config:** server/region, `public_key`, `secret_key`, `api_key`, `payment_integration`, `hmac`, `telephone_field`, `reuse_payment_method` (plain config values).
- **Callbacks:** `onReturn()` and `onNotify()` (Commerce `commerce_payment.notify` route) both call `Paymob::verifyHmac()` before applying state transitions; `refundPayment()` via void/refund API.

**Security:** No campaign findings. TLS not disabled (Guzzle over `https://` region hosts). Webhook/return callbacks are signature-verified before order fulfilment — invalid/missing HMAC throws `PaymentGatewayException` (`PaymobBase.php` `onReturn`/`onNotify`). Pixel flow re-validates charged vs expected amount. Card tokens (not PANs) stored. See [configure/gateway.md](configure/gateway.md).
