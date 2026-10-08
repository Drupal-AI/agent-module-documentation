<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Redsys payment

**Config form:** `/admin/config/system/redsys-settings` (route `redsys_button.redsys_config_form`,
form `RedsysButtonConfigForm`, needs `administer redsys settings`).
**Config object:** `redsys_button.settings` (schema `config_object`). Keys and install defaults:

| Key | Default | Notes |
|---|---|---|
| `environment` | `test` | `test` or `live`. Selects Redsys endpoint (test `sis-t.redsys.es:25443`, live `sis.redsys.es`). |
| `merchant_code` | `''` | FUC, digits only, ≤16. Required. |
| `key_id` | `''` | ID of a **Key** entity (type group `authentication`) holding the merchant secret. Required. |
| `terminal` | `001` | 1–3 digits, non-zero. |
| `currency` | `978` | ISO 4217 numeric (978 = EUR). |
| `transaction_type` | `0` | Always forced to `0` on save. |
| `language` | `001` | Redsys consumer language code (001 Spanish … 002 English, etc.). |
| `notification_email` | `''` | Optional; emailed only after a signed successful notification. |
| `signature_version` | `HMAC_SHA512_V2` | `HMAC_SHA512_V2` (new) or `HMAC_SHA256_V1` (legacy terminals). |

Set the secret via CLI instead of the UI, e.g.:
`drush cset redsys_button.settings merchant_code 123456789 -y` (secret itself lives in a Key entity).

## Merchant secret (Key)

The secret is never stored in this module's config — only the Key entity's `key_id` is. Create an
`authentication` key at `/admin/config/system/keys`; in production use a file/environment/external
provider, not the configuration provider. `CredentialProvider::getSecret()` reads it via
`key.repository`; a missing/empty key throws and blocks payment creation and callback validation.

## Enable

```
composer require drupal/redsys_button:^2.0 drupal/key:^1.22
drush en redsys_button
```

Then place the **Redsys Button Block** (block plugin `redsys_button_block`, category *Forms*) on a page
to expose the standalone payment form.

## Updating from 1.x

`drush updb` runs `redsys_button_update_10001`–`10005`: installs the `redsys_payment` and
`redsys_payment_request` entity storage, expands the method field (xPay) and adds `provider_status` /
`completed_at`, and migrates the legacy plaintext `merchant_key` into a Key entity `redsys_button_legacy`
(config provider — move it to a non-config provider before production). Legacy installs are kept on
`HMAC_SHA256_V1`. Old keys `merchant_key`, `signatureversion`, `url_test`, `url_live` are cleared.

## Submodules

- `commerce_redsys_button` (deps `commerce:commerce_payment`) — adds four off-site Commerce gateways:
  `redsys_redirect_payment_checkout` (card), `redsys_bizum_redirect_payment_checkout`,
  `redsys_paypal_redirect_payment_checkout`, `redsys_xpay_redirect_payment_checkout`. Add each at
  `/admin/commerce/config/payment-gateways`; **credentials (merchant code, key, terminal) are per-gateway**,
  not from `redsys_button.settings`. Supports EUR, USD, GBP.
- `redsys_button_webform` (deps `webform:webform`) — Webform **handler** `redsys_payment` (Payment
  category). Add via *Settings → Emails/Handlers → Add handler*; map amount/email/description/output
  elements. Submission stays a draft until a signed notification completes it.
