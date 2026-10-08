<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Duration Field adds a Field API field type (`duration`) plus two Form API elements (`duration` and `granularity`) for collecting a length of time — any combination of years, months, days, hours, minutes, seconds (and optionally weeks) — stored as an ISO 8601 duration string.

---

The `duration` field stores three columns: an ISO 8601 duration string (`duration`, e.g. `P1Y2M10DT2H30M`), the equivalent number of `seconds` (a big integer used so durations can be compared mathematically in queries), and a `weeks` integer (since ISO 8601 duration strings have no week component). Each field instance has two settings: a **granularity** string (`y:m:d:h:i:s`) that decides which time units the widget collects, and an **include weeks** toggle. The `duration_widget` renders one numeric input per enabled granularity unit; on submit the values are assembled into a `DateInterval` and stored. Three field formatters ship: **Human Friendly** (`duration_human_display`, the default — "1 year 2 months", with `full`/`short` text length and space/hyphen/comma/newline separators), **Duration String** (`duration_string_display`, the raw ISO 8601 string) and **Time Format** (`duration_time_display`, `YY/MM/DD HH:MM:SS`). Two services do the heavy lifting: `duration_field.service` (`DurationService`) converts between arrays, `DateInterval`s, duration strings, seconds and human-readable text; `duration_field.granularity.service` converts between granularity strings and arrays. A query alter (tag `duration_string`) rewrites conditions on a `<field>_duration` column into `<field>_seconds` comparisons so you can filter with human duration strings. It also provides a REST/JSON:API normalizer, validation constraints, two hooks (`hook_duration_field_separators()` / `hook_duration_field_labels()`) for custom separators, and a Drush command `duration_field:prepare_uninstall`. No admin settings page (`configure` is null) and no permissions — everything is configured per field on the field's Manage fields / form display / display pages.

---

- Add an "estimated reading time" or "video length" field collecting hours, minutes and seconds.
- Store a recipe's "prep time" and "cook time" as durations.
- Capture a warranty or subscription length in years and months.
- Record a task's estimated effort in days and hours.
- Collect a race or workout time in minutes and seconds only (granularity `i:s`).
- Limit a field to whole years (granularity `y`) for an "age of equipment" field.
- Show a duration as friendly text like "2 hours 30 minutes" with the Human Friendly formatter.
- Show a duration in short form ("2 hr 30 min") to save space.
- Display the raw ISO 8601 string (`PT2H30M`) for machine consumption or debugging.
- Display a duration as `00/00/00 02:30:00` with the Time Format formatter.
- Separate human-readable parts with commas or new lines instead of spaces.
- Include a weeks input on a field where thinking in weeks is natural (e.g. pregnancy, sprints).
- Filter a View to nodes whose duration field is greater than `PT1H` using the seconds column.
- Query entities by duration string in code via the `duration_string` query tag.
- Sort content by duration (durations compare correctly because seconds are stored).
- Build a custom form with a standalone `duration` Form API element (no field needed).
- Restrict a custom `duration` element to 15-minute increments (`#date_increment => 900`).
- Require certain units on a `duration` element (`#required_elements => 'h:i'`).
- Add a `granularity` Form API element to let a site builder pick which units to collect.
- Convert a stored duration string to a PHP `DateInterval` for date math.
- Compute the number of seconds a duration represents for scheduling/queue logic.
- Add project-specific separators/labels to the Human Friendly formatter via the two hooks.
- Normalize duration field values cleanly over JSON:API / REST.
- Programmatically generate sample duration values for test content.
- Cleanly delete all duration fields before uninstalling the module with `drush duration_field:prepare_uninstall`.
- Present the same duration differently in teaser vs full view modes using different formatters.
