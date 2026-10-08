<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services (from `currency.services.yml`)

| Service id | Class | Use it for |
|---|---|---|
| `currency.exchange_rate_provider` | `PluginBasedExchangeRateProvider` | `load($from, $to)` → stacked exchange rate; `loadConfiguration()`/`saveConfiguration()` for enabled providers |
| `plugin.manager.currency.exchange_rate_provider` | `ExchangeRateProviderManager` | discover/instantiate `@CurrencyExchangeRateProvider` plugins (e.g. `createInstance('currency_fixed_rates')`) |
| `plugin.manager.currency.amount_formatter` | `AmountFormatterManager` | discover/instantiate `@CurrencyAmountFormatter` plugins |
| `currency.config_importer` | `ConfigImporter` | `getImportableCurrencies()`, `importCurrency($code)`, `getImportableCurrencyLocales()`, `importCurrencyLocale($locale)` |
| `currency.locale_resolver` | `LocaleResolver` | `resolveCurrencyLocale()` — pick the `currency_locale` for the current language/country |
| `currency.input` | `Commercie\Currency\Input` | parse a user-entered amount string into a numeric value (`parseAmount()`) |
| `currency.form_helper` | `FormHelper` | option lists for currency/locale select elements on forms |
| `currency.event_dispatcher` | `EventDispatcher` | dispatch currency events |

## Events

`Drupal\currency\Event\CurrencyEvents` — notably `ResolveCountryCode` (dispatched while the
locale resolver decides which country/locale applies). Subscribe to override locale resolution.

## Config entities & keys (quick reference)

- `currency.currency.<CODE>` — a currency (id key `currencyCode`).
- `currency.currency_locale.<locale>` — separators + pattern for formatting.
- `currency.exchange_rate_provider` — `plugins: [{plugin_id, status}]` (enabled providers, ordered).
- `currency.exchanger.fixed_rates` — `rates: [{currency_code_from, currency_code_to, rate}]`.
- `currency.amount_formatting` — `plugin_id` of the default amount formatter.

No Drush commands are provided; use `drush cget`/`cset` or the services above.
