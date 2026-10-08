<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cybersource SOP (cybersource_sop) — agent index

**Cybersource Secure Acceptance Silent Order POST payment gateway for Drupal Commerce; outbound fields are HMAC-signed and every reply's signature is verified.**

- **Version:** 1.0.x
- **Core:** ^10.3 || ^11
- **Package:** Commerce
- **Dependencies:** commerce_payment, commerce_order, commerce_price, commerce_log, commerce_cart, commerce_checkout
- **Gateway plugin:** `CybersourceSop` (src/Plugin/Commerce/PaymentGateway/CybersourceSop.php)
- **Key services:** `cybersource_sop.signer` (SecureAcceptanceSigner — HMAC-SHA256 + hash_equals), `cybersource_sop.credentials` (external .yml provider)
- **Routes:** `/cybersource-sop/return/{order}` and `/cybersource-sop/cancel/{order}` — both POST-only, `_access: TRUE`.
- **Security:** The open return/cancel routes are authenticated by the HMAC signature on the Cybersource reply (verified in `onReturn`/`onCancel`), not by session. `verifySignature` uses HMAC-SHA256 and constant-time `hash_equals`; verification additionally requires the signature to cover `decision, reason_code, req_reference_number, transaction_id, req_amount, req_currency` (rejects appended unsigned fields). Amount is the order total; signed `req_amount`/`req_currency` must match it or the payment is refused. Credentials in external .yml, not config. Reviewed sound.

See [api/gateway.md](api/gateway.md).
