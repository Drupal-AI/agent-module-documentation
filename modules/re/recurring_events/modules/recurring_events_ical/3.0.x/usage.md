Recurring Events iCalendar adds downloadable `.ics` (iCalendar) exports for event series and instances, plus a configurable mapping of iCalendar properties (SUMMARY, DTSTART, LOCATION, …) to token/field values.

---

The submodule exposes two download routes — `/events/series/{eventseries}/ical` and `/events/{eventinstance}/ical` — each gated by the parent module's view access (`eventseries.view` / `eventinstance.view`); `EventExportController` returns a `text/calendar` attachment (`event.ics`) whose body is built by the `recurring_events_ical.event_ical` service (`EventICal::render()`, injected with the entity type manager, request stack and token service). It defines an `event_ical_mapping` config entity (managed at `/admin/structure/events/ical`, permission `administer eventinstance types`) that maps iCalendar properties to values using tokens, so you control exactly which fields populate each VEVENT property; schema `recurring_events_ical.event_ical_mapping.*` with per-property `recurring_events_ical.ical_property.*`. It also adds a computed `event_ical_link` base field to both event entity types (a formatter/field type/field item list under `src/Field` and `src/Plugin/Field`) and registers an `ical` link template on each, so themes and view displays can render a ready-made "Add to calendar" link. Requires the parent `recurring_events` and the `token` module.

---

- Let visitors download an event instance as an `.ics` file to add to their calendar app.
- Download an entire event series as a single iCalendar file.
- Provide an "Add to calendar" link on event pages via the computed `event_ical_link` field.
- Map the iCalendar SUMMARY property to the event title (or any token).
- Map DTSTART/DTEND to the event's date field.
- Populate LOCATION, DESCRIPTION, URL and other properties from event fields via tokens.
- Configure multiple property mappings for different event/instance types.
- Serve calendar files with the correct `text/calendar` content type and attachment filename.
- Respect event view access on calendar downloads (uses `eventseries.view` / `eventinstance.view`).
- Render the calendar link in a specific view mode / display via the added link template.
- Integrate event schedules with Outlook, Google Calendar, or Apple Calendar imports.
- Customize exported property values without code by editing the iCal mapping entity.
- Expose the ical link programmatically through the entity's `ical` link template.
- Give each event type its own iCalendar property mapping.
- Use token replacement so mappings adapt per-event automatically.
- Offer subscribers a portable, standards-compliant event file.
