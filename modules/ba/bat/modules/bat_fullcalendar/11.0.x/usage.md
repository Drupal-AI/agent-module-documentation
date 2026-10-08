BAT Fullcalendar is the calendar-rendering layer of the BAT suite: it wraps the FullCalendar JS library (from `fullcalendar_library`) to display BAT availability events, and provides an event-management modal so admins can create/update events by clicking or dragging on the calendar. It also formats BAT events (fixed-state and open/value events) into the shape FullCalendar expects.

---

The module renders a `bat_fullcalendar` themed calendar and attaches JS driven by `drupalSettings`.
Its central config helper `bat_fullcalendar_configure()` merges per-widget user settings with defaults
and fires `hook_bat_calendar_settings_alter()`. Two event formatters turn BAT events into calendar
entries: `FullCalendarFixedStateEventFormatter` (for fixed-state event types) and
`FullCalendarOpenStateEventFormatter` (for open/value event types, colouring free periods with the
configurable `bat_open_state_default_color` / `..._zero_color`). Clicking an event opens a modal via
the route `/admin/bat/fullcalendar/{entity_id}/event/{event_type}/{event_id}/{start_date}/{end_date}`;
the route's `_event_management_access` check calls `bat_event_access()` for **create** (when
`event_id == 0`) or **update** on the specific event, so the modal is only reachable by users allowed
to manage that event. The controller invokes `hook_bat_fullcalendar_modal_content()` and returns the
`FullcalendarEventManagerForm` in an AJAX modal dialog. Settings (`bat_fullcalendar.settings`) — default
open-state colours and optional FullCalendar Scheduler license keys — are edited at
`/admin/bat/config/fullcalendar` (perm `administer calendar events`). Hooks let other modules alter
calendar settings, modal style/content, and each formatted event (e.g. hide booking titles from
non-privileged users).

---

- Render BAT unit availability as an interactive FullCalendar widget.
- Let admins create a new availability event by clicking/dragging on the calendar.
- Let admins update an existing event through the calendar modal.
- Gate the event-management modal by per-event create/update access (`_event_management_access`).
- Format fixed-state events for the calendar (`FullCalendarFixedStateEventFormatter`).
- Format open/value-state events, colouring free vs zero-value periods (`FullCalendarOpenStateEventFormatter`).
- Configure default colours for open-state availability (`bat_open_state_default_color` / `..._zero_color`).
- Store a FullCalendar Scheduler license key (regular or commercial) in settings.
- Alter calendar settings globally via `hook_bat_calendar_settings_alter()`.
- Replace or restyle the event modal via `hook_bat_fullcalendar_modal_style_alter()` / `_modal_content()`.
- Hide sensitive event titles (e.g. guest names) from non-privileged viewers via
  `hook_bat_fullcalendar_formatted_event_alter()`.
- Restrict who may view past events with the `view past event information` permission.
- Provide the calendar API that `bat_event_ui` and `bat_calendar_reference` build their UIs on.
- Merge per-widget calendar options with site defaults via `bat_fullcalendar_configure()`.
- Present availability across many units/types in a single scheduler view.
- Drive availability edits without a separate admin form (in-calendar editing).
- Theme the calendar output via the `bat_fullcalendar` theme hook.
- Localize and configure the calendar through `drupalSettings`.
- Integrate a commercial FullCalendar Scheduler build when licensed.
- Serve as the display dependency for the `bat_calendar_reference` field formatters.
