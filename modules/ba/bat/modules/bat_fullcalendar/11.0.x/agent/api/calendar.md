# BAT Fullcalendar — rendering & event-management API

## Rendering

Output is the `bat_fullcalendar` theme hook (`template_preprocess_bat_fullcalendar`), attaching the
FullCalendar JS library and `drupalSettings`. `bat_fullcalendar_configure(array $user_settings)`
merges per-widget options with defaults and fires `hook_bat_calendar_settings_alter()`; use it to
build the settings for a calendar instance.

## Event formatters (services)

- `bat_fullcalendar.fixed_state_event_formatter` — `FullCalendarFixedStateEventFormatter`
  (`current_user`, `module_handler`): formats **fixed-state** event types into calendar entries.
- `bat_fullcalendar.open_state_event_formatter` — `FullCalendarOpenStateEventFormatter`
  (`current_user`, `config.factory`, `module_handler`, `entity_type.manager`): formats **open/value**
  event types, colouring periods using `bat_open_state_default_color` and
  `bat_open_state_default_zero_color`.

Both let `hook_bat_fullcalendar_formatted_event_alter(&$formatted_event)` post-process each entry
(e.g. hide booking titles from non-privileged users).

## Event-management modal

Route `bat_fullcalendar.event_management`:
`/admin/bat/fullcalendar/{entity_id}/event/{event_type}/{event_id}/{start_date}/{end_date}`.

- `event_type` resolves to a `bat_event_type`; `start_date`/`end_date` use the base `bat_date` param
  converter (→ `DateTime`).
- **Access** `_event_management_access` (`EventManagementAccessCheck`): if `event_id == 0` →
  `bat_event_access(bat_event_create(['type' => $event_type]), 'create', $account)`; else
  `bat_event_access(bat_event_load($event_id), 'update', $account)`. So the modal is only reachable
  by users allowed to create/update that specific event.
- `BatFullcalendarController::fullcalendarEventManagement()` invokes
  `hook_bat_fullcalendar_modal_content()` and returns an AJAX `OpenModalDialogCommand` (or the hook's
  own commands). The default modal content is the `FullcalendarEventManagerForm`, which writes the
  event via `bat_event` (`Event::batStoreSave()`).

## Modal style

`bat_fullcalendar_modal_style($style = 'default')` resolves the modal dialog style, alterable through
`hook_bat_fullcalendar_modal_style_alter()`.
