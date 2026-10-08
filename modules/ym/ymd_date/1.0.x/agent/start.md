<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# YMD Date (ymd_date) — agent index

A single field type for **partial / pre-1970 dates**: year, year+month, or year+month+day.
Package `Field types`. Core `^8.7.7 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.2
(version-dir `1.0.x`). `.info.yml` declares **no dependencies**; the field type uses core Field
API. Feeds and Views integration are optional (Feeds is a dev/soft dependency).

- **The field type, widget, formatter, config schema and storage format** →
  [fields/field.md](fields/field.md)
- **The Views filter, the `year_only` Token, and the Feeds target** →
  [integrations/views-token-feeds.md](integrations/views-token-feeds.md)

## What it actually is (from source)

Four plugins plus two `.inc` integrations, no routes, no permissions, no services, no Drush, no
submodules, no install hook:

- **Field type** `ymd_date_field_type` — `src/Plugin/Field/FieldType/YMDDateFieldItem.php`
  (extends `FieldItemBase`). One `value` column, DB type `int` (property is `string`), indexed.
  Value is an 8-char `YYYYMMDD` string; unknown month/day stored as `00`. Default widget
  `ymd_date_field_widget_default`, default formatter `ymd_date_field_formatter_default`. Per-field
  setting **`begin_year`** (required textfield).
- **Widget** `ymd_date_field_widget_default` —
  `src/Plugin/Field/FieldWidget/YMDDateFieldWidgetDefault.php` (extends `WidgetBase`). Three
  `select`s (year/month/day) in a `container-inline` fieldset; year range = `begin_year`…current
  year (falls back to 1900).
- **Formatter** `ymd_date_field_formatter_default` —
  `src/Plugin/Field/FieldFormatter/YMDDateFieldFormatterDefault.php` (extends `FormatterBase`).
  Picks one of three core date formats depending on stored precision. Settings
  `format_type_year_only` / `format_type_year_month` / `format_type_ymd`.
- **Views filter** `ymd_date` — `src/Plugin/views/filter/Date.php` (extends `NumericFilter`),
  wired in via `ymd_date.views.inc` (`hook_field_views_data`).
- **Token** `year_only` — `ymd_date.tokens.inc` (`hook_token_info` / `hook_tokens`).
- **Feeds target** `ymd_date_field_type` — `src/Feeds/Target/YMDDateFieldItem.php` (extends
  feeds `Number`).

## Config schema (`config/schema/`)

`ymd_date.schema.yml` — `field.value.ymd_date_field_type` (default-value sequence with a `value`
string), `field.field_settings.ymd_date_field_type` (`begin_year` as `list_integer`),
`field.formatter.settings.ymd_date_field_formatter_default` (the three `*_format_type_*` labels).
`ymd_date.views.schema.yml` — `views.filter.ymd_date` / `views.filter_value.ymd_date`.

## Install

```bash
composer require drupal/ymd_date
drush en ymd_date -y
```

Then add a **YMD Date** field to any bundle (*Manage fields*), set **Beginning year**, and it
uses the YMD widget and formatter by default. See [fields/field.md](fields/field.md).
