<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Currency API (currencyapi) — agent index

Fetches exchange rates from **CurrencyAPI.com** on cron, stores them in the expirable
key/value store, and displays them with optional **per-currency percentage markup**.
Package `Custom`. Core `^10.2 || ^11`. License GPL-2.0-or-later. Version 1.10.13.
**No declared dependencies**, but see the two runtime coupling caveats below.

- **Settings form, config object, keys, and the config-name mismatch** →
  [config/settings.md](config/settings.md)
- **The `currencyapi.service` API (fetch/convert/sell/markup helpers) and cron** →
  [api/service.md](api/service.md)
- **Routes, controller, JSON endpoint, theme hooks, and the broken block** →
  [routes/pages.md](routes/pages.md)

## What it actually is

- One service `currencyapi.service` → `CurrencyApiService` (args `@config.factory`,
  `@keyvalue.expirable`) in `src/CurrencyApiService.php`. Reads config `currencyapi.settings`,
  writes/reads rates in expirable key/value collection **`currencyapi.com`**, key `rates`.
- One cron service `currencyapi.cron` → `CurrencyApiCron` (arg `@state`), called from
  `currencyapi_cron()`. Fetches at most once per **86400s (24h)**.
- One config/settings form `CurrencyApiSettingsForm` (`administer site configuration`).
- One controller `CurrencyApiController` serving `/currency-rates`, `/buy-100`,
  `/currency-rates/json/{key}`, `/fetch-rates`.
- Three theme hooks: `currency_rates`, `buy_100`, `currency_exchange` (templates in `templates/`).
- One Block plugin `currency_rates_block` (`CurrencyRatesBlock`, category *Finance*) — **broken**
  (see below).
- **No** permissions file, **no** config schema, **no** Drush command class, **no** hooks beyond
  `hook_cron`/`hook_theme`/`hook_help`/`hook_uninstall`. README claims Drush commands that do not
  exist in source.

## Key facts an agent must know (all verified in source)

- **API key storage:** plain value in config `currencyapi.settings:api_key`, entered via an ordinary
  (unmasked) `textfield`. **No Key entity, no env var, no settings.php** — do not claim otherwise.
  The key is sent, `urlencode()`d, in the query string of the HTTPS request to
  `api.currencyapi.com`; it is not written to logs.
- **Transport:** `makeApiRequest()` uses `@file_get_contents()` over **https** with a 10s stream
  context. Host is **hardcoded** (`https://api.currencyapi.com/v3/latest`) — the `api_url` config
  field is saved by the form but **never used** by `buildApiUrl()`. No TLS verification is disabled
  and there is no request-supplied URL.
- **Config-name mismatch:** `config/install/currency.api.settings.yml` installs an object named
  **`currency.api.settings`**, but all code reads/writes **`currencyapi.settings`** — so the shipped
  defaults never apply, and `hook_uninstall` deletes the *installed* (unused) object, orphaning
  `currencyapi.settings`.
- **Commerce coupling (undeclared):** `CurrencyApiController::__construct()` unconditionally calls
  `\Drupal::service('commerce_store.current_store')->getStore()`, so **all** content routes fatal
  unless Drupal Commerce is installed with a store. Not in `dependencies`.
- **Broken block:** `CurrencyRatesBlock` type-hints `Drupal\currencyapi\Services\CurrencyApiClient`
  and injects service `currencyapi.client` — **neither the class nor the service exists** in the
  module. The block cannot instantiate.
- **Stub methods:** `getRate()`, `getSystemCurrencies()` have empty bodies; `/fetch-rates` returns
  the literal markup "Fetch is made Cron" and does not fetch.
