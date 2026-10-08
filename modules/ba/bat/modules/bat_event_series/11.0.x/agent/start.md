# BAT Event Series — agent index

Recurring BAT events: a `bat_event_series` entity holds an iCal RRULE (via `rlanvin/php-rrule`) that
expands into individual `bat_event` records. Ships daily + hourly series types. Depends on `bat_event`.
No `configure` route; pages under `/admin/bat/events/event_series`.

- **Entity, series types, RRULE expansion, modal edit forms, routes** → [configure/series.md](configure/series.md)
- **Procedural API** → [api/api.md](api/api.md)

Key facts:
- `bat_event_series`: base table `event_series`, bundle `bat_event_series_type`, has an `rrule` field.
- Series-type config (`event_series_type.*`): `name`, `type`, `event_granularity`, `target_event_type`.
- Default types (config/install): `availability_daily` (`bat_daily`), `availability_hourly` (`bat_hourly`).
- Repeating-rule edit via modal forms `EditRepeatingRuleModalForm` +
  `EditRepeatingRuleConfirmationModalForm` (private tempstore `edit_repeating_rule`; use `RRule\RRule`).
- Ships `views.view.event_series`. Permission: `administer bat_event_series_type entities` + generated
  BAT scheme.
