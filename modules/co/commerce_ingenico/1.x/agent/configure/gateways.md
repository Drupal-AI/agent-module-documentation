<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Commerce Ingenico gateways

## Libraries
Install via Composer so `marlon-be/marlon-ogone` and `mobiledetect/mobiledetectlib` are present.

## Ingenico back office (summary)
- Global security: **SHA-512**, UTF-8.
- Data & origin verification: set the **SHA-IN** passphrase (same value for e-Commerce/Alias and DirectLink/Batch).
- Transaction feedback: enable feedback parameters on redirect URLs; set server-to-server post URL to `https://yoursite/payment/notify/<PARAMVAR>` with request method GET; set the **SHA-OUT** passphrase.
- Create a dedicated **API user** (special user for API).

## Add the gateway in Drupal
`admin/commerce/config/payment-gateways` → Add. Fields (from `ConfigurationTrait`):
- `pspid`, `userid`, `password` — Ingenico login + API user credentials.
- `sha_algorithm` — must match the back office (SHA-1/256/512).
- `sha_in`, `sha_out` — passphrases; must match the back office exactly.
- `language`, `api_logging` (request/response debug logging).
- **DirectLink only** `3ds` — enable 3-D Secure and select the e-Commerce gateway to hand off to (a `ingenico_ecommerce` gateway must exist first).
- **whitelabel** `base_url[test|live]` — only for Ingenico clones (e.g. ePDQ/BarclayCard); rewrites `https://secure.ogone.com/`.
- Mode: test vs live (`getMode()` selects the API URL).

## Transaction mode
Set Authorize-and-capture vs Authorize-only at `admin/commerce/config/checkout-flows`.

## Maintenance operations
`OperationsTrait` exposes capture, void, refund and authorization renewal from the payment admin UI.

## Verification / integrity
- Outbound requests: `SHASIGN` computed with `AllParametersShaComposer` + SHA-IN.
- Inbound (`onReturn`/`onNotify` → `processFeedback`): `EcommercePaymentResponse::isValid()` with SHA-OUT; on mismatch the payment is set `failed` and `InvalidResponseException` is thrown. Payment state is advanced only from the async `onNotify()` notification.