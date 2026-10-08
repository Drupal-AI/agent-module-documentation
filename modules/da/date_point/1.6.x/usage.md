Date Point provides field types that store a point in time — date, time, date-time, and year-month — in native database date/time columns, plus PSR-20 clock services for reading "now".

---

Date Point adds four Field API field types (`dp_date_time`, `dp_date`, `dp_time`, `dp_year_month`) whose values are stored in native database column types (MySQL/PostgreSQL `datetime`, `date`, `time`, and a `char(7)` month) rather than the string/int storage core's Datetime and Timestamp fields use. Storage is always UTC and (for date-time and time) supports configurable precision — second, millisecond, or microsecond — mapped onto fractional-second column types. Each field type ships widgets (HTML5 `datetime-local`, plain textfields) and formatters (default, custom PHP date format, plain, RFC storage), Symfony Validator constraints, sample-value generators, and Views integration with dedicated date-aware filters and a date argument that understand granularity and timezone. The module also exposes a PSR-20 `Psr\Clock\ClockInterface` service (`date_point.clock`), a drop-in `date_point.time` implementation of core's `TimeInterface`, helper functions (`Drupal\date_point\now()`, `time()`, `clock()`), and `date-point:now` / `date-point:clock-list` CLI commands. Two hidden helper submodules — `date_point_time_machine` (current) and `dp_clock_mock` (deprecated) — let you freeze or shift "now" for automated tests and manual QA. The `dp_date_time` field can auto-populate on entity create ("Created" behavior) or on save ("Updated" behavior), or be entered manually.

---

- Add a date-and-time field to a content type using the `dp_date_time` field type stored in a native DB `datetime` column.
- Store a date-only value (birthday, publish date) with the `dp_date` field type in a native `date` column.
- Store a time-of-day value (opening time) with the `dp_time` field type in a native `time` column.
- Store a year-and-month value (expiry, billing period) with the `dp_year_month` field type in a `char(7)` `Y-m` column.
- Choose second, millisecond, or microsecond precision for date-time or time fields via storage settings.
- Auto-set a date-time field to the creation timestamp using the "Created" behavior.
- Auto-update a date-time field to the save timestamp using the "Updated" behavior (skipped during content sync/migration).
- Sort or range-query entities efficiently by relying on native indexed date/time columns.
- Format a date-time value with a site date format via the default formatter, with an optional timezone override.
- Render a date value with an arbitrary PHP date format via the custom formatter.
- Display the raw stored (UTC) value with the plain formatter.
- Filter a View by a date-time field with granularity-aware boundaries (day/month/year/hour...).
- Add a Views argument on a date-time field for contextual date filtering.
- Filter a View by date-only or time-only fields with the `dp_date` / `dp_time` filters.
- Read the current time through the PSR-20 `date_point.clock` service instead of `time()` for testable code.
- Inject `Psr\Clock\ClockInterface` into your own services for time that can be mocked in tests.
- Replace core's `datetime.time` with `date_point.time` in your code paths to make request/current time controllable.
- Print the current timestamp in any format/timezone from the CLI with `drush date-point:now -m "+1 day" -t UTC`.
- List every clock/time service and its current value with `drush date-point:clock-list`.
- Freeze system time in a kernel/functional test with the Time Machine submodule's clock services.
- Shift a whole site's "now" for manual QA with `drush time-machine:travel-to tomorrow` and revert with `drush time-machine:return`.
- Validate user-entered date/time/month input with the module's Symfony Validator constraints.
- Generate realistic sample date/time values for a field with Devel-style content generation.
- Migrate existing core datetime data into a compact native-typed date-point column.
