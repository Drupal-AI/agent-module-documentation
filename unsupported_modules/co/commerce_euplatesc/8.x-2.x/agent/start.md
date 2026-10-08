<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce EuPlatesc (commerce_euplatesc) — agent index
**Off-site Commerce payment gateway for the Romanian EuPlatesc.ro processor.**

- **version:** 8.x-2.x
- **core:** ^10.3 || ^11.1
- **depends on:** commerce:commerce, commerce:commerce_payment
- **plugin:** `EuPlatescCheckout` (id `euplatesc_checkout`, `OffsitePaymentGatewayBase`), config keys `merchant_id`, `secret_key`, `redirect_method`.
- **endpoint:** `https://secure.euplatesc.ro/tdsprocess/tranzactd.php`; signing via `hashData()` HMAC-MD5.
- **callbacks:** `onReturn` + `onNotify` both call `verifySignature()` (`hash_equals`) then `assertOrderContext()` (invoice_id + gateway + amount/currency match).
- **Security (reviewed sound):** every request/response is HMAC-signed and signature-verified; amount comes from the order total, and `assertOrderContext` blocks cross-order/amount replay. No disabled TLS, no unverified callback, no client-set amount.

See [configure/gateway.md](configure/gateway.md)
