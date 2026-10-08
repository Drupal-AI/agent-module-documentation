<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Date Format SQL — handler configuration

There is no admin settings page. Configuration is per-handler inside a View. The module
only affects **Field-API `timestamp` fields** (it does not touch node `created`/`changed`
base fields unless they are exposed as timestamp Field-API fields; `file`-provider tables
are skipped).

## Handler swap (`views_date_format_sql.views.inc`)
`hook_views_data_alter()` loops all Views data; for any field/argument whose
`field.entity_type` + `field.field_name` resolve to a `FieldStorageConfig` of type
`timestamp`, it rewrites the handler `id`:
- field `id` → `views_date_format_sql_field`
- argument `id` → `views_date_format_sql_argument`

So on those fields you simply get an extra checkbox; you don't pick a special handler.

## Field: "Use SQL to format date"
In *Configure Field* for the timestamp field:
- **Use SQL to format date** (`format_date_sql`, default off). When off, `query()`,
  `getValue()`, `clickSort()`, `getItems()` all defer to the core `EntityField` parent —
  no change in behavior.
- When on and the display uses aggregation, `query()`:
  - Determines the format from the field's normal date-format setting
    (`settings.date_format`; if `custom`, `settings.custom_date_format`). This is the same
    "Date format" UI core exposes on a timestamp field formatter.
  - Computes a timezone offset from `settings.timezone` (falls back to the site default),
    applied with `setFieldTimezoneOffset()`.
  - Builds the formula `$query->getDateFormat($field, $formatString, FALSE)` and adds it as
    a grouped, aliased field (`addField(... , $params)` + `addGroupBy()`), so the formatted
    string becomes a GROUP BY key.
- Enable **Aggregation** on the View (Advanced → Use aggregation) for grouping to take
  effect; then set the field's date format to a coarse token such as `Y-m` (month) or `Y`
  (year).

## Argument (contextual filter): "Use SQL to format date" + "Date Format"
On a timestamp field used as a contextual filter:
- **Use SQL to format date** (`format_date_sql`, default off).
- **Date Format** (`format_string`, free-text, default `''`) — a date format pattern
  used to build the SQL formula.
- When on, `query()` builds `getFormula() = getDateFormat(format_string)` and adds a WHERE:
  `DATE_FORMAT(<date field>, '<format>') = :placeholder`, where the placeholder is the
  bound contextual argument value. So passing `2024-03` as the argument with format `Y-m`
  matches all rows in March 2024.

## Config schema (`config/schema/views_date_format_sql.schema.yml`)
- `views.field.views_date_format_sql_field`: `format_date_sql` (boolean).
- `views.argument.views_date_format_sql_argument`: `format_date_sql` (boolean),
  `format_string` (string).
