<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Exchange Rate (exchangerate) — agent index

Fetches live currency rates from **ExchangeRate-API v6**, caches them, and exposes them via two blocks, an injectable service, custom JSON routes, and core REST resources. Version 1.0.1. Core `^10 || ^11`. License GPL-2.0-or-later. Package "Exchange Rate".

## Dependencies
Core modules only: `block`, `rest`, `serialization`. No composer.json ships; no contrib deps. An ExchangeRate-API key is required and is entered on the settings form (stored in `exchangerate.settings` config) — there is no env/Key-module credential wiring.

## What it provides
- **Config**: `exchangerate.settings` (config_object, schema in `config/schema/exchangerate.schema.yml`, defaults in `config/install/`). Settings form `\Drupal\exchangerate\Form\SettingsForm` at route `exchangerate.settings_form` (`/admin/config/system/exchangerate`).
- **Service**: `exchangerate.api` → `\Drupal\exchangerate\Service\ExchangeRateApi` — `getRates()`, `convert()`, `getRate()`, `getBaseCurrency()`, `getSupportedCurrencies()`, `getCountries()`, `formatRate()`, `getLastUpdated()`, `clearCache()`, `isCacheEnabled()`, `getCacheTimestamp()`.
- **Blocks**: `exchangerate_block` (`ExchangeRateBlock`, rates display, 6 layouts) and `currency_converter_block` (`CurrencyConverterBlock`, wraps the AJAX `CurrencyConverterForm`).
- **Custom JSON routes** (no REST module needed): `/api/exchangerate/rates`, `/rates/{from}/{to}`, `/convert` (GET+POST), `/currencies`, plus `/exchangerate/autocomplete[_multiple]` — controller `CurrencyController`.
- **Core REST resources**: `exchangerate_rates` (`/api/v1/exchangerate`, GET) and `exchangerate_conversion` (`/api/v1/exchangerate/convert`, GET/POST).
- **Permissions**: `administer exchangerate` (restrict access), `access exchangerate rest api`.
- **Hook**: `hook_exchangerate_countries_alter(&$countries)` (see `exchangerate.api.php`).
- **Theme hooks / templates**: `exchangerate_block`, `currency_conversion_results`, `currency_converter_block` (in `templates/`). Libraries `exchangerate/exchangerate_styles`, `exchangerate/exchangerate_converter`.

## Solution docs
- [config/settings.md](config/settings.md) — install, API key, all settings keys, caching.
- [api/service.md](api/service.md) — the `exchangerate.api` service methods and the countries-alter hook.
- [api/rest-endpoints.md](api/rest-endpoints.md) — custom JSON routes and core REST resources.
- [blocks/blocks.md](blocks/blocks.md) — the two blocks, converter form, templates, and layouts.
