<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Redsys payment — agent index

Secure **off-site Redsys** (Spanish TPV) payments for Drupal — card, Bizum, PayPal, xPay — without
requiring Commerce. Ships a **Redsys payment form** block plus auditable `redsys_payment` entities;
2.1 adds token-protected **payment requests** (`redsys_payment_request`). Version **2.1.2** (dir `2.1.x`).
Core `^10.3 || ^11`, PHP `>=8.1`. Depends on **Key** (`key:key`) for secret storage.
Config route: `redsys_button.redsys_config_form` (`/admin/config/system/redsys-settings`).

Signing: `HMAC_SHA512_V2` (default new installs) or `HMAC_SHA256_V1` (legacy). Bank posts results to
`POST /redsys/notify`; the signature and immutable fields are verified before any state change (see below).

- **[Configure](configure/settings.md)** — settings keys, config form, Key setup, environments, submodule wiring.
- **[Permissions](permissions/permissions.md)** — the four permissions and what they gate.
- **[API](api/services.md)** — services (OperationManager, CredentialProvider, SignatureManager…), entities, events, routes.

**Security (verified correct):** the `/redsys/notify` callback is `_access: TRUE` (bank is unauthenticated)
but `PaymentRequestFactory::validateCallback()` verifies the Redsys `Ds_Signature` with a timing-safe
`hash_equals` **and** matches amount/currency/merchant/terminal/transaction-type to the local operation
*before* the status is set to completed. Idempotent; email sent only after a signed success. No finding.
