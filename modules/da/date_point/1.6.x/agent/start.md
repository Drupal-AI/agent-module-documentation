<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Date Point (date_point) — agent index

Field types that store a point in time in **native DB date/time columns**, plus PSR-20 clock
services. Core `^11.3`, PHP `>=8.4`. Requires `symfony/validator ^7.4`, `psr/clock ^1.0`. No
config UI, no permissions. Package: Fields. License GPL-2.0-or-later.

## What it provides
- **Field types** (`Plugin/Field/FieldType/**`): `dp_date_time`, `dp_date`, `dp_time`,
  `dp_year_month` — each `final` `FieldItemBase` with a `::ID` const, native `mysql_type`/`pgsql_type`
  schema, UTC storage, indexed `value` column.
- **Widgets**: HTML5 `dp_date_time_local`, textfield widgets, `dp_time`, `dp_date`, `dp_year_month`
  widgets; `dp_date`/`dp_time`/`dp_year_month` also reuse core `string`/`string_textfield` via
  `Hook/FieldWidgetInfoAlter` and `Hook/FieldFormatterInfoAlter`.
- **Formatters** (`Plugin/Field/FieldFormatter/**`): default, custom, plain (date-time), custom/date
  (date), time, year-month custom.
- **Validation constraints** (`Plugin/Validation/Constraint/**`): DateTime, Date, Time, YearMonth.
- **Views plugins**: filters `dp_date_time`, `dp_date`, `dp_time`, argument `dp_date_time`
  (`Plugin/views/**`), wired by `Hook/FieldViewsData`.
- **Clock services**: `date_point.clock` (PSR-20 alias → `SystemClock`), `date_point.clock.request`
  (`RequestClock`), `date_point.time` (`Time`, core `TimeInterface`). Trait `Clock/ClockTrait`.
  Helper functions in `src/date_point.php`: `now()`, `time()`, `clock()`.
- **Drush/console commands** (`drush.services.yml`, `src/Command/**`): `date-point:now` (alias `now`),
  `date-point:clock-list` (alias `clocks`).
- **Enums** (`src/Data/**`): `Precision` (second/millisecond/microsecond → 0/3/6), `DateTime\Behavior`
  (manual/created/updated), `DateTime\Granularity`, `Views\QueryOperator`; value objects `Date`,
  `Time`, `LocalDateTime`, `YearMonth`.
- **Config schema**: `config/schema/date_point.schema.yml` (+ views schema); install date formats
  `dp_storage`, `dp_storage_ms`, `dp_storage_us`.

## Submodules (both `hidden`, dev/test only — keep off production)
- **date_point_time_machine** (current) — mockable clocks + `time-machine:travel-to` / `:return`.
  Nested docs: `../../modules/date_point_time_machine/1.6.x/agent/start.md`.
- **dp_clock_mock** (deprecated, removed in 2.0.0) — legacy file-based clock mock functions.
  Nested docs: `../../modules/dp_clock_mock/1.6.x/agent/start.md`.

## Solution docs
- Field types, storage, precision, behavior, widgets, formatters: `fields/field-types.md`
- Clock/time services, helpers, CLI commands: `api/clock.md`
- Views filters & argument: `views/filters.md`
