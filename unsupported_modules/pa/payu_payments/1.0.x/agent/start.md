<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PayU Donations (payu_payments) — agent index
**Block-based donation form that creates a PayU order and redirects the visitor to pay.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10
- **Library:** `payu/openpayu` (OpenPayU PHP SDK)
- **Block:** `payu_payments_block` (`PayUBlock`) → builds `PayUForm`
- **Form:** `payu_payments_form` (`PayUForm`) → `OpenPayU_Order::create()` then `TrustedRedirectResponse` to PayU on SUCCESS
- **Config:** stored in block configuration (environment, pos_id, MD5 second key, OAuth client_id/secret, currency, description, button text)
- **Routes/permissions/webhooks:** none of its own

**Security:** no local payment callback/notify route — verification happens PayU-side, so there is no unverified-callback fulfilment path here. Visitor-set amount is by design for donations. PayU secrets (MD5 signature key, OAuth client_secret) are stored in block config and entered via plain textfields — block config exports are sensitive.

See [configure/block.md](configure/block.md)
