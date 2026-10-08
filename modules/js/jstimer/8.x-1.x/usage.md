Javascript Timer API renders live-updating, client-side countdown/count-up timers and clocks by hooking HTML microformat markup to a shared one-second jQuery event loop.

---

The `jstimer` module is a small front-end API. At install (and whenever you save its admin settings) it regenerates a single JavaScript file at `public://jstimer/timer.js` that contains a `Drupal.jstimer` namespace, a `Drupal.behaviors.jstimer` bootstrap, and the compiled code of every enabled widget (collected through the `hook_jstwidget()` hook). That file is attached to every page via `hook_page_attachments_alter()` / the `jstimer/jstimer` library. On the page, any element carrying a widget's CSS class (e.g. `<span class="jst_timer">…</span>` or `<div class="jst_clock"></div>`) with hidden `<span class="datetime|dir|format_txt|…">` children is detected, parsed, pushed onto `Drupal.jstimer.timer_stack`, and updated once per second by a single `setTimeout` loop — so many timers on one page share one timer. It ships a `datetime` field formatter (`JsTimerDefaultFormatter`, id `jstimer_jst_timer`) so a date field can render as a countdown, plus two optional widget submodules — `jst_timer` (the countdown/count-up timer) and `jst_clock` (a live clock). Global behaviour (formats, proximity highlighting, completion message/alert, redirect-on-complete, clock type) is configured at `/admin/config/system/jstimer` (`administer site configuration`) and stored in the `jstimer.settings` config object. Everything is computed client-side in the browser; the module makes no server-side time requests, HTTP calls, or database queries.

---

- Show a countdown to a launch/event date placed in a date field on nodes, using the "JsTimer - Timer" display formatter.
- Show a count-up "time since" timer (e.g. days since a project started) by setting the formatter direction to "up".
- Render a live wall-clock that ticks every second in a block or in body markup via `<div class="jst_clock"></div>`.
- Display a 12-hour or 24-hour plain-text clock in a header or sidebar.
- Display an experimental analog clock drawn on an HTML `<canvas>` element.
- Display an experimental analog clock rendered from an SVG file shipped in `widgets/clocks/`.
- Build a "shopping days left until Christmas" style countdown with a custom format like `%days% shopping days left`.
- Format a countdown as `%days% days + %hours%:%mins%:%secs%` with zero-padded units.
- Include the day-of-week and month name in a timer via the `%dow%` and `%moy%` tokens.
- Run a countdown that pluralizes units correctly (`1 day` vs `@count days`) through `Drupal.formatPlural`.
- Highlight a timer with a CSS style/class once it gets within N minutes of completing (proximity styling).
- Keep proximity styling "latched" on a count-up (NASA-style) timer once the threshold is passed.
- Swap the timer for a "Timer Completed" message the moment a countdown reaches zero.
- Pop up a browser `alert()` message when a countdown completes.
- Redirect the visitor to another URL a set number of seconds after a countdown finishes.
- Reload the current page automatically when a countdown finishes (using the `<reload>` redirect keyword).
- Drive a timer from a relative interval (e.g. "N seconds from now") instead of an absolute date via the `interval` microformat span.
- Maintain several independent countdowns on the same page, all served by one shared one-second loop.
- Correct small client/server clock skew by supplying a `current_server_time` span alongside the target datetime.
- Provide fallback "no JavaScript" text inside a timer span for visitors without JS.
- Define reusable, site-wide timer format presets on the admin settings page and reference them by number.
- Add your own timer/clock widget by implementing `hook_jstwidget()` to return the CSS selector, theme function, and JS code.
- Reuse the ISO-8601 date parser and duration math (`Date.prototype.jstimer_set_iso8601_date`, `get_duration`) added to the browser's `Date` object.
