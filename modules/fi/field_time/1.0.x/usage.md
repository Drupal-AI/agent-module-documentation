Field Time provides two clock-time field types — **Time** (a single `HH:MM:SS`) and **Time Range** (a start/end pair) — plus a reusable `time` form element, so you can store a time of day (not a full datetime) on any entity.

---

The module adds field types `time` and `time_range`, each stored as a native `TIME` column
(`char(8)`, mapped to `mysql_type`/`pgsql_type` `time`) holding `HH:MM:SS`. Each ships a widget and a
formatter. The widgets (`time_widget`, `time_range_widget`) render an HTML5 `<input type="time">` via
the custom `time` render element (`TimeElement`) and have two settings: **enabled** (add a seconds
step to the input) and **step** (the seconds increment); `massageFormValues()` normalizes submitted
values to `H:i:s` with `DateTimeImmutable`. The formatters (`time_formatter`, `time_range_formatter`)
render the stored value through PHP's `date()`-style format string set in the formatter settings
(default `h:i a`); the range formatter also takes a `timerange_format` template containing the literal
words `start` and `end` (default `start ~ end`) which are replaced by the formatted start/end times.
Time Range enforces a validation constraint that the end must be later than the start. There is no
admin UI, no config page, no permissions, and no Drush — you add the fields through the normal Field
UI. Requires core `datetime`.

---

- Store a single time of day (e.g. an event start time) independent of any date.
- Store an opening/closing time pair with the Time Range field.
- Capture business/opening hours per day on a "Location" content type.
- Record class or session start and end times.
- Add appointment slot times to a booking entity.
- Show a time using a 12-hour format with am/pm (`h:i a`).
- Show a time in 24-hour format (`H:i`).
- Display seconds precision by enabling the seconds step on the widget.
- Set a custom seconds increment (step) for time entry.
- Format a range as `start ~ end`, `start – end`, or any template containing `start`/`end`.
- Validate that a time range's end is after its start automatically.
- Use the HTML5 native time picker for consistent cross-browser entry.
- Add a `#type => 'time'` element to a custom form to collect a time value.
- Store shift start/end times for a staff scheduling entity.
- Record daily reminder times on a user or content entity.
- Show a formatted time in a View using the field formatter.
- Keep time-of-day data as a real DB `TIME` column for correct sorting/filtering.
- Provide a lightweight time input without pulling in a full datetime range field.
