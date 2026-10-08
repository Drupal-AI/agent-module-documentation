<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Square integrates Square's Connect payment APIs into Drupal Commerce, adding an on-site credit-card payment gateway (sandbox and production) that tokenises cards with the Square Payment Form.

---

The module provides a single Commerce payment gateway plugin, `square` (class `Square`, an `OnsitePaymentGatewayBase` that supports authorizations and refunds). It handles credit-card payments for Amex, Diners Club, Discover, JCB, Maestro, Mastercard, Visa and UnionPay via the Square Web Payments SDK, with `test` (Sandbox) and `live` (Production) modes. Application-level credentials live in the `commerce_square.settings` config object (application name, OAuth application secret, sandbox application ID, sandbox access token, production application ID), edited at *Commerce → Configuration → Payment → Square settings* (`/admin/commerce/config/square`, permission `administer commerce square`). Production connection uses Square OAuth: saving the settings form redirects the merchant to Square to authorize, and the returned access/refresh tokens are stored in Drupal **state** (`commerce_square.production_access_token`, `…_refresh_token`, `…_access_token_expiry`) — not in config. Per-gateway settings (stored on the `commerce_payment_gateway` config entity) are `test_location_id`, `live_location_id`, and `enable_credit_card_icons`; the location dropdowns are populated live from Square's Locations API. The `commerce_square.connect` service (class `Connect`) builds a configured `Square\SquareClient` for a given mode and exposes the tokens. The Square PHP SDK (`square/square ^34.0`) is a hard composer requirement. Live charges require real Square credentials and network access to Square; sandbox credentials let you test end to end.

---

- Accept credit-card payments on a Drupal Commerce store through Square.
- Offer a PCI-friendly on-site checkout where cards are tokenised by Square's JS SDK.
- Run in Square Sandbox mode to test the full payment flow with test cards.
- Switch a store to Production once Square OAuth authorization is complete.
- Authorize a payment at checkout and capture it later (authorization support).
- Refund a captured Square payment from the Commerce order UI.
- Restrict who can configure Square with the `administer commerce square` permission.
- Store the Square location that transactions are attributed to (test/live location IDs).
- Show credit-card brand icons in checkout via the `enable_credit_card_icons` toggle.
- Connect a production Square account via the built-in OAuth redirect flow.
- Keep production access/refresh tokens in Drupal state, out of exported config.
- Build a configured Square API client in custom code via `commerce_square.connect`.
- Support multiple card brands (Amex, Visa, Mastercard, Discover, JCB, UnionPay, etc.).
- Charge a stored payment method (reusable card) for a returning customer.
- Provide a sandbox gateway for staging and a production gateway for live simultaneously.
- Convert Square API errors into Commerce exceptions via the module's ErrorHelper.
- Configure the OAuth redirect URL that Square posts the authorization code back to.
- Integrate Square with the standard Commerce payment/checkout pipeline (no custom checkout).
- Add Square as one of several payment gateways, letting customers choose at checkout.
- Test declines and specific responses using Square's sandbox test values.
