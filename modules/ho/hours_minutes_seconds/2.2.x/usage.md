Hours, Minutes and Seconds provides a Drupal field type that stores a duration as a single integer number of seconds, with a text widget for `h:mm:ss`-style entry and four display formatters (formatted, natural language, live countdown, ISO 8601).

---

The module adds one field type `hour_minutes_seconds` whose storage is a single nullable `int` column (`value`) holding total seconds; negative values are supported. Its widget `hour_minutes_seconds_default` accepts a configurable input format string (e.g. `h:mm`, `h:mm:ss`, `hh:mm:ss`, `m:ss`, `mm:ss`, `d:h:mm:ss`, `h`, `m`, `s`) and parses it to seconds on validation, optionally showing a raw-seconds hint. Four formatters render the stored seconds: the default `hour_minutes_seconds_default_formatter` (with an optional JavaScript live count-up timer), `hour_minutes_seconds_countdown_formatter` (a live JS countdown with optional finished text), `hour_minutes_seconds_natural_language_formatter` (e.g. "2 hours, 30 minutes and 45 seconds", translatable), and `hour_minutes_seconds_iso_duration_formatter` (e.g. `PT2H30M45S`, optionally wrapped in a `<time>` element). Per-instance `min`/`max` constraints (in seconds) validate on save. All conversion logic lives in the service `hours_minutes_seconds.hour_minutes_seconds` (seconds↔formatted, ISO 8601, decompose to units, factor map), which is also reusable directly, as is the `#type 'hour_minutes_seconds'` form element. Timers are driven by a dependency-free JS behavior reading `data-hms-*` attributes and a `drupalSettings` server time for clock-drift correction. Two alter hooks — `hook_hour_minutes_seconds_factor_alter()` and `hook_hour_minutes_seconds_format_alter()` — let you add time units or format options. It also ships a Views field handler and full config schema. There is no admin/configure route and no permissions of its own; access is governed by ordinary field/entity permissions.

---

- Store a video or audio clip's runtime as a duration field on a media or node type.
- Capture a task's estimated effort in hours/minutes on a project content type.
- Record a race or lap time as `mm:ss` and store it losslessly as seconds.
- Show a stored duration in natural language ("1 hour and 5 minutes") in an article.
- Display a live count-up timer that increments every second from a stored offset.
- Render a live countdown to zero (e.g. an auction or offer timer) with a "finished" state.
- Emit an ISO 8601 duration (`PT2H30M45S`) inside a `<time datetime="…">` element for machine readers / SEO.
- Enforce a minimum/maximum allowed duration per field instance (in seconds).
- Let editors type `2:30:45` while the site stores `9045` seconds under the hood.
- Provide a friendly seconds hint under the widget so editors see the raw stored value.
- Switch a field's display format (`h:mm` vs `hh:mm:ss`) without changing stored data.
- Use the reusable `#type 'hour_minutes_seconds'` form element in a custom form.
- Convert seconds to a formatted string in code via `secondsToFormatted()`.
- Parse a user-entered `h:mm:ss` string back to seconds via `formattedToSeconds()`.
- Convert a duration to/from ISO 8601 with `toIso8601()` / `fromIso8601()`.
- Decompose a seconds value into weeks/days/hours/minutes/seconds via `toArray()`.
- Add a custom time unit (e.g. fortnight) via `hook_hour_minutes_seconds_factor_alter()`.
- Add or remove selectable format strings via `hook_hour_minutes_seconds_format_alter()`.
- Expose a duration field in Views and render it formatted / natural / ISO / raw.
- Migrate legacy integer-seconds data straight into the field with the core `get` process plugin.
- Present negative durations (e.g. schedule variance of `-120` seconds) in both PHP and JS.
- Theme the timer/countdown via the BEM classes `hour-minutes-seconds--running` / `--countdown` / `--countdown-finished`.
- Standardise duration entry across many content types with one reusable field type.
- Show a countdown timer in a block or view that stays accurate through page caching (`max-age = 0`).
- Store cooking/recipe times, workout intervals, or SLA durations as first-class fields.
