<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin inventory

The module **defines no plugin types of its own**. It only supplies instances of core plugin
types. Everything below is verifiable with `drush php:eval` against the plugin managers.

## Field types (`@FieldType`, annotation-based)

| id | Label | Property type | Storage column type | default_widget | default_formatter |
|---|---|---|---|---|---|
| `range_integer` | Range (integer) | `integer` | `int` | `range` | `range_integer` |
| `range_decimal` | Range (decimal) | `string` | `numeric(precision,scale)` | `range` | `range_decimal` |
| `range_float` | Range (float) | `float` | `float` | `range` | `range_decimal` |

All extend `Drupal\range\Plugin\Field\FieldType\RangeItemBase` (which implements
`Drupal\range\RangeItemInterface`), declare `category = "range"` (the "Numeric range" group
defined in `range.field_type_categories.yml`), and carry
`constraints = {"RangeBothValuesRequired" = {}, "RangeFromGreaterTo" = {}}`.

`RangeItemBase` supplies: `schema()` (two columns `from`/`to` via the subclass's
`getColumnSpecification()`), `mainPropertyName() => NULL`, `defaultFieldSettings()`,
`fieldSettingsForm()` and `isEmpty()`. `RangeDecimalItem` additionally implements
`storageSettingsForm()` (precision/scale) and `preSave()` (rounds both ends to `scale`).

## Widget (`@FieldWidget`)

| id | Label | Field types |
|---|---|---|
| `range` | Text fields | `range_integer`, `range_float`, `range_decimal` |

Settings: `label.from` / `label.to` (both required, default `From` / `to`) and
`placeholder.from` / `placeholder.to`.

## Formatters (`@FieldFormatter`)

| id | Label | Field types | Extends |
|---|---|---|---|
| `range_integer` | Default | `range_integer` | `RangeFormatterBase` |
| `range_decimal` | Default | `range_decimal`, `range_float` | `RangeIntegerFormatter` |
| `range_integer_sprintf` | Formatted string | `range_integer` | `RangeFormatterBase` |
| `range_decimal_sprintf` | Formatted string | `range_decimal`, `range_float` | `RangeIntegerSprintfFormatter` |
| `range_unformatted` | Unformatted | all three | `RangeFormatterBase` |

The only thing subclasses change is `formatNumber()`:

- `range_integer` → `number_format($n, 0, '', $thousand_separator)`
- `range_decimal` → `number_format($n, $scale, $decimal_separator, $thousand_separator)`
- `*_sprintf` → `sprintf($format_string, $n)` (a thousand separator is impossible here — PHP
  limitation, stated in the settings-form description)
- `range_unformatted` → returns the raw number

## Validation constraints (`@Constraint`)

| id | Message |
|---|---|
| `RangeBothValuesRequired` | Both range values (FROM and TO) are required. |
| `RangeFromGreaterTo` | The FROM value is higher than the TO value. |

Both validators type-hint `RangeItemInterface` and throw `UnexpectedTypeException` otherwise.
`RangeFromGreaterToConstraintValidator` simply compares `$range['from'] > $range['to']`.

## Views handlers

| id | Type | Class |
|---|---|---|
| `range` | `@ViewsFilter` | `Drupal\range\Plugin\views\filter\Range` |
| `range` | `@ViewsArgument` | `Drupal\range\Plugin\views\argument\Range` |

Options: `value` (float), `include_endpoints` (bool), and for the filter `operator`
(`within` / `not within`, default `within`). `opWithin()` builds an AND condition
`from <op> value AND to <op> value` (OR-inverted for `not within`), picking `<`/`>` or `<=`/`>=`
from `include_endpoints XOR (operator === 'within')`. Views data is registered in
`range.views.inc` via `hook_field_views_data()`.

## Migrate plugins (D6/D7 upgrade path only)

`Plugin/migrate/field/d6/RangeField`, `.../d7/RangeField`, and process plugins under
`Plugin/migrate/process/d6/` (`RangeField`, `RangeFieldSettings`, `RangeFieldInstanceSettings`,
`RangeFieldInstanceDefaults`, `RangeFieldFormatterSettings`) and `.../d7/`
(`RangeFieldInstanceSettings`, `RangeFieldInstanceWidgetSettings`). Registered for the
migration state in `migrations/state/range.migrate_drupal.yml`. Irrelevant unless you are
upgrading a D6/D7 site.

## Hooks the module implements

`range_theme()` (two theme hooks), `range_field_info_alter()` (back-compat category/description
for Drupal ≤ 10.1 only), `range_field_views_data()`. There is **no `range.api.php`** — the module
invites no hooks of its own.
