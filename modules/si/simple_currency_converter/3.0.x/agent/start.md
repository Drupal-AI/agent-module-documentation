<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple Currency Converter (simple_currency_converter) — agent index

**Converts on-page prices (matched by a CSS selector) into a visitor-chosen currency, using pluggable server-side exchange-rate feeds (ECB / FloatRates) and caching the ratios.**

- **Version:** 3.0.x
- **Core:** ^9 || ^10 || ^11
- **Configure:** `/admin/config/regional/simplecurrencyconverter` — permission `administer simple currency converter`.
- **Rate endpoint:** `simple_currency_converter.set_currency` → `/simple_currency_converter_set_currency/{from_currency}/{to_currency}` (`_access: 'TRUE'`, returns JSON ratio, sets cache/cookie).
- **Service:** `simple_currency_converter.default` (`CurrencyConverter`); feeds are collected via a compiler pass and selected as `feed_primary`/`feed_secondary`.
- **Submodules:** `ecb_scc` (European Central Bank), `floatrates_scc` (FloatRates), `notifier_scc` (admin failure email). Drush commands via `drush.services.yml`.

**Access:** The `set_currency` route is `_access: 'TRUE'` **by design** (anonymous visitors switch currency). Feed URLs are fixed from config/hardcoded (`FloatratesCurrencyConverter` uses `feed_url` config; `EuropeanCentralBankCurrencyConverter` hardcodes the ECB URL) — the request-supplied `{from}`/`{to}` codes are only used as array keys against the parsed feed. Response is `application/json`.

See [configure/setup.md](configure/setup.md).