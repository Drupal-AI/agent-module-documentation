# Add & configure the field

No central admin UI — it is a field type. Add it via **Field UI**: on an entity bundle → Manage
fields → Add field → choose **Office hours** (field type id `office_hours`). Then set widget and
formatter on the Manage form display / Manage display tabs. Config schema:
`config/schema/office_hours.schema.yml` (all settings are exportable).

## Field types (`src/Plugin/Field/FieldType`)
- `office_hours` — the main weekly-hours item.
- `office_hours_exceptions` — exception days (specific dates, e.g. holidays).
- `office_hours_season_header` / `office_hours_season_item` — seasonal date-range hours.
- `office_hours_status` — computed open/closed status value.

## Widgets (`src/Plugin/Field/FieldWidget`)
- `OfficeHoursWeekWidget` — compact weekly grid.
- `OfficeHoursListWidget` — list-style entry.
- `OfficeHoursComplexWeekWidget` — week + comments/multiple slots.
- `OfficeHoursSeasonWidget`, `OfficeHoursExceptionsWidget` — seasons / exception days.

## Formatters (`src/Plugin/Field/FieldFormatter`)
- `OfficeHoursFormatterDefault`, `OfficeHoursFormatterTable`,
  `OfficeHoursFormatterTableSelectList` — schedule displays.
- `OfficeHoursFormatterStatus` — live open/closed status (uses the AJAX status-update endpoint;
  see [../api/status.md](../api/status.md)).
- `OfficeHoursFormatterSchema` — schema.org structured-data output.

Formatter/widget settings (slot count, time format, day grouping, current-day highlight, etc.)
are set in Field UI and stored as third-party/formatter settings.
