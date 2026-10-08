# Calendar Systems — agent index

Localizes Drupal dates into non-Gregorian calendars (mainly Persian/Jalali) by overriding core's
`date.formatter` service and swapping date render elements, field widgets, and Views date
plugins. Depends on core `datetime`. No configure route, no permissions, no Drush, no config schema.

- **How dates get localized: `date.formatter` override, `CalendarSystemsDrupalDateTime`, the
  `[date:gregorian]` tokens, calendar/language selection** → [api/formatting.md](api/formatting.md)
- **The Calendar Systems block (current/relative date in a chosen calendar/format/timezone)** →
  [configure/block.md](configure/block.md)
- **What the module swaps (elements, widgets, Views filters/arguments) and how to extend calendars** →
  [extend/swaps.md](extend/swaps.md)

Submodules (own docs):
- `calendar_systems_bef` → [../../modules/calendar_systems_bef/4.0.x/agent/start.md](../../modules/calendar_systems_bef/4.0.x/agent/start.md)
- `calendar_systems_fullcalendar` → [../../modules/calendar_systems_fullcalendar/4.0.x/agent/start.md](../../modules/calendar_systems_fullcalendar/4.0.x/agent/start.md)

Key facts:
- `CalendarSystemsServiceProvider::alter()` sets `date.formatter` class to `CalendarSystemsFormatter`.
- Calendar chosen by interface language: `fa` → `persian`, `en` → `gregorian`; single-language sites
  default to Persian. Constant `CALENDAR_SYSTEMS_USE_INTL` is `FALSE` by default → uses the bundled
  "poor man's" Jalali/Gregorian classes rather than PHP `IntlCalendar`.
- JS library `calendar_systems/picker` (bundled persian-date + persian-datepicker) is attached to
  `date` and `datetime` elements.
- Block plugin id `calendar_systems_block`.
