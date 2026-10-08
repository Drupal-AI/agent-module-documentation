The jst_clock submodule of Javascript Timer API provides a live "clock" widget that ticks every second, in four renderings: 12-hour text, 24-hour text, an HTML canvas analog clock, and an SVG analog clock.

---

`jst_clock` is one of the two optional widget submodules shipped inside the `jstimer` project (source `widgets/jst_clock.module`). It implements `hook_jstwidget()` to register a widget named `jst_clock` whose CSS selector is `.jst_clock` and whose JS constructor is `Drupal.jstimer.jst_clock`. Its `->js_code` (a `Drupal.jstimer.jst_clock_item` class) is compiled into `public://jstimer/timer.js`; on the page it finds `.jst_clock` elements and, once per second via the shared jstimer loop, renders the current browser time. The clock type is chosen globally on the jstimer admin form (`jstimer_jst_clock_type`: 0 = 12-hour plain text, 1 = 24-hour plain text, 2 = analog on an HTML `<canvas>`, 3 = analog from an SVG file); type 3 loads an `<object>` pointing at an SVG under `widgets/clocks/` named by `jst_clock_sva_file` (ships `sleek1.svg`, `24h.svg`, `hamilton37500.svg`). It also provides the `jst_clock_show()` theme function and injects the clock settings into the jstimer form via `hook_form_alter()`. Requires `jstimer`; enable both to render a clock. Everything runs client-side.

---

- Show a live wall clock that updates every second on any page.
- Place a clock in body markup or a custom block via `<div class="jst_clock"></div>`.
- Render the time as a 12-hour clock with am/pm suffix (clock type 0).
- Render the time as a 24-hour clock (clock type 1).
- Render an analog clock drawn on an HTML `<canvas>` element (clock type 2).
- Render an analog clock from a shipped SVG face (clock type 3).
- Choose among bundled SVG clock faces (`sleek1.svg`, `24h.svg`, `hamilton37500.svg`) via the admin setting.
- Fall back automatically to a 12-hour text clock when the browser lacks `<canvas>` support.
- Preview the configured clock live on the jstimer settings page via the built-in demo markup.
- Display multiple clocks on the same page, all driven by the single shared one-second loop.
- Provide a decorative ticking clock in a site header, sidebar, or dashboard.
- Show a zero-padded HH:MM:SS readout (padding via the shared `LZ()` helper).
- Use a custom SVG clock face by dropping a new file into `widgets/clocks/` and naming it in settings.
- Reuse the jstimer engine's per-second update loop for a clock without writing any JavaScript.
- Combine a clock (jst_clock) and a countdown (jst_timer) on the same page under one timer loop.
