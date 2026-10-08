<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Currency Field (currency_field) — agent index

A field type for storing a single ISO 4217 currency on any fieldable entity. Editors pick from a
select list built from a locally bundled currency dataset — no external API, no config page, no
permissions, no dependencies beyond Drupal core.

## What it provides
- **Field type** `currency_field` (`src/Plugin/Field/FieldType/CurrencyField.php`) — one `value`
  string column, `varchar(255)`; storage setting `display` (default `Currency`).
- **Widget** `currency_widget` (`src/Plugin/Field/FieldWidget/CurrencyWidget.php`) — a `select`.
- **Formatter** `currency_formatter` (`src/Plugin/Field/FieldFormatter/CurrencyFormatter.php`) —
  outputs `nl2br(Html::escape($value))`.
- **Data** `currencies.yml` — the full ISO 4217 list (alphabetic/numeric code, currency name,
  entity/country, minor unit, withdrawal date), from the currency-codes dataset.
- **Procedural helpers** in `currency_field.module`: `currency_field_currencies()` and
  `currency_field_currency_options($blank, $format)`; plus `hook_help`.

## Dependencies
Drupal core only (`^8 || ^9 || ^10 || ^11`). No composer requirements, no submodules.

## No config / routes / permissions
No `*.routing.yml`, `*.permissions.yml`, `*.services.yml`, or `config/` — nothing to route,
authorize, or configure globally. Behavior is set per field instance via field storage settings.

## Solution docs
- [Field type, widget & formatter](fields/currency-field.md) — install, storage setting, stored
  value, display options, and how the pieces fit.
- [Data helpers API](api/helpers.md) — `currency_field_currencies()` /
  `currency_field_currency_options()` and the `currencies.yml` schema.
