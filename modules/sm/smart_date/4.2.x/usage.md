Smart Date provides a `smartdate` field type storing a start time, end time and duration, with an app-like editing widget and intelligent, condensed date/time display (e.g. "Mon, Jan 6, 2025, 5–7pm").

---

Smart Date extends Drupal's date handling to feel more like modern calendar apps. Its field type stores start and end timestamps plus a duration, and the widget lets editors pick a duration that auto-fills the end time, mark events as all-day, and pick common presets. On display it collapses redundant parts intelligently — hiding the end date when it matches the start, hiding the year for the current year, and rendering time ranges compactly — controlled by reusable **Smart date format** config entities managed at Admin → Configuration → Regional and language → Smart date formats. Several field formatters ship (default, plain, custom, duration) and the formatting logic is exposed statically via `SmartDateTrait::formatSmartDate()` for use in code. The optional **Smart Date Recurring** submodule adds RRULE-based recurring events (powered by the `simshaun/recurr` library), per-instance overrides, cancellations, and management UIs. Integrations exist for Views, Feeds, migrate, diff, and FullCalendar View. A Drush command migrates legacy datetime/daterange fields to Smart Date. It depends only on core's Datetime and Options modules, making it a lightweight but powerful replacement for date range fields on event-driven sites.

---

- Store an event's start and end time in a single field.
- Let editors set a duration that auto-calculates the end time.
- Mark an event as "all day" with one checkbox.
- Display "5–7pm" style compact time ranges automatically.
- Hide the end date when it equals the start date.
- Omit the year for events in the current year.
- Create reusable named date formats and reuse them site-wide.
- Show only the date, only the time, or both via a format.
- Build a fully custom date/time display string.
- Show a human-friendly duration ("2 hours") with the duration formatter.
- Add recurring events with RRULE rules (Recurring submodule).
- Let editors override a single instance of a recurring series.
- Cancel one occurrence of a recurring event.
- Reschedule future instances of a recurring series.
- Power an events calendar with FullCalendar View integration.
- Filter or sort events by start/end in Views.
- Import event dates via Feeds into a Smart Date field.
- Migrate existing datetime/daterange fields to Smart Date with Drush.
- Show start/end differences in content revision diffs.
- Format a smart date value programmatically in custom code.
- Provide app-like date entry for a booking or scheduling site.
- Restrict who can configure date formats via permission.
- Display timezone-aware event times with the timezone widget.
- Offer inline date entry with the inline widget.
- Handle open-ended events (start with no fixed end).
- Normalize dates for JSON:API / REST output via the normalizer.
