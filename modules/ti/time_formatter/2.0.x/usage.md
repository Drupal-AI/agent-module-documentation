<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Time Formatter provides a field formatter that takes a numeric field storing a duration (as seconds or milliseconds) and displays it as a human-readable time such as `123:59:59.999` or `123h 59m 59s`.

---

The module ships one field formatter plugin, `number_time` (label "Time"), usable on core `integer`, `decimal` and `float` fields. It reads the raw number, interprets it as either seconds or milliseconds (the `storage` setting), and breaks it into hours/minutes/seconds/milliseconds for display. Three formatter settings control output: `storage` (0 = Seconds, 1 = Milliseconds; default Milliseconds), `display` (0 = `123h 59m 59s 999ms`, 1 = `123h 59m 59s`, 2 = `123:59:59.999`, 3 = `123:59:59`; default `123:59:59.999`), and `hours` (0 = Always show hours, 1 = Optional/only if > 0, 2 = Never; default Always). It computes purely in PHP (no rounding beyond `round()` on the millisecond total) and outputs `#markup`. You apply it on a bundle's *Manage display* page (or in the `entity_view_display` config) by choosing "Time" as the field's format. There is no settings page, permission, service or Drush command — just the formatter and its config schema `field.formatter.settings.number_time`.

---

- Display a stored lap/race time (milliseconds) as `1:23.456`.
- Show a video or audio duration stored in seconds as `1:02:33`.
- Render an elapsed-time integer field as `2h 5m 9s`.
- Present a "time spent" metric as `123:59:59` on a report.
- Format a benchmark result stored in milliseconds as `59s 999ms`.
- Show a countdown/allotted-time integer field in `HH:MM:SS`.
- Display a duration without hours when hours are zero (Optional hours setting).
- Force minutes:seconds only for short durations (Hours: Never).
- Always show a leading hours component for consistency (Hours: Always).
- Format a decimal seconds field (e.g. 90.5) as a time value.
- Show workout/exercise durations from an integer seconds field.
- Present API-response or processing times (ms) in a readable format.
- Display game/level completion times stored as integers.
- Render a podcast episode length field as `1h 02m 33s`.
- Show call-duration fields (seconds) as `MM:SS`.
- Format a "reading time" integer field for articles.
- Present music track lengths stored in milliseconds.
- Display SLA/response-time durations on a dashboard view.
- Choose a compact numeric format (`123:59:59`) for tables.
- Choose a verbose labeled format (`123h 59m 59s 999ms`) for detail pages.
- Reuse one integer field across displays with different time formats per view mode.
