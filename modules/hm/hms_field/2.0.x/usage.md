HMS Field provides a duration field that stores a value as an integer number of seconds but lets editors enter and view it in Hours:Minutes:Seconds (or week/day/hour/minute/second) formats, including a "natural language" formatter and an optional live running-timer display.

---

The `hms` field type stores a single signed integer (`value`) of seconds. Its widget (`hms_default`) uses a custom `hms` form element that parses human input (`h:mm:ss`, `hh:mm`, `m:ss`, `h`, `m`, `s`, or space-separated like `3h 15m 30s`) into seconds on validation and renders the stored seconds back into the configured format. Two formatters are provided: `hms_default_formatter` (a chosen `h:mm`-style format with optional leading zeros, themed via `hms.html.twig`) and `hms_natural_language_formatter` (renders selected fragments — weeks/days/hours/minutes/seconds — joined by configurable separators, e.g. "1 hour, 5 minutes and 30 seconds", via `hms-natural-language.html.twig`). All conversion logic lives in the `hms_field.hms` service (`HMSService`): `formattedToSeconds()`, `secondsToFormatted()`, `isValid()`, plus `factorMap()` (unit → seconds factor and labels) and `formatOptions()` (the selectable formats). Both maps are alterable via `hook_hms_format_alter` and `hook_hms_factor_alter`. The default formatter also supports a `running_since` mode: when set, `template_preprocess_hms()` attaches `js/hms_field.js` and `drupalSettings` (server time + factor map) and emits `hms-running`/`hms-since-*`/`hms-offset-*` classes so the browser ticks the value up in real time (a live stopwatch/counter). No global config, permissions, or Drush; configuration is entirely per field widget/formatter.

---

- Store a duration (video length, task estimate, session length) as seconds while editing it as H:M:S.
- Let editors type `1:30:00` or `90m` or `1h 30m` and have it saved as 5400 seconds.
- Display a duration in a compact `h:mm` or `hh:mm:ss` format with or without leading zeros.
- Render a duration in words: "2 hours, 15 minutes and 30 seconds".
- Choose which unit fragments (weeks/days/hours/minutes/seconds) the natural-language formatter shows.
- Customise the separators (", " and " and ") between natural-language fragments.
- Show a live, ticking timer that counts up from a stored "running since" timestamp.
- Build an "elapsed time" / stopwatch display for ongoing processes using the running_since mode.
- Support durations longer than a day using week/day units (`w`/`d`) in the space-separated format.
- Store negative durations (e.g. time deltas / adjustments) — the integer column is signed.
- Add a "reading time" or "estimated time" field to articles.
- Capture work-log or timesheet durations per entity.
- Field for media/audio/video length that sorts and aggregates correctly (stored as an int).
- Provide a consistent duration input across content types without custom parsing code.
- Sort or range-filter content by duration in Views (underlying value is a plain integer).
- Localise unit labels (week/day/hour/minute/second) through the translation system.
- Add new input/display formats site-wide via `hook_hms_format_alter`.
- Change or extend the unit factor map (e.g. add months) via `hook_hms_factor_alter`.
- Reuse the `hms` render element in a custom form to get duration parsing for free.
- Call `HMSService::secondsToFormatted()` / `formattedToSeconds()` from custom code to convert durations.
- Validate user-entered duration strings programmatically with `HMSService::isValid()`.
- Present countdown/elapsed counters on dashboards without writing JavaScript.
