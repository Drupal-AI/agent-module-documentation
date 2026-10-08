<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Currency Taxonomy (currency_taxonomy) — agent index

Creates a `currency` taxonomy vocabulary and, on install, populates it with a term for every ISO 4217
currency from the bundled `currency_codes.json`. Each term name is `Currency Name (ISO code)` and carries
three string fields.

- **Depends on:** core `taxonomy` only. No composer requirements. Core `^8.8 || ^9 || ^10 || ^11`.
- **No** admin UI, config form, routes, permissions, plugins, or config schema.
- **Provides:** the `currency` vocabulary + fields (install config), a lookup service, a Drush command.

## Entities / config it provides
- Vocabulary `currency` (`taxonomy.vocabulary.currency`).
- Term string fields: `field_currency_iso` (alphabetic code, required), `field_currency_number`
  (numeric code), `field_currency_country` (country). Plus default form/view displays.
- All under `config/install/`; there is no `config/schema/`.

## Service
- `currency_taxonomy.service` → `Drupal\currency_taxonomy\CurrencyTaxonomyService`
  (implements `CurrencyTaxonomyServiceInterface`): `createCurrency()`, `getCurrencyByCode()`,
  `getCurrencyByNumber()`, `getCurrencyByCountry()`.

## Drush
- `currency-taxonomy:import` (alias `cti`) — deletes all `currency` terms and re-imports from the data file.

## Behaviour
- `hook_install()` → `currency_taxonomy_add_terms()` reads `currency_codes.json` and saves one term each.
- `hook_uninstall()` deletes the `currency` vocabulary.
- `hook_help()` on `help.page.currency_taxonomy`.

## Solution docs
- [Vocabulary, fields & term data](fields/vocabulary.md)
- [Lookup service API](api/service.md)
- [Drush re-import command](drush/import.md)
