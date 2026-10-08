<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce CyberSource (commerce_cybersource) — agent index

Drupal Commerce payment integration for **CyberSource** (Visa Acceptance Solutions). Ships **three
payment gateway plugins** — Secure Acceptance Hosted Checkout (SAHC, off-site redirect), Flex
Microform v2 (on-site iframe), and Unified Checkout (hosted widget + wallets). Package
*Commerce (contrib)*. Version dir **2.0.x**; core `^10.3 || ^11`; license GPL-2.0-or-later.

- **Depends on** (Commerce submodules): `commerce_payment`, `commerce_order`, `commerce_log`.
- **Composer**: `drupal/commerce:^2.37 || ^3`, `cybersource/rest-client-php:^0.0.72` (Centarro
  fork of the CyberSource REST SDK), `firebase/php-jwt:^7`, PHP `>=8.0`.
- No permissions, no Drush, no custom plugin types. Provides config schema for the three gateways.

## What it provides (from source)

- **Payment gateway plugins** (`src/Plugin/Commerce/PaymentGateway/`):
  - `cybersource_sahc` — `CyberSourceSahc` (offsite; `OffsitePaymentGatewayBase`). Redirect + signed
    reply. **Deprecated, EOL Sept 2026.**
  - `cybersource_flex` — `Flex` (onsite; `OnsitePaymentGatewayBase implements FlexInterface`). REST
    authorize/capture/refund/void, tokenization, 3DS.
  - `cybersource_unified_checkout` — `UnifiedCheckout` (offsite-return;
    `OffsitePaymentGatewayBase implements UnifiedCheckoutInterface`). Hosted widget, wallets, 3DS.
- **Payment method type** `flex_credit_card` — `FlexCreditCard` (adds a `transient_token` field).
- **Checkout pane** `cybersource_flex_review` — `FlexReview` (default step `review`): drives Flex
  Payer Authentication (3DS enrollment check + step-up iframe).
- **Plugin forms** (`src/PluginForm/`): `FlexForm`, `UnifiedCheckoutForm`, `CyberSourceSahcForm`.
- **Controller** `PayerAuthenticationController::setup` at route
  `commerce_cybersource.payer_authentication.setup`
  (`/commerce-cybersource/pa-setup/{commerce_payment_gateway}/{commerce_order}`, `_format: json`,
  access `_entity_access: commerce_order.update`).
- **`JwtV2ApiClient`** — subclasses the SDK `ApiClient` to add JWT v2 HMAC-HS256 auth (no P12 cert).
- **Service** `logger.channel.commerce_cybersource`. **Log template** `commerce_cybersource.order_comment`.
  **Theme hook** `commerce_cybersource_stepup_iframe`. **hook_form_alter** injects the Unified
  Checkout widget into the checkout `review` step and hides the native submit button.
- **JS/CSS libraries**: `flex-form`, `payer-authentication`, `unified-checkout-form`.

## Solution docs

- **The three gateways — install, config keys/schema, transaction ops, API auth** →
  [payment/gateways.md](payment/gateways.md)
- **Return/notify handling, signature & JWT verification, 3DS Payer Authentication flow** →
  [payment/callbacks-and-3ds.md](payment/callbacks-and-3ds.md)
