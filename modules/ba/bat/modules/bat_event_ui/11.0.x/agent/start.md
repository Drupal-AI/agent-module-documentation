# BAT Event UI — agent index

Admin front end for BAT availability: a FullCalendar page per unit type + event type, plus a bulk
"update event state" form. Builds on `bat_fullcalendar` and `bat_api` (a separate project exposing BAT
events as JSON feeds). Defines no entities/permissions/config of its own.

- **Calendar page + bulk update form** → [configure/ui.md](configure/ui.md)

Key facts:
- Route `bat_event_ui.calendar`: `/admin/bat/calendar/{unit_type}/{event_type}` →
  `BatEventUIController::calendarPage` (perm `administer calendar events`).
- `BatEventUiBulkUpdateForm`: state options from `bat_unit_state_options($event_type)`; submit sets
  `event_state_reference` on the selected `bat_event`s.
- `BatEventUiEventTypeForm` for event-type-specific UI.
- Depends on `bat_api` — install/enable that separate project for the calendar feeds.
