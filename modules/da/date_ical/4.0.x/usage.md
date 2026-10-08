Date iCal exports date/event content as RFC-5545 iCalendar (.ics) feeds. Its core deliverable is a Views feed display that renders results as a VCALENDAR of VEVENTs, driven by a row plugin that maps Views fields to iCal properties (DTSTART, SUMMARY, LOCATION, RRULE, ATTENDEE, GEO, ATTACH, …). It also ships an "Add to calendar" field formatter, a CKEditor 5 button that inserts per-event download links, and an optional Feeds parser for importing external .ics feeds.

---

Building the feed is a Views task: create a **Feed** display, set its Format to the **iCal Feed** style and the **iCal Fields** row plugin, then map at least a Date field (DTSTART) plus any optional properties. The style plugin (`src/Plugin/views/style/DateIcal.php`) builds the VCALENDAR header (X-WR-CALNAME/CALDESC/RELCALID/TIMEZONE) and options like webcal:// linking, DTSTAMP exclusion, and punctuation unescaping; the row plugin (`src/Plugin/views/row/DateICal.php`) resolves each field to an iCal component. Both hand a normalized event array to the reusable `date_ical.feed` service (`src/DateICal.php`), which wraps the `kigkonsult/icalcreator` library to produce the actual VCALENDAR string, populating VTIMEZONE automatically. A separate route + controller (`src/Controller/DateIcalController.php`) powers the field-formatter and CKEditor download links; both endpoints are open (`_access: TRUE`) but the feed controller enforces entity- and field-level view access before emitting data. `hook_date_ical_export_vevent` / `hook_date_ical_export_post_render` let other modules alter output, and `hook_date_ical_import_vcalendar` / `hook_date_ical_import_component` hook the importer. The module has no settings form, no permissions, and no dependencies beyond Views (core); Feeds and CKEditor 5 integrations are optional.

---

- Export a Views listing of events as a subscribable .ics/webcal feed.
- Publish a public calendar (e.g. `/events/ical`) clients can subscribe to.
- Map a date field to DTSTART and a second field to DTEND for each event.
- Include SUMMARY, DESCRIPTION, and LOCATION from arbitrary Views fields.
- Attach GEO coordinates (and X-APPLE-STRUCTURED-LOCATION) to events.
- Emit recurring events via a FREQ/COUNT selector or a raw RRULE field.
- Add EXDATE / RDATE / EXRULE exceptions from a raw RRULE string.
- Map user or email fields to ORGANIZER and ATTENDEE properties.
- Set per-event STATUS (CONFIRMED / CANCELLED / TENTATIVE).
- Add VALARM reminders from an integer "minutes before" field.
- Attach files or links to events as ATTACH properties.
- Name the calendar (X-WR-CALNAME) or omit it so events merge into an existing calendar.
- Force file download instead of webcal:// subscription for the feed link.
- Exclude DTSTAMP to stop buggy clients marking every event as "updated".
- Unescape commas/semicolons for calendar clients that mishandle escaping.
- Add an "Add to calendar" link to a date field via the Date iCal field formatter.
- Let editors insert per-event .ics download links inside CKEditor 5 body text.
- Generate a single-event .ics on demand from URL query parameters.
- Import external .ics feeds into nodes/entities using the Feeds parser.
- Map imported SUMMARY, DTSTART, RRULE, LOCATION, ORGANIZER, GEO, etc. to fields.
- Reuse the `date_ical.feed` service from custom code to build VCALENDAR output.
- Alter generated VEVENTs or the final calendar string via alter hooks.
- Serve a per-entity iCal feed for one date field on one entity via a route.
- Automatically populate VTIMEZONE blocks for the site timezone.
