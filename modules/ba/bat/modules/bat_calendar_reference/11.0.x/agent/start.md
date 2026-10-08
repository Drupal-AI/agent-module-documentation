# BAT Calendar Reference — agent index

Field types to reference a BAT unit / unit type from any fieldable entity and render its availability
calendar inline (month, timeline, or raw) via BAT Fullcalendar. Depends on `bat_fullcalendar`. No
config entities, permissions, or settings of its own.

- **Field types, widgets, formatters, autocomplete** → [configure/field.md](configure/field.md)

Key facts:
- Field types: `bat_calendar_unit_reference` (→ `bat_unit`), `bat_calendar_unit_type_reference`
  (→ `bat_unit_type`).
- Widgets: `bat_calendar_reference_unit_autocomplete`, `bat_calendar_reference_unit_type_autocomplete`.
- Formatters: `bat_calendar_reference_month_view`, `bat_calendar_reference_timeline_view`,
  `bat_calendar_reference_raw_formatter`.
- Autocomplete routes (`/bat_unit_reference_autocomplete/...`, `/bat_event_type_reference_autocomplete/...`)
  use `_access: TRUE` but validate an HMAC selection-settings key (`Settings::getHashSalt()`) exactly
  like core's `EntityAutocompleteController` — not open access to data.
