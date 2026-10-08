<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration: credentials, PriceTags, config objects

There are **two** places credentials/PriceTag options are entered; both write the same
`viabill_payments.settings` config object, and the gateway form additionally writes the plugin
configuration.

## 1. Gateway configuration form

At `/admin/commerce/config/payment-gateways/add` (or edit), plugin *ViaBill Payments*. Built by
`ViaBillPayments::buildConfigurationForm()`. See
[../plugins/payment-gateway.md](../plugins/payment-gateway.md) for the field groups. Requires
`administer commerce_payment_gateway` (Commerce's route permission).

## 2. Standalone credentials form

Route `viabill_payments.account_form` → `/admin/config/viabill/account`, permission
`administer commerce_payment_gateway`. Class `ViaBillAccountForm` (`src/PluginForm/ViaBillAccountForm.php`,
a `ConfigFormBase`). Fields: `api_key`, `api_secret` (password; empty = keep stored),
`viabill_pricetag` (must contain `<script`). `submitForm()`:

- Writes `api_key`, `api_secret`, `viabill_pricetag` into `viabill_payments.settings`.
- Then `loadByProperties(['plugin' => 'viabill_payments'])` and copies those three values into
  **every** gateway entity using this plugin (`setPluginConfiguration()` + save), then redirects to
  the first such gateway's edit form.
- The docblock notes **no** remote register/login call is made — the merchant obtains credentials
  from the ViaBill portal and pastes them.

## Config object `viabill_payments.settings`

Written by both forms; read by the presentation hooks in `viabill_payments.module`. Keys observed:

| Key | Meaning |
|---|---|
| `api_key`, `api_secret` | ViaBill account credentials |
| `viabill_pricetag` | the PriceTag `<script>` snippet |
| `viabill_pricetag_custom_css` | optional CSS injected inline with the tag |
| `pricetag_country` | `auto` / `dk` / `es` (`ViaBillConstants::PRICETAG_COUNTRY_*`) |
| `pricetag_language` | `auto` / `da` / `es` (`PRICETAG_LANGUAGE_*`) |
| `product_pricetag_alignment` / `_width` / `_auto` | product-page tag: `default`/`center`/`right`, e.g. `280px`, `yes`/`no` |
| `product_pricetag_dynamic_price` / `_price_trigger` | CSS selector + trigger events for JS-updated prices |
| `cart_pricetag_alignment` / `_width` / `_auto` | cart tag |
| `checkout_pricetag_alignment` / `_width` / `_auto` | checkout tag (auto select is disabled in the form) |
| `transaction_type` | `authorize_only` / `authorize_capture` |

**No config schema ships** (`provides_config_schema` is false — there is no `config/schema/`), so
`viabill_payments.settings` is a schema-less config object.

## PriceTag placement

`product_pricetag_auto` / `cart_pricetag_auto` = `yes` makes the hooks inject the tag automatically.
Otherwise paste the Twig snippet `{% if viabill_pricetag %} {{ viabill_pricetag }} {% endif %}` into
the relevant template (`commerce-product.html.twig`, `commerce-order-total-summary.html.twig`,
`commerce-checkout-order-summary.html.twig`); the form's `checkPriceTagPresenceAndActions()` prints
the exact file paths and an insertion hint. Hooks attach the `viabill_payments/styles` library.

## Modes / API base URL

The Commerce gateway **Mode** (test/live) is mapped by `ViaBillHelper` to
`ViaBillConstants::TEST_MODE_ON`/`OFF` (`'true'`/`'false'`) and passed to the API as the `test`
flag / included in the checkout signature. Note both `ViaBillOutgoingRequests::TEST_BASE_URL` and
`PROD_BASE_URL` are `https://secure.viabill.com`, so mode changes the `test` parameter, not the host.

## Screenshot

Standalone ViaBill Account Credentials form (`/admin/config/viabill/account`):

![ViaBill account credentials form](../../../../../../../screenshots/viabill_payments/2.1.x/account-credentials-form.png)
