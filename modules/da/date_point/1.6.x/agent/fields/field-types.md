<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Date Point field types

Four `final` Field API field types under `src/Plugin/Field/FieldType/`. Each extends
`FieldItemBase`, exposes its machine id as a `::ID` constant, stores a single required string `value`
property, defines a native DB column, and indexes `value`. Enable the module (`drush en date_point`);
no further config. Add a field via *Manage fields* — the types appear under category **date_time**.

## dp_date_time — `DateTime\DateTimeItem` (label "Date Time (DP)")
- Stores an RFC-3339-style datetime, **always in UTC** (`STORAGE_TIMEZONE = 'UTC'`).
- Column: `varchar` with `mysql_type` `datetime(P)` / `pgsql_type` `timestamp(P)`, P from precision.
- Storage setting `precision` (`Precision` enum: `second`|`millisecond`|`microsecond` → 0/3/6);
  format is `Y-m-d H:i:s` / `.v` / `.u` via `getFormat()`. Default `second`.
- Field setting `behavior` (`DateTime\Behavior`: `manual`|`created`|`updated`, default `manual`):
  - `created` — set to `clock()->now()` in `applyDefaultValue()` (on entity **create**).
  - `updated` — set on save (see `DateTimeItemList`); v1.6.0 fix skips auto-update for explicitly set
    values and during entity **sync** (migration, workspace publish).
- Constraints: `NotBlank` + `DateTimeConstraint` (precision-aware).
- Default widget `dp_date_time_local` (HTML5), default formatter `dp_date_time_default`.
- Helpers: `getDateTime(): \DateTimeImmutable`, `setDateTime()`, `getPrecision()`,
  `getStorageTimezone()`.

## dp_date — `Date\DateItem` (label "Date (DP)")
- Column: `varchar`, `mysql_type`/`pgsql_type` `date`, length 10, format `Y-m-d`, UTC.
- Constraints: `NotBlank` + `Date`.
- Default widget `dp_date` (also reuses core `string_textfield` via `FieldWidgetInfoAlter`);
  default formatter `dp_date_custom`. Also reuses core `string` formatter (`FieldFormatterInfoAlter`).
- Helpers: `getDate(): ?Date`, `setDate()` (value object `Data\Date`).

## dp_time — `Time\TimeItem` (label "Time (DP)")
- Column: `varchar`, native `time(P)`, base format `H:i:s` (+`.v`/`.u`), UTC.
- Storage setting `precision` (required). Constraints: `NotBlank` + `Time`.
- Default widget `dp_time`, default formatter `dp_time`; reuses core `string`/`string_textfield`.
- Helpers: `getTime(): ?Time`, `setTime()`, `buildFormat()`, `getPrecision()`.

## dp_year_month — `YearMonth\YearMonthItem` (label "Month (DP)")
- Column: `char(7)`, format `Y-m` (no native temporal type).
- Constraints: `NotBlank` + `YearMonthConstraint`.
- Default widget `dp_year_month`, default formatter `dp_year_month_custom`; reuses core `string`
  formatter. Helpers: `getYearMonth(): ?YearMonth`, `setYearMonth()`.

## Precision (`src/Data/Precision.php`)
Enum `second`/`millisecond`/`microsecond`; `toInteger()` → 0/3/6 for fractional-second column defs;
`getOptions()`/`getLabel()` feed the radios in the storage-settings form.

## Formatters (`src/Plugin/Field/FieldFormatter/**`)
- DateTime: `DefaultFormatter` (`dp_date_time_default`, settings `format_id` + `timezone_override`),
  `CustomFormatter` (`dp_date_time_custom`, PHP `format` + tz), `PlainFormatter` (`dp_date_time_plain`,
  tz only), plus `AbstractFormatter` base.
- Date: `DateFormatter` (`dp_date`), `CustomFormatter` (`dp_date_custom`) — settings key `format`.
- Time: `TimeFormatter` (`dp_time`, `format`). YearMonth: `CustomFormatter` (`dp_year_month_custom`,
  `format`). Formatter settings are validated by `config/schema/date_point.schema.yml`.

## Widgets (`src/Plugin/Field/FieldWidget/**`)
- DateTime: `DateTimeLocalWidget` (`dp_date_time_local`, HTML5 `datetime-local`, `step` setting),
  `TextfieldWidget`, `AbstractWidget`.
- Date: `DateWidget`. Time: `TimeWidget` (`step`). YearMonth: `YearMonthWidget`, `TextFieldWidget`.

## Value objects & sample data
`Data\Date`, `Data\Time`, `Data\LocalDateTime`, `Data\YearMonth` wrap parsing/formatting/conversion
(e.g. `Date::fromDateTime()`, `Time::fromSeconds()`, `YearMonth::fromDateTime()`,
`LocalDateTime::toTimestamp()`). Each field type implements `generateSampleValue()` for content
generation. Auto-populating field types pull "now" from the clock service (`ClockTrait::getClock()`),
so tests can freeze time via the Time Machine submodule.
