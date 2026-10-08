<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Decimal (decimal) — agent index

String-backed decimal **field type** for maximum precision: stores values in a `varchar(32)`
column instead of core's `DECIMAL` SQL type, so large/high-precision numbers keep every digit.
Version **1.0.0**. Core `^9.1 || ^10 || ^11`. Depends only on core **`field`**.
Requires the **BCMath** PHP extension (registered in `decimal_requirements()`).

## What it provides

- **Field type** `decimal_string` — `DecimalStringItem` extends core `DecimalItem`; overrides
  `schema()` (varchar 32), `storageSettingsForm()` (scale max 18, precision max 32), `preSave()`
  (normalizes value via `decimal.normalizer`).
- **Widget** `decimal_string` — `DecimalStringWidget` extends core `NumberWidget`; adds a
  placeholder setting, applies min/max, renders prefix/suffix via `FieldFilteredMarkup`, and uses
  the `#type => 'decimal_string'` element.
- **Formatter** `decimal_string` ("Decimal (from string)") — `DecimalStringFormatter` extends core
  `DecimalFormatter`; adds a `scale` setting (default 2, max 18) and formats via `decimal.formatter`.
- **Form element** `decimal_string` — `Element\DecimalString` (extends `FormElementBase`); text
  input, validates and normalizes on `#element_validate`.
- **Services**: `decimal.normalizer` (`DecimalNormalizer`) cleans/validates input →
  string|FALSE; `decimal.formatter` (`DecimalFormatter`) formats via `brick/math` BigDecimal.
- **Config schema**: `field.storage_settings.decimal_string` (precision, scale),
  `field.field_settings.decimal_string` (min, max, prefix, suffix), `field.value.decimal_string`.

No routes, no permissions, no Drush commands, no submodules, no configuration form of its own.

## Solution docs

- [Field type, widget & formatter](fields/field-type.md) — enable, storage/field settings, display.
- [Normalizer & formatter services](api/services.md) — `decimal.normalizer`, `decimal.formatter`, the form element.
