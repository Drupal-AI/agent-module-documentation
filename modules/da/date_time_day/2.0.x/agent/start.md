<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Date time day (date_time_day) — agent index

Provides one **field type** that stores a single date together with a **start time and an end time on
that same day** (e.g. "Tuesday, 09:00–17:00"). It is built directly on core `datetime`: the field type
`datetimeday` extends core `DateTimeItem`, adds two extra stored string columns (`start_time_value`,
`end_time_value`) plus computed `DrupalDateTime` properties (`start_time`, `end_time`), and reuses
core's date-storage plumbing. Storage has two settings: `datetime_type` (forced to date-only) and
`time_type` — either `time` (H:i) or `time_seconds` (H:i:s). Two widgets collect the values (one HTML
`date` input for the day plus text/time inputs for start and end), a validation callback enforces
`start ≤ end`, and one formatter renders `date <day_separator> start_time <time_separator> end_time`
using core's `<time>` theme.

- Depends on: `drupal:datetime` (core). Also implicitly needs core `field`.
- Core: `^10 || ^11`. Package: `Field types`. Version `2.0.2`.
- No settings page / no `configure` route — all configuration is per field via Field UI (storage
  settings, widget on *Manage form display*, formatter on *Manage display*). Provides config schema.
  No permissions, no services, no routes, no drush, no libraries, no templates.
- Does **not** define any new plugin *type/manager* — it ships plugin *instances* of core's field
  type / widget / formatter plugin types. One update hook: `date_time_day_update_8106`.
- Constraint to know before choosing it: everything is on **one day**, so nothing that crosses
  midnight fits (use core `datetime_range` for that).

## What you'd do → where

- **Add the field, set storage (`time` vs `time_seconds`), understand the stored columns / computed
  properties / default values** → [fields/field-type.md](fields/field-type.md)
- **Pick and configure the input widget on Manage form display** → [fields/widgets.md](fields/widgets.md)
- **Configure how the value is displayed (formats, separators, timezone)** →
  [fields/formatter.md](fields/formatter.md)

## Key facts (real machine names)

- Field type: `datetimeday` (`Plugin/Field/FieldType/DateTimeDayItem`, extends core `DateTimeItem`).
  `default_widget = datetimeday_default`, `default_formatter = datetimeday_default`,
  `list_class = DateTimeDayFieldItemList`.
- Stored columns: `value` (date, `Y-m-d`), `start_time_value`, `end_time_value` (time strings).
  Computed props: `date` (`DateDayComputed`), `start_time` / `end_time` (`DateTimeDayComputed`).
- Storage settings: `datetime_type` (kept = `date`), `time_type` ∈ {`time`, `time_seconds`}.
- Widgets: `datetimeday_default` (label "Date time day"), `datetimeday_h_i_s_time` (label
  "Date time day with seconds"); shared base `DateTimeDayWidgetBase` (`validateStartEnd`,
  `massageFormValues`). Both apply to field type `datetimeday`.
- Formatter: `datetimeday_default` (label "Default", extends core `DateTimeDefaultFormatter`).
  Settings: `format_type` (day, default `html_date`), `time_format_type` (default `html_time`),
  `day_separator` (`,`), `time_separator` (`-`), `timezone_override`.
- Storage-format constants (on `DateTimeDayItem`): `DATEDAY_TIME_DEFAULT_TYPE_FORMAT = 'time'`,
  `DATEDAY_TIME_TYPE_SECONDS_FORMAT = 'time_seconds'`, `DATE_TIME_DAY_H_I_FORMAT_STORAGE_FORMAT = 'H:i'`,
  `DATE_TIME_DAY_H_I_S_FORMAT_STORAGE_FORMAT = 'H:i:s'`.
- Config schema: `field.storage_settings.datetimeday`, `field.field_settings.datetimeday`,
  `field.value.datetimeday`, `field.formatter.settings.datetimeday_default`
  (+ base `field.formatter.settings.datetimeday_base`).
- Update hook: `date_time_day_update_8106` (migrates old storage: moves `datetime_type` value into the
  new `time_type` setting, resets `datetime_type` to date-only).
- Hook: `hook_help` (`help.page.date_time_day`).
