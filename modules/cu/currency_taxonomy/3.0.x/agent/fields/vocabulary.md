<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Currency vocabulary, fields & term data

## Install / enable
`drush en currency_taxonomy -y`. Only core `taxonomy` is required. Enabling runs
`currency_taxonomy_install()` (in `currency_taxonomy.install`) → `currency_taxonomy_add_terms()`.

## Shipped configuration (`config/install/`)
- `taxonomy.vocabulary.currency.yml` — vocabulary `vid: currency`, name "Currency".
- `field.storage.taxonomy_term.field_currency_iso.yml` — string, max_length 255, cardinality 1.
- `field.storage.taxonomy_term.field_currency_country.yml` — string, max_length 255.
- `field.storage.taxonomy_term.field_currency_number.yml` — string, max_length 255.
- `field.field.taxonomy_term.currency.field_currency_iso.yml` — bundle `currency`, label "Iso label",
  **required: true**.
- `field.field.taxonomy_term.currency.field_currency_country.yml`, `...field_currency_number.yml` — the
  other two fields on the `currency` bundle (not required).
- `core.entity_form_display.taxonomy_term.currency.default.yml` and
  `core.entity_view_display.taxonomy_term.currency.default.yml` — default displays.

There is **no** `config/schema/` directory; the module provides no custom config schema.

## Term population
`currency_taxonomy_add_terms()` (in `currency_taxonomy.module`):
1. Resolves the module path via `extension.list.module`.
2. `Json::decode(file_get_contents("{module}/currency_codes.json"))`.
3. For each item, creates a `taxonomy_term` with:
   - `name` = `item['currency']` (e.g. `"Euro (EUR)"`),
   - `vid` = `currency`,
   - `field_currency_iso` = `item['iso_code']`,
   - `field_currency_country` = `item['country']`,
   - `field_currency_number` = `item['number']`,
   then `$term->save()`.
Exceptions are caught and logged to the `currency_taxonomy` logger channel.

`currency_codes.json` is a flat JSON array; each object has `currency`, `country`, `iso_code`, `number`.
One `Term::save()` runs per currency (~150+), so enabling can be slow (noted in the README).

## Uninstall
`currency_taxonomy_uninstall()` loads and deletes the `currency` vocabulary, which cascades to its terms.

## Notes for agents
- Term names embed the ISO code in parentheses; the canonical code lives in `field_currency_iso`.
- Numeric ISO codes are stored as **strings** (leading zeros preserved, e.g. `"008"`).
- To reference currencies from content, add an `entity_reference` field targeting this vocabulary.
