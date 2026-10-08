<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Timestamp to Date adds a single global Views field that reads another field's raw Unix timestamp and renders it as a formatted date, without changing how the value is stored.

---

Plenty of data arrives as an integer timestamp: an imported `created` value, a raw database column read via Views Database Connector, a third-party system's epoch field, a non-entity table joined into a view. Core's date field handler expects an entity date field, so a raw integer just prints as a number. This module registers one "Global: Timestamp to Date" field (available in every view via a `#global` join) whose handler extends core's Date field. You add the field that outputs the timestamp, add this field, point its "Timestamp Field" option at the first one, and pick a date format. The handler runs no query of its own — it pulls the sibling field's value from the result row and formats it with core's date formatter, giving you the full core date-format UI: named formats, a custom PHP `date()` format, the relative "time ago / time hence / time span" formats (where the custom-format box is read as granularity), and an optional timezone override. It depends on core `views` alone and ships only `config/schema`. Because a Unix timestamp is an absolute instant with no timezone, keep the timezone option consistent with how the same value is displayed elsewhere so dates do not appear off by a day.

---

- Display a raw `created` timestamp column as a readable date.
- Format an imported epoch value in a view.
- Show a Views Database Connector table's timestamp as a date.
- Render a non-entity table's integer date column.
- Present a third-party system's epoch field to editors.
- Format a legacy timestamp without a computed field.
- Show a log table's timestamp as "time ago".
- Display a migrated record's original date.
- Apply a custom PHP date format to an integer timestamp.
- Output a timestamp as a relative "time hence" value.
- Show elapsed time as a "time span".
- Format an integration record's timestamp for a report.
- Present a queue/job table's run time as a date.
- Render an API-sourced epoch value in a dashboard.
- Format a raw SQL view's timestamp column.
- Show an event's stored timestamp in medium/long date format.
- Apply a specific timezone to a displayed timestamp.
- Display a numeric date field with day/month granularity text.
- Avoid writing a per-project custom Views field handler.
- Format multiple timestamp columns in the same view.
