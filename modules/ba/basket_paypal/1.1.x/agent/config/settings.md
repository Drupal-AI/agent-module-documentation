<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# basket_paypal — configuration & credentials

## Install / enable
- `composer require drupal/basket_paypal` (pulls `paypal/paypal-server-sdk:^0.6`), then
  `drush en basket_paypal`. The contrib `basket` module must be present and enabled first —
  it is a hard runtime dependency but is NOT declared in `basket_paypal.info.yml`.
- Install creates the `payments_basket_paypal` table (`basket_paypal_schema()` in
  `basket_paypal.install`). Update hook `basket_paypal_update_9001()` migrates the legacy
  `basket_paypal_js.settings` config into `basket_paypal.settings.js_sdk`.

## Config objects (no schema shipped → `provides_config_schema: false`)
### `basket_paypal.settings` (key `config`) — `SettingsForm`
Route `basket_paypal.settings` (`/admin/config/development/basket_paypal`), permission
`access basket_paypal settings`. Note: this is a plain `FormBase` that saves via an **AJAX submit
callback** (`ajaxSubmit()`), not `ConfigFormBase`. Keys:
- `sandbox` (bool) — switches PayPal environment (`Environment::SANDBOX` vs `PRODUCTION`).
- `clientId`, `clientSecret` — live REST app credentials (required when not sandbox).
- `s_clientId`, `s_clientSecret` — sandbox credentials (required when sandbox). `PayPal::getConfig()`
  copies the `s_*` pair over `clientId`/`clientSecret` when `sandbox` is on.
- `success.<langcode>.{value,format}` — localized "payment successful" message (text_format);
  ships defaults for `en`/`ru`/`uk` in `config/install/basket_paypal.settings.yml`.
- The form also displays (read-only) the webhook URL = `basket_paypal.pages` with `page_type=webhook`
  (`/basket_paypal/webhook`), which you register in the PayPal developer dashboard.

### `basket_paypal.settings.js_sdk` (key `config`) — `JavascriptSDKSettingsForm`
Route `basket_paypal.settings.javascript_sdk`, same permission. A `ConfigFormBase`. Keys:
- `enable` (bool) — when on, `basket_paypal_page_attachments()` injects
  `https://www.paypal.com/sdk/js?client-id=<clientId>&currency=<iso>` site-wide.
- `validate` (bool) — when on, `ApiPage::page('create')` builds and validates the Basket order
  form before creating the PayPal order and passes buyer name/email/phone as the payment source.
- `style.layout` ∈ vertical|horizontal, `style.color` ∈ gold|blue|silver|white|black,
  `style.shape` ∈ rect|pill|sharp (constants on `PayPalJs`). Live preview via the
  `basket_paypal_buttons` theme + `drupalSettings.basketPayPalJsSdk`.

## Credentials handling
`PayPal::client()` (`src/PayPal.php`) builds the SDK client with
`ClientCredentialsAuthCredentialsBuilder::init($clientId, $clientSecret)` and the chosen
`Environment`. Credentials are stored as plain config values (no Key entity integration); TLS to
PayPal is handled by the `paypal/paypal-server-sdk` client (no custom HTTP client, no disabled
verification).

## Operating
1. Enter live (and/or sandbox) client ID + secret; tick `sandbox` while testing.
2. Register `/basket_paypal/webhook` in the PayPal dashboard for the events the module handles.
3. In Basket → payment settings, add a payment point with service **PayPal** (plugin
   `basket_paypal`) or enable the JS SDK (`basket_paypal_js`). Per-point, choose the order
   `fin_status` to apply after payment (`BasketPaypal::settingsFormAlter()` /
   `updateOrderBySettings()`).
