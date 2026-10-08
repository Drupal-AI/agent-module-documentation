<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cybersource REST (Microform) (cybersource_rest) — agent index

**Cybersource REST / Flex Microform v2 payment gateway for Drupal Commerce; card data is captured in Cybersource iframes and charged server-side via the REST API.**

- **Version:** 1.0.x
- **Core:** ^10.3 || ^11
- **Package:** Commerce
- **Dependencies:** commerce_payment, commerce_order, commerce_price, commerce_log
- **Gateway plugin:** `CybersourceRest` (src/Plugin/Commerce/PaymentGateway/CybersourceRest.php)
- **Key services:** `cybersource_rest.api_client` (CybersourceApiClient, HTTP-Signature SDK client), `cybersource_rest.credentials` (external .yml credential provider), `cybersource_rest.credentials_status`
- **Routes:** `/cybersource-rest/payer-auth/setup|enroll/{gateway}/{order}` (POST, custom access = order owner + enabled 3DS gateway + CSRF header token); `/cybersource-rest/payer-auth/return` (POST, `_access: TRUE`).
- **Security:** Payment routes are session-authenticated (order ownership + CSRF). The `payer-auth/return` route is intentionally `_access: TRUE` — it is the ACS challenge return posted cross-site with no session, is side-effect-free, reads no request data, and only signals the parent window that the challenge finished; the auth result is validated server-to-server during the payment request. Amount/currency are taken from the order, not the client. Credentials live in an external private .yml, not in config; API TLS + signing handled by the Cybersource SDK (no disabled TLS). Reviewed sound.

See [api/gateway.md](api/gateway.md).
