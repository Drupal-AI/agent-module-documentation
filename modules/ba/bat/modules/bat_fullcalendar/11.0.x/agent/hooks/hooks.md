# BAT Fullcalendar — hooks

Documented in `bat_fullcalendar.api.php`.

- `hook_bat_calendar_settings_alter(&$calendar_settings)` — alter the merged calendar settings before
  they reach `drupalSettings` (fired by `bat_fullcalendar_configure()`).
- `hook_bat_fullcalendar_modal_style_alter(&$modal_style)` — change the event modal's dialog style.
- `hook_bat_fullcalendar_modal_content($unit, $event_type, $event_id, $start_date, $end_date)` —
  return the render/commands for the event-management modal (the base module returns the
  `FullcalendarEventManagerForm`; the last implementation wins — `array_pop`).
- `hook_bat_fullcalendar_formatted_event_alter(array &$formatted_event)` — post-process each formatted
  calendar entry. Example from `api.php`: hide blocking availability titles from users without
  `create bat_event entities of bundle availability`, showing "Not Available" instead.
