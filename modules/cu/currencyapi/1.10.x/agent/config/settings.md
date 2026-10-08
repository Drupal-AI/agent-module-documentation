<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — settings form & config object

## Install / enable

`composer require drupal/currencyapi` then `drush en currencyapi -y`. No declared module
dependencies. To render the content pages you additionally need **Drupal Commerce** with a store
(the controller calls `commerce_store.current_store`); the cron fetch and the `currencyapi.service`
API work without Commerce.

## Settings form

- Class `Drupal\currencyapi\Form\CurrencyApiSettingsForm` (`ConfigFormBase`), form id
  `currencyapi_settings`.
- Route `currencyapi.settings` → `/admin/config/services/currency-api`, permission
  **`administer site configuration`**. Menu link `currencyapi.settings` under
  *Configuration → Web services* (`system.admin_config_services`).
- `getEditableConfigNames()` returns **`currencyapi.settings`**.

Fields written by `submitForm()` into `currencyapi.settings`:

| Form field | Config key | Notes |
|---|---|---|
| API Key (`textfield`, required, **unmasked**) | `api_key` | Plain-text value; sent in the request query string. |
| API Endpoint (`url`) | `api_url` | **Saved but never read** — `buildApiUrl()` hardcodes the host. |
| Currencies (`textfield`) | `currencies` | Comma-separated codes, e.g. `EUR,GBP,JPY,CAD`; the **first** code is treated as the base/default. |
| Buy-rate table (`table`) | `buyrate_<CODE>` | One percentage per non-default currency; stored per code, run through `formatCurrency()`. |

The form also renders a computed table (base value, "base 100", buy %, "buy 100", income, income in
default currency) using `currencyapi.service` helpers and the currently stored rates. It attaches
library `currencyapi/settings-form`. The `last_update` timestamp is displayed and is set by cron.

## Config object `currencyapi.settings` (what the code actually uses)

Keys read across the module: `api_key`, `currencies`, `buyrate_<CODE>`, `last_update`. The service
also references `base_currency` / `target_currencies` in `fetchExchangeRates()` but then overrides
the currency list with `currencies`, so those two are effectively unused.

## Config-name mismatch (important)

`config/install/currency.api.settings.yml` installs an object literally named **`currency.api.settings`**
with `api_key: ''`, `base_currency: 'EUR'`, `target_currencies: [USD,GBP,CHF]`, `cache_expiration:
86400`. **No code reads that object** — everything uses `currencyapi.settings`. Consequences:

- The shipped defaults never take effect; `currencyapi.settings` starts empty and must be filled via
  the form.
- `hook_uninstall()` (`currencyapi.install`) deletes `currency.api.settings`, so the real object
  `currencyapi.settings` is left behind after uninstall.

## No config schema

There is no `config/schema/` directory. `currencyapi.settings` is **schema-less**, so keys are
untyped and config translation/validation does not apply.
