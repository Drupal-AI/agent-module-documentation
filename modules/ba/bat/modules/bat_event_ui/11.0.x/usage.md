BAT Event UI is the admin front end for managing BAT availability: it renders a FullCalendar-based calendar page for a unit type and event type where staff view and edit availability, plus a bulk "update event state" form to set the same state across a date range. It builds on BAT Fullcalendar and the BAT API (`bat_api`) module.

---

The module exposes a calendar page at `/admin/bat/calendar/{unit_type}/{event_type}`
(`BatEventUIController::calendarPage`, permission `administer calendar events`) that renders the
BAT Fullcalendar widget for a given unit type and event type, letting admins manage availability
visually. `BatEventUiBulkUpdateForm` provides a bulk operation: pick a state (options from
`bat_unit_state_options($event_type)`) and apply it to events across a selection — its `submitForm()`
loads/creates the relevant `bat_event` records and sets `event_state_reference` to the chosen state.
`BatEventUiEventTypeForm` supports event-type-specific UI. The module declares a dependency on
`bat_api` (a separate project that exposes BAT events as JSON/JSON:API feeds the calendar reads) and
on `bat_fullcalendar`; it defines no entities, permissions, config schema, or routes beyond the
calendar page. Use it to give hotel/rental staff a point-and-click availability management screen
rather than editing event entities one by one.

---

- Give staff a FullCalendar screen to manage a unit type's availability.
- Open the availability calendar for a specific unit type + event type.
- Visually create and edit availability events from the calendar.
- Bulk-update the state of events across a date range (`BatEventUiBulkUpdateForm`).
- Set availability state (available/blocked/etc.) for many events at once.
- Populate state options from the event type via `bat_unit_state_options()`.
- Drive the calendar from the BAT API JSON feeds (`bat_api`).
- Restrict calendar management to the `administer calendar events` permission.
- Provide an admin availability dashboard for a booking site.
- Manage availability without editing `bat_event` entities individually.
- Support event-type-specific UI via `BatEventUiEventTypeForm`.
- Combine month/timeline calendar views for operations staff.
- Update `event_state_reference` on selected events in one submit.
- Integrate with `bat_fullcalendar`'s in-calendar event-management modal.
- Serve as the day-to-day operations UI layered over `bat_event`.
- Route staff to per-type calendars from the BAT admin menu.
- Reduce manual event entry for recurring availability changes.
