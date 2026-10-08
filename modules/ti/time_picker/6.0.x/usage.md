<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Time and Time Range Picker Field adds two field types — `time_picker` (a single time of day) and `time_range_picker` (a start and end time) — for storing times with no date attached, edited through a Materialize clock picker and stored as plain strings.

---

The module ships a field type, widget, and formatter for each of its two fields; there is no module settings page and no form-element API — everything is done by adding one of the two fields to an entity. The widget is a plain `textfield` (`#maxlength` 10) with a CSS class (`timepicker` or `time_range_picker`); the bundled `js/drupal.time_picker.js` calls Materialize's `.timepicker()` on it, giving the analog clock-face modal, and **Materialize 1.0.0-beta is pulled from the cdnjs CDN**, not shipped locally — so the widget needs outbound access to `cdnjs.cloudflare.com` and the picker degrades to a bare text box offline. Two per-field **storage** settings drive it: a `time_picker_theme` (default / sky blue / iris blue / parrot green / dark gray, applied as a CSS class on the wrapping fieldset) and an `hour_format` (`12h` or `24h`), both handed to the JS via `drupalSettings`. The stored value is a string: the single field keeps one `time` column, the range keeps `start` and `end` (both VARCHAR 255). On submit, the widget validates each value with a regex — `h:mm AM/PM` for 12-hour, `HH:MM` for 24-hour — and the range widget additionally parses start/end with `DrupalDateTime` and errors if start is later than end. The formatter simply prints the stored string (`start - end` for a populated range) with no reformatting. Because a time carries no date it also carries no timezone, and the naive start/end check means a range **cannot cross midnight** (22:00–06:00 is rejected). Note the declared `datetime` dependency and the `core/jquery.once` library dependency are legacy carry-overs — the code uses neither, and `core/jquery.once` no longer exists in Drupal 10/11.

---

- Store opening hours as a time range on a business or location entity.
- Record a weekly class or session time.
- Store a booking or appointment slot's start and end.
- Record a shift pattern's working hours.
- Store a broadcast or programme schedule time.
- Record a delivery or collection window.
- Store a service's daily availability hours.
- Record a recurring meeting time.
- Store a kitchen's or bar's serving hours.
- Record a facility's access times.
- Store a single time of day with no date attached.
- Record a tour or departure time.
- Record a clinic's consultation hours.
- Store a time range for a staff rota.
- Record a market's or shop's trading times.
- Store a helpline's operating hours.
- Record a timetable entry's start and end.
- Offer editors a clock-face picker instead of free-text time entry.
- Present times in 12-hour or 24-hour format per field.
- Theme the picker to match a site's palette (five preset colors).
- Capture times that recur weekly without pinning them to a calendar date.
- Model event windows where only the time-of-day matters.
