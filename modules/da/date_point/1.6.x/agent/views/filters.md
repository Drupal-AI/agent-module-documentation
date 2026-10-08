<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views integration

Date Point fields expose date-aware Views filters and an argument. Views is a **soft dependency**:
`src/Hook/FieldViewsData` (`#[Hook('field_views_data')]`) fetches
`FieldViewsDataProvider::defaultFieldImplementation()` from the container and rewrites the `<field>_value`
handler ids so the module's plugins are used — without requiring the Views module in the container.

## Handler wiring (`FieldViewsData::__invoke`)
For each field storage's `_value` column:
- `dp_date_time` → filter id `dp_date_time`, argument id `dp_date_time`.
- `dp_date` → filter id `dp_date`.
- `dp_time` → filter id `dp_time`.

## Filters (`src/Plugin/views/filter/`)
- **`DateTime`** (`#[ViewsFilter('dp_date_time')]`, extends `FilterPluginBase`). Options
  (`config/schema/date_point.views.schema.yml` → `views.filter.dp_date_time`):
  - `dp_widget` — exposed input widget: `date` | `datetime-local` (default) | `textfield`.
  - `dp_granularity` — `DateTime\Granularity` (microsecond…year, default `second`). Drives the SQL
    range: `Granularity::getBoundaries()` turns a single input + operator into start/end bounds so e.g.
    "= this day, granularity day" matches the whole day (see the enum docblock for the `<`/`<=`/`>`/`>=`
    boundary rules).
  - `dp_timezone_override` — timezone the input is interpreted in before conversion to UTC storage.
  - Operators come from `Data\Views\QueryOperator` (`<`, `<=`, `=`, `!=`, `>`, `>=`, and `empty`/
    `not_empty` when the handler definition sets `allow empty`).
- **`Date`** (`#[ViewsFilter('dp_date')]`) and **`Time`** (`#[ViewsFilter('dp_time')]`) — string-style
  filters for the date-only / time-only field types (`views.filter.dp_time` maps to
  `views.filter.string`).

## Argument (`src/Plugin/views/argument/DateTime.php`)
- **`DateTime`** (`#[ViewsArgument('dp_date_time')]`, extends `ArgumentPluginBase`). Single option
  `dp_granularity` (`Granularity`, default `second`) for contextual date filtering with the same
  granularity-boundary logic as the filter.

All handlers operate on the UTC-stored native date/time column, so range comparisons run in the
database against indexed values.
