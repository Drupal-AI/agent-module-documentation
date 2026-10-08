<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Currency Intl adds a single amount-formatter plugin, `currency_intl` ("Unicode number patterns"), that formats money with PHP's Intl `NumberFormatter` for locale-accurate output.

---

This submodule of Currency contributes one `@CurrencyAmountFormatter` plugin, `Intl` (id `currency_intl`, label "Unicode number patterns"), and nothing else — no routes, permissions, config, services or schema. `Intl::formatAmount()` resolves the active `currency_locale` (via the parent module's `currency.locale_resolver`), builds a `\NumberFormatter` with that locale and its pattern, sets the fraction digits to the amount's own decimal count, and applies the locale's decimal/grouping separators plus the currency's sign and code as symbols. Compared with the parent module's default `currency_basic` formatter (a plain `number_format()` with the code prepended), the Intl formatter renders amounts using Unicode CLDR number patterns for greater locale accuracy. Requires the PHP `intl` extension; its `hook_requirements()` reports whether that extension is loaded. You activate it by selecting "Unicode number patterns" as the default amount formatter on the parent module's amount-formatting form (`/admin/config/regional/currency-formatting`), which stores `plugin_id: currency_intl` in config `currency.amount_formatting`.

---

- Format currency amounts using PHP's Intl `NumberFormatter` instead of the basic formatter.
- Render money with locale-accurate Unicode CLDR number patterns.
- Make a multilingual site display amounts the way each locale expects.
- Switch the site's default amount formatter from `currency_basic` to `currency_intl`.
- Apply the user/content locale's decimal and grouping separators to formatted amounts.
- Preserve an amount's own number of decimal places when formatting (fraction digits follow the input).
- Show the correct currency sign and ISO code as Intl symbols in formatted output.
- Improve formatting fidelity for currencies whose conventions differ from `en_US`.
- Provide a drop-in, more accurate formatter without writing a custom plugin.
- Verify the server has the PHP `intl` extension via the module's status report.
- Standardise price display across locales on an international storefront.
- Use Intl formatting alongside the parent module's currency entities and locales.
- Format amounts for a specific content language using the resolved `currency_locale`.
- Pair with imported `currency_locale` entities (e.g. `de_DE`) for correct European formatting.
- Replace ad-hoc PHP `number_format()` output with CLDR-driven formatting.
- Offer editors locale-correct monetary display without per-field configuration.
- Format zero-decimal currencies (e.g. JPY) correctly via Intl fraction handling.
- Keep the amount-formatter choice as exportable configuration for deployment.
- Select the Intl formatter as default so `Currency::formatAmount()` and the `currency_localize` filter both use it.
- Provide a higher-accuracy alternative to the Basic formatter for financial displays.
