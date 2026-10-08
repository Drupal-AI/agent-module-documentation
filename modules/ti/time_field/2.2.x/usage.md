Time Field adds two Drupal field types — `time` (a single time of day) and `time_range` (a start/end pair) — with matching HTML5 time-input widgets and configurable formatters, storing each value as an integer number of seconds past midnight.

---

Time Field lets site builders attach a plain time-of-day value to any fieldable entity without dragging in a full date. It ships the `time` and `time_range` field types, each with a default widget (`time_widget`, `time_range_widget`) built on a custom `#type => 'time'` render element that emits a native HTML5 `<input type="time">`, and default formatters (`time_formatter`, `time_range_formatter`) whose output format is a PHP date-format string (e.g. `h:i a`, `G:i`). Values are persisted as an unsigned integer of seconds elapsed since midnight (0–86400), which sorts and indexes cleanly in SQL; the range field's `to` column is nullable so open-ended ranges are allowed. Widgets can optionally expose a seconds spinner with a configurable step, and a field's default value can be set to the current request time. A reusable `Drupal\time_field\Time` value object handles all conversion (to/from timestamps, HTML5 strings and `DateTime`), and the module integrates with the Token module (`[time:*]`, `[time_range:from]`, `[time_range:to]`) and provides a Feeds mapping target for the `time` field type. There is no site-wide admin settings page — everything is configured per field through Field UI.

---

- Store a business's daily opening or closing time on a Location content type.
- Capture an event's start and end time with a single `time_range` field.
- Record class, appointment, or session times without a full date attached.
- Add a "happy hour" start/end range to a restaurant or bar node.
- Store train, bus, or flight departure/arrival times of day.
- Attach a preferred contact time to a user profile.
- Record medication or reminder times as time-of-day values.
- Build a weekly schedule where each row has open/close times per day.
- Display times in 12-hour (`h:i a`) or 24-hour (`G:i`) format via formatter settings.
- Show a range as "9:00 am ~ 5:00 pm" using the `start ~ end` range template.
- Let editors pick seconds precision by enabling the widget's seconds step.
- Default a "check-in time" field to the current time when content is created.
- Sort or filter Views by time-of-day using the indexed integer storage.
- Import times from a CSV or feed via the Feeds `time_feeds_target` mapper.
- Render time values in emails or elsewhere through Token replacements.
- Provide open-ended ranges (a start with no end) using the nullable `to` value.
- Reuse the `#type => 'time'` form element in a custom module's form.
- Convert between seconds, `DateTime`, and HTML5 strings with the `Time` helper class.
- Attach a time to an arbitrary `DateTime` (a given day) using `Time::on()`.
- Format a stored time programmatically with any PHP date format.
- Store gym or facility slot times for a booking-style content model.
- Add "golden hour" or broadcast slot times to media/editorial content.
- Model office hours or support-desk availability windows.
- Validate submitted times automatically via the built-in `time` constraint.
- Keep multi-value time fields (cardinality > 1) for several daily slots.
