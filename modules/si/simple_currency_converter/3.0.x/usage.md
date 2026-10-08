<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Runs client-side against a CSS selector of prices on the page and converts them from a base currency into the currency the visitor picks, using pluggable server-side exchange-rate feeds.

---

The module attaches a currency picker (a jQuery UI dialog) and JS that finds price elements matching a configured `conversion_selector`, then rewrites them for the chosen currency. Conversion ratios are fetched from the `/simple_currency_converter_set_currency/{from_currency}/{to_currency}` endpoint, which asks the `simple_currency_converter.default` service for a rate and returns it as JSON, caching it (in the cache backend or a cookie per `default_storage`). Rates come from pluggable feed services chosen in config as `feed_primary`/`feed_secondary`; the bundled submodules provide the European Central Bank feed (`ecb_scc`) and the FloatRates feed (`floatrates_scc`), and `notifier_scc` emails an admin when a conversion check fails. Feeds are collected via a compiler pass, so developers can register their own `CurrencyConverterInterface` service.

Operationally, admin config lives at `/admin/config/regional/simplecurrencyconverter` (permission `administer simple currency converter`), where you set the price selector, dialog labels, default currency, rate lifetime, and storage. The rate endpoint is intentionally `_access: 'TRUE'` so anonymous visitors can switch currency; feed URLs are fixed from config/hardcoded, the path's currency codes are used only as array keys against the parsed feed, and the response is `application/json`.

Typical setup: enable the module and at least one feed submodule, choose the feed under the admin form, set the CSS selector matching your rendered prices, pick a default/base currency and cache lifetime, and place/enable the picker.

---

- Let visitors convert on-page prices to their own currency
- Match prices for conversion via a configurable CSS selector
- Use the European Central Bank feed for EUR-based rates
- Use the FloatRates feed as an alternative rate source
- Configure a primary and secondary (fallback) rate feed
- Notify an admin by email when a conversion check fails
- Cache conversion ratios server-side in the cache backend
- Store the chosen rate in a cookie instead of the cache
- Set how long a fetched conversion rate stays valid
- Choose the default/base conversion currency
- Customise the currency-picker dialog title and trigger
- Add a disclaimer to the conversion dialog
- Fetch a live ratio via `/simple_currency_converter_set_currency/{from}/{to}`
- Register a custom rate feed as a `CurrencyConverterInterface` service
- Convert prices on product or listing pages without Commerce
- Support 150+ ISO 4217 currencies with formatting metadata
- Run Drush provider commands to inspect converters (`drush.services`)
- Refresh cached rates when configuration changes
- Restrict admin configuration behind a dedicated permission
- Present converted amounts in a modal on demand
- Fall back to the secondary feed when the primary returns nothing
