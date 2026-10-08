<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views filter, Token & Feeds integrations

## Views filter — `ymd_date`

Wired in by `ymd_date.views.inc`:

- `hook_field_views_data()` → `ymd_date_field_views_data()` calls
  `ymd_date_type_field_views_data_helper()`, which starts from
  `views_field_default_views_data($field_storage)` and sets the field column's
  `filter.id` to **`ymd_date`** for every table. (Helper is reusable by other modules defining
  YMD-based fields; a `@todo` notes base-table fields are not yet covered.)

The handler is `src/Plugin/views/filter/Date.php` — class `Date`, annotation
`@ViewsFilter("ymd_date")`, **extends `NumericFilter`** ("the numeric filter is extended because it
provides more sensible operators", even though values are strings). Injects `date.formatter`.

- `defineOptions()` — adds `value.date_format` (default `year_only`).
- `buildExposeForm()` — adds a **Date format** radios control:
  `year_only` / `year_month` / `year_month_day`.
- `buildExposedForm()` — hides the raw numeric input and builds a `container-inline` fieldset
  (`{id}_ymd`) with a **year textfield** and, depending on `date_format`, **month** and **day**
  select lists (`monthOptions()` = month names, `dayOptions()` = 1–31). For the between/not-between
  operators (`operatorValues(2)`) it builds separate **min** and **max** fieldsets.
- `valueValidate()` / `validateExposed()` — enforce **`YYYYMMDD`**: `isDateCorrect()` accepts empty,
  otherwise `ltrim($value,'0')` must be `strlen === 8 && ctype_digit`. Error: *"Date must be in
  YYYYMMDD format."*
- `fixExposedDate()` + `getMinItems()` / `getMaxItems()` — pad a partial exposed input into a full
  `YYYYMMDD` bound. For a lower bound an unset month/day becomes `00`; for an upper bound it becomes
  `12`/`31`. This makes "year 1847" match the whole year rather than only `18470000`.
- `operators()` — overrides `=` and `!=` to method **`opEqual()`**.
- `opEqual()` — for a full year+month+day it also matches the `month = 00` variant via an OR group
  (so a value stored as year-only still matches a January query); for year-only / year+month it
  runs a `BETWEEN` / `NOT BETWEEN` over `[value … year(+month)+1231/31]`. All comparisons go through
  `$this->query->addWhere(...)` / `setWhereGroup()` (parameterized Views query builder).

Schema: `config/schema/ymd_date.views.schema.yml` — `views.filter.ymd_date` extends
`views.filter.numeric` (adds `expose.date_format` string), `views.filter_value.ymd_date` extends
`views.filter_value.numeric`.

Enable core **Views** (in core) to use it; add the YMD field as a filter and, for exposed use, pick
the Date-format granularity.

## Token — `year_only`

`ymd_date.tokens.inc`:

- `hook_token_info()` — for every content-entity type that has a YMD field, registers a **dynamic**
  token `{entity}-{field_name}:year_only` (name "Year only"), guarded by the presence of the
  `token.entity_mapper` service.
- `hook_tokens()` — resolves `year_only` (optionally `year_only:{delta}`) to the **first four
  characters** of the stored value (`substr($list[$delta]->get('value')->getValue(), 0, 4)`), i.e.
  the year.

So `[node:field_event_date:year_only]` yields `1847`. Requires the contrib **Token** module for the
`token.entity_mapper` service.

## Feeds target — `ymd_date_field_type`

`src/Feeds/Target/YMDDateFieldItem.php` — `@FeedsTarget(id = "ymd_date_field_type")` for
`field_types = { ymd_date_field_type }`, **extends the Feeds `Number` target**.

`prepareValue()` normalizes the incoming value: `ltrim($value, '0')` then, if non-empty and shorter
than 8 chars, `str_pad($value, 8, '0')` — i.e. it re-pads to the `YYYYMMDD` width. Requires the
contrib **Feeds** module (declared under composer `require-dev`).
