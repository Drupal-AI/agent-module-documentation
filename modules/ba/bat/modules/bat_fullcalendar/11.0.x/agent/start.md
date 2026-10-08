# BAT Fullcalendar — agent index

Calendar rendering + in-calendar event management for BAT. Wraps the FullCalendar JS library
(`fullcalendar_library`) to show availability and lets admins create/update events from the calendar.
No `configure` route; settings at `/admin/bat/config/fullcalendar`.

- **Rendering, `bat_fullcalendar_configure()`, the two event formatters, event-management route** →
  [api/calendar.md](api/calendar.md)
- **Settings (colours, Scheduler keys) + permissions** → [configure/settings.md](configure/settings.md)
- **Hooks (settings, modal, formatted-event alters)** → [hooks/hooks.md](hooks/hooks.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Event-management route `/admin/bat/fullcalendar/{entity_id}/event/{event_type}/{event_id}/{start_date}/{end_date}`
  is gated by `_event_management_access` → `bat_event_access()` create (event_id 0) or update.
- Formatters: `FullCalendarFixedStateEventFormatter`, `FullCalendarOpenStateEventFormatter`.
- Settings config `bat_fullcalendar.settings`: `bat_open_state_default_color`,
  `bat_open_state_default_zero_color`, `bat_fullcalendar_scheduler_key`,
  `bat_fullcalendar_scheduler_commercial_key`.
- Permissions: `administer calendar events`, `view past event information`.
