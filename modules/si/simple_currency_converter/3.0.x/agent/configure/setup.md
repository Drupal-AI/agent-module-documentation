<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple Currency Converter — configuration & feeds

## Enable
1. Enable `simple_currency_converter` and at least one feed submodule (`ecb_scc` and/or `floatrates_scc`). Optionally enable `notifier_scc` for admin failure emails.

## Admin form — `/admin/config/regional/simplecurrencyconverter`
Permission: `administer simple currency converter`. Key settings (config `simple_currency_converter.settings`):
- `conversion_selector` — CSS selector matching rendered prices on the page.
- `feed_primary` / `feed_secondary` — service id of the rate feed(s); secondary is the fallback.
- `default_conversion_currency` — the base currency prices are stored in.
- `default_storage` — `cache` or cookie storage for fetched ratios.
- `conversion_rate_lifetime` — seconds a fetched ratio stays valid.
- `window_id` / `window_trigger` / `window_title` / `disclaimer` — the jQuery UI picker dialog.

## Runtime flow
`hook_preprocess(html)` attaches `drupalSettings.simple_currency_converter` (selector, country info, cached ratios) and the picker library. JS calls `/simple_currency_converter_set_currency/{from}/{to}` → `DefaultController::setCurrency()` which returns `{ratio,name,to_currency}` JSON and caches it (cache backend or cookie).

## Feeds submodule matrix
- `ecb_scc` → `EuropeanCentralBankCurrencyConverter` (hardcoded ECB XML URL, EUR base).
- `floatrates_scc` → `FloatratesCurrencyConverter` (config `feed_url`, JSON); own admin form at `/admin/config/regional/simplecurrencyconverter/floatrates`, permission `administer Floatrates settings`.
- `notifier_scc` → emails an admin when both feeds fail to return a rate.

## Add a custom feed
Implement `Drupal\simple_currency_converter\CurrencyConverter\CurrencyConverterInterface` (`convert()`, `currencies()`), register it as a service; the `CurrencyConvertersPass` compiler pass collects it so it becomes selectable as a feed.
