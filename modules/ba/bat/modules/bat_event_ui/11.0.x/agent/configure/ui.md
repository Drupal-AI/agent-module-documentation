# BAT Event UI — calendar page & bulk update

## Calendar page

Route `bat_event_ui.calendar`: `/admin/bat/calendar/{unit_type}/{event_type}` →
`BatEventUIController::calendarPage($unit_type, $event_type)`, permission **`administer calendar
events`**. Renders the BAT Fullcalendar widget (see `bat_fullcalendar`) for the given unit type and
event type. `{unit_type}` / `{event_type}` may be `all`. The calendar's events are fed by the
`bat_api` module's JSON endpoints (declared dependency).

## Bulk update form (`BatEventUiBulkUpdateForm`)

`buildForm($form, $form_state, $unit_type = 'all', $event_type = 'all')`:

- A **State** `select` whose options come from `bat_unit_state_options($event_type)`.
- Hidden fields carrying the unit/event-type context and the selected date range.
- On submit (`submitForm`): loads/creates the affected `bat_event` records and sets
  `event_state_reference` to the chosen state, applying one state across the selection.

## Event type form

`BatEventUiEventTypeForm` provides event-type-specific interface support used by the calendar UI.

This module adds no permissions, entities, or config of its own — it reuses `administer calendar
events` (from `bat_fullcalendar`) and the `bat_event` / `bat_unit` APIs. Enable the separate `bat_api`
project for the calendar to load its events.
