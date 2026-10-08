<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views filter and sort for `daterangepicker` fields

## Wiring — `drpw_field_views_data_alter()` (`drpw_field.module`)

`hook_views_data_alter()` loads every `field_config` of type `daterangepicker`, and for each field's
`{entity}__{field}` table / `{field}_value` column sets:

- `filter.id = views_daterangepicker_filter` (+ `filter.field_type = daterangepicker`)
- `sort.id = views_daterangepicker_sort` (+ `sort.field_type = daterangepicker`)

So a `daterangepicker` field automatically gets the custom range-aware handlers in Views.

## Filter — `DateRangePickerFilter` (`views_daterangepicker_filter`)

`src/Plugin/views/filter/DateRangePickerFilter.php`, extends `FilterPluginBase`, uses
`DateRangePickerTrait`. The admin enters a range in a picker `Value` field; the value is a JSON
`{start,end}` string, decoded in each operator method.

- **Operators** (`operators()` / `query()` dispatches to the method):
  - `subset` — field range is fully inside the value range (`field.start >= value.start` AND
    `field.end <= value.end`).
  - `superset` — field range fully contains the value range (`field.start <= value.start` AND
    `field.end >= value.end`).
  - `intersect` — any overlap between field and value ranges (OR of the four boundary cases).
  - `not_intersect` — no overlap (`field.end < value.start` OR `field.start > value.end`).
- SQL uses `JSON_UNQUOTE(JSON_EXTRACT({field}, '$.start'|'$.end'))` compared to **named placeholders**
  `:start_{position}` / `:end_{position}` via `addWhereExpression()` / `condition()->where()` — user
  input is parameter-bound, not concatenated. (MySQL/MariaDB JSON functions required.)
- `canBuildGroup()` returns FALSE (grouped filters unsupported); `buildExposeForm()` hides the
  "multiple" option and adds a "Date Range Picker options" details sub-form via
  `buildDateRangePickerOptionsForm()`; `validateExposeForm()` runs `validateDateRangePickerOptions()`.
- `valueForm()` renders the picker (class `daterangepicker`, `alt_format = 'yy-mm-dd'`), keying
  `drupalSettings` by `options[value]` in the backend config form or the exposed identifier on the
  front end. `valueValidate()` requires a value when the filter is not exposed.

## Sort — `DateRangePickerSort` (`views_daterangepicker_sort`)

`src/Plugin/views/sort/DateRangePickerSort.php`, extends `SortPluginBase`.

- Option `daterange_part` (radios, default `start_date`): `start_date`, `end_date`, or `interval`.
- `query()` orders by:
  - `start_date` → `JSON_UNQUOTE(JSON_EXTRACT(field, '$.start'))`
  - `end_date` → `JSON_UNQUOTE(JSON_EXTRACT(field, '$.end'))`
  - `interval` → `DATEDIFF(end, start)` (number of days in the range)
  via `addOrderBy(NULL, $formula, $order, <alias>)`.
- When exposed, the order (ASC/DESC) selector is hidden so the end user chooses it.

## Notes

- Both handlers rely on MySQL/MariaDB JSON functions (`JSON_EXTRACT`, `JSON_UNQUOTE`) and, for the
  interval sort, `DATEDIFF`; other database backends are not supported by these queries.
