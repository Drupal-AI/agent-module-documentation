<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes, controller, JSON endpoint, theme & block

## Routes (`currencyapi.routing.yml`)

| Route id | Path | Permission | Handler |
|---|---|---|---|
| `currencyapi.settings` | `/admin/config/services/currency-api` | `administer site configuration` | `_form` CurrencyApiSettingsForm |
| `currencyapi.rates` | `/currency-rates` | `access content` | `CurrencyApiController::ratesPage` |
| `currencyapi.buy_100` | `/buy-100` | `access content` | `CurrencyApiController::buy100` |
| `currencyapi.rates.json` | `/currency-rates/json/{key}` | `access content` (`key: [a-zA-Z]+`) | `CurrencyApiController::ratesJson` |
| `currencyapi.fetchrates` | `/fetch-rates` | `administer site configuration` | `CurrencyApiController::fetchRates` |

## Controller `CurrencyApiController` (`src/Controller/CurrencyApiController.php`)

- **Commerce coupling:** the constructor calls
  `\Drupal::service('commerce_store.current_store')->getStore()->getDefaultCurrencyCode()` and stores
  it in `$this->currencyCode`. This runs for **every** route on the controller, so `/currency-rates`,
  `/buy-100`, and `/currency-rates/json/{key}` all **fatal** unless Drupal Commerce is installed with
  a default store. Commerce is **not** a declared dependency.
- `ratesPage()` — renders `#theme => 'currency_rates'` with all stored rates and the default
  currency. Attaches library `currencyapi/currency_rates` (**not defined** in
  `currencyapi.libraries.yml`, which only declares `settings-form` and `currency-exchange`).
- `buy100()` — builds a per-currency list applying `buyrate_<CODE>` markup via `service->convert(...)`,
  renders `#theme => 'buy_100'`; title callback `buy100Title()` → "Buy 100 <store currency>".
- `ratesJson($key)` — returns `new JsonResponse($service->getAllRates())`. The `{key}` argument is
  **ignored** (a `@todo` notes missing validation). Exposes the stored rate set (public exchange-rate
  data) to any user with `access content`.
- `fetchRates()` — returns `['#markup' => 'Fetch is made Cron']`. It does **not** fetch anything; the
  actual fetch is cron-driven.

## Theme hooks (`currencyapi_theme()`)

- `currency_rates` (template `currency-rates.html.twig`) — vars `rates`, `base_currency`.
- `buy_100` (template `buy-100.html.twig`) — vars `amount`, `base_currency`, `last_update`, `list`,
  `rates`.
- `currency_exchange` (template `currency-exchange.html.twig`) — vars `rates`, `amount`, `list`,
  `base_currency`. Declared but not rendered by any route/controller in this release.

## Block `currency_rates_block` — non-functional

`src/Plugin/Block/CurrencyRatesBlock.php` (annotated `@Block`, admin label *Currency Rates*, category
*Finance*) type-hints `Drupal\currencyapi\Services\CurrencyApiClient` and injects service
**`currencyapi.client`**. Neither the `CurrencyApiClient` class nor the `currencyapi.client` service
exists in the module, and `build()` reads a `default_currencies` config key that nothing writes. The
block therefore cannot be instantiated — do not offer it as a working feature.

## Libraries (`currencyapi.libraries.yml`)

Defines `settings-form` (CSS `assets/css/settings-form.css`) and `currency-exchange` (CSS
`assets/css/currency-exchange.css` — file not shipped). Code also attaches the undefined
`currencyapi/currency_rates`.
