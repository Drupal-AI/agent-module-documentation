<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Currency gives a Drupal site a full library of ISO 4217 currencies as config entities, plus locale-aware amount formatting and a pluggable currency-exchange (conversion) system.

---

Currency stores each currency (its code, sign, subunits, rounding step, alternative signs and country usages) as a `currency` config entity, and each formatting locale (decimal/grouping separators and a pattern) as a `currency_locale` config entity. Only `XXX` ("No currency") and the `en_US` locale ship enabled; you import the real currencies (USD, EUR, …) from the bundled `commercie/currency` data library via the import form or the `currency.config_importer` service. Amounts are rendered through pluggable **amount formatter** plugins (`@CurrencyAmountFormatter`, default `currency_basic`) that use the resolved `currency_locale` to place the separators and sign, exposed both as a `currency_amount` form element and via `Currency::formatAmount()`. Conversion is handled by pluggable **exchange rate provider** plugins (`@CurrencyExchangeRateProvider`): `currency_fixed_rates` (rates you enter by hand, stored in `currency.exchanger.fixed_rates`) and `currency_historical_rates`, stacked and queried through the `currency.exchange_rate_provider` service. Two text-format filters let editors work with money inline: `currency_exchange` converts amounts with `[currency:from:to:amount]`, and `currency_localize` formats them. Admin lives under *Configuration → Regional and language* (`/admin/config/regional/currency`, exchange at `/admin/config/regional/currency-exchange`, formatting at `/admin/config/regional/currency-formatting`), and a granular permission set gates each area. It depends on the `plugin` module and the `commercie/currency` + `commercie/currency-exchange` PHP libraries and needs the `bcmath` PHP extension for exact money math.

---

- Provide a canonical list of world currencies (code, sign, subunits) as config entities on a site.
- Import specific currencies (USD, EUR, GBP…) from the bundled data library instead of hand-defining them.
- Format a monetary amount for display with the correct sign, decimal and grouping separators via `Currency::formatAmount()`.
- Render a locale-aware price in a render array using the `currency_amount` form/render element.
- Let content editors convert money inline in body text with `[currency:EUR:USD:100]` (the `currency_exchange` filter).
- Format money amounts inside filtered text with the `currency_localize` text-format filter.
- Define manual/fixed exchange rates (e.g. EUR→USD = 1.25) via the Fixed rates provider.
- Stack multiple exchange rate providers and query the best available rate through `currency.exchange_rate_provider`.
- Convert an amount between two currencies programmatically with the exchange-rate service and `bcmath`.
- Add a brand-new custom currency (e.g. a loyalty-point or in-game currency) as a `currency` entity.
- Enable or disable individual currencies so only the ones a site trades in appear.
- Customise a currency's sign, subunits or rounding step (e.g. Swiss franc 0.05 rounding).
- Provide alternative signs for a currency so amounts match a house style.
- Add or import a `currency_locale` (e.g. `de_DE`) to control how amounts are grouped and separated.
- Present amounts differently per content language using the locale resolver.
- Collect a monetary value on a form with validation via the `currency_amount` element and input parser.
- Build a price field/widget on top of the amount element and currency entities.
- Expose currency data to Views through the module's Views field/filter plugins.
- Write a custom amount formatter plugin (`@CurrencyAmountFormatter`) for a bespoke display style.
- Write a custom exchange rate provider plugin (`@CurrencyExchangeRateProvider`) that pulls live rates from an API.
- Choose which amount formatter is the site default on the amount-formatting settings form.
- Gate currency administration precisely with per-operation permissions (view/create/update/delete currencies, manage rates, manage formatting).
- Round an amount to a currency's rounding step before charging or displaying it.
- Seed a commerce/pricing workflow with authoritative currency metadata and conversion.
- Deploy currency and locale definitions as exportable configuration across environments.
- Localise currency names and data for international sites using the `currency_intl` submodule.
