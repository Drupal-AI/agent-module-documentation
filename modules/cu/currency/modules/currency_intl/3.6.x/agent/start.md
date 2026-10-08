<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Currency Intl — agent index

Submodule of **Currency**. Adds one amount-formatter plugin, `currency_intl` ("Unicode number
patterns"), that formats money via PHP's Intl `NumberFormatter`. No routes, permissions,
services, config or schema of its own. Depends on `currency:currency` and the PHP `intl`
extension (its `hook_requirements()` reports whether `intl` is loaded).

- **Make it the site's amount formatter (config `currency.amount_formatting`)** →
  [configure/use-intl-formatter.md](configure/use-intl-formatter.md)

Key facts:
- Plugin: `@CurrencyAmountFormatter` id `currency_intl`, class
  `Drupal\currency_intl\Plugin\Currency\AmountFormatter\Intl`.
- Selected as default by setting `plugin_id: currency_intl` in config
  `currency.amount_formatting` (form: `/admin/config/regional/currency-formatting`).
- Uses the parent module's `currency.locale_resolver` + `currency_locale` pattern/separators;
  see the parent's [api/formatting.md](../../../../3.6.x/agent/api/formatting.md) and
  [plugins/plugin-types.md](../../../../3.6.x/agent/plugins/plugin-types.md).
