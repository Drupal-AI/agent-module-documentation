The jst_timer submodule of Javascript Timer API provides the countdown/count-up "timer" widget: it compiles the timer's client-side JavaScript into the shared timer.js, adds the timer settings to the jstimer admin form, and renders the timer microformat markup.

---

`jst_timer` is one of the two optional widget submodules shipped inside the `jstimer` project (source `widgets/jst_timer.module`). It implements `hook_jstwidget()` to register a widget named `jst_timer` whose CSS selector is `.jst_timer` and whose JS constructor is `Drupal.jstimer.jst_timer`. Its `->js_code` (a `Drupal.jstimer.jst_timer_item` class) is concatenated into `public://jstimer/timer.js` by the parent's build pipeline; on the page it parses a `.jst_timer` span's hidden `<span class="datetime|dir|format_txt|interval|…">` children, computes the duration between now and the target date each second (`get_duration()`), and rewrites the element's HTML from a format-template string containing tokens like `%days%`, `%hours%`, `%mins%`, `%secs%`, `%dow%`, `%moy%`. It also injects the timer-related fields into the jstimer settings form via `hook_form_alter()` (format presets, proximity highlighting, timer-complete message, alert, and redirect), provides the `jst_timer_show()` theme function that the parent's `JsTimerDefaultFormatter` uses to emit markup, and provides `jst_timer_get_formats()` / `jst_timer_get_js_formats()` helpers. Requires `jstimer`; enable both to render a timer. Everything runs client-side in the browser.

---

- Render a countdown to a future date supplied through a datetime field (via the "JsTimer - Timer" formatter).
- Render a count-up "time elapsed since" timer by setting direction to `up`.
- Show remaining time as `%days% days + %hours%:%mins%:%secs%` with zero-padded units.
- Show a friendlier phrase like `Only %days% days, %hours% hours, %mins% minutes and %secs% seconds left`.
- Show a marketing countdown such as `%days% shopping days left`.
- Include calendar context with `%dow%` (day of week) and `%moy%` (month name) tokens.
- Use non-padded variants (`%hours_nopad%`, `%mins_nopad%`, `%secs_nopad%`) or totals (`%tot_days%`, `%tot_hours%`, `%tot_mins%`, `%tot_secs%`, `%tot_months%`).
- Pluralize units correctly through `Drupal.formatPlural` (e.g. `1 day` vs `3 days`).
- Define multiple reusable site-wide format presets on the admin form and select one by number (`format_num`).
- Override the global format for a single timer with a per-instance `format_txt`.
- Highlight the timer with a CSS style/class when it comes within N minutes of completing (proximity styling for countdowns).
- Latch proximity styling permanently once a count-up timer passes its threshold (NASA-style timers).
- Replace the finished countdown with a custom "Timer Completed" HTML message.
- Trigger a browser `alert()` message the moment a countdown completes.
- Redirect the browser to a URL a configurable number of seconds after completion.
- Reload the current page on completion using the `<reload>` redirect keyword.
- Drive a timer from a relative `interval` (seconds from now) instead of an absolute datetime.
- Correct client/server clock skew by supplying a `current_server_time` span.
- Provide "no JavaScript" fallback text inside the timer span.
- Run many independent timers on one page, all serviced by the shared one-second loop.
