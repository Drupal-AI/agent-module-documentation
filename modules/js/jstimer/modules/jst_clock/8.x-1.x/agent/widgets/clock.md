<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `jst_clock` live-clock widget

Source: `widgets/jst_clock.module`. Enable with `drush en jstimer jst_clock -y`.

## Registration

`jst_clock_jstwidget()` returns `name='jst_clock'`, `label='Clock'`,
`js_name='Drupal.jstimer.jst_clock'`, `theme_function='jst_clock_show'`, and a `->js_code`
heredoc. At build time it reads the module path (`extension.list.module->getPath('jst_clock')`),
`jstimer_jst_clock_type`, and `jst_clock_sva_file` from `jstimer.settings` and bakes them into the
JS. The parent's pipeline compiles that into `timer.js` and instantiates
`new Drupal.jstimer.jst_clock()`.

## Placement / microformat (`jst_clock_show()`)

There is **no field formatter** for the clock. Emit `<span class="jst_clock">` (or
`<div class="jst_clock"></div>`) in markup; `jst_clock_show()` optionally adds hidden
`clock_type` / `size` spans. The admin form also drops a demo `<div class="jst_clock"></div>`.

## Client behaviour (`Drupal.jstimer.jst_clock_item`)

- `attach()` runs `jQuery(".jst_clock").each(...)`, guards against double-attach with a
  `jst_clock_attached` attribute, and pushes each item onto `Drupal.jstimer.timer_stack`.
- Constructor props default to `{clock_type: <config>, size: 200}`; `loadProps()` overrides from
  hidden spans. If `<canvas>` is unsupported and `clock_type==2`, it downgrades to `0`.
- `update()` (each ~1s) renders by `clock_type`:
  - **0** — 12-hour text `h:MM:SSam/pm` (uses `LZ()` padding).
  - **1** — 24-hour text `H:MM:SS`.
  - **2** — analog clock drawn on a `<canvas class="ct_clock_canvas">` (appended in the
    constructor, sized to `size`) via 2D context: tick marks, hour/minute/second hands, face.
  - **3** — analog **SVG**: constructor appends
    `<object data="/<module-path>/clocks/<jst_clock_sva_file>" type="image/svg+xml">` sized to
    `size`; `update()` calls `animate()` inside the SVG document (via `getSvgWindow()`), tolerating
    the browser timing exception on first load.
- `supports_canvas()` and `getSvgWindow()` are helper functions defined in the same JS block.

## Settings (added to the jstimer form)

`jst_clock_form_jstimer_admin_settings_alter()` adds the **Clock widget** fieldset:

| Field | Config key | Values |
|---|---|---|
| Clock type (radios) | `jstimer_jst_clock_type` | 0 = 12-hour plain text, 1 = 24-hour plain text, 2 = Analog canvas, 3 = Analog SVG |
| Clock svg file (textfield) | `jst_clock_sva_file` | filename under `widgets/clocks/` (ships `sleek1.svg`, `24h.svg`, `hamilton37500.svg`) |

Admin help notes the analog clocks are experimental (Firefox/Opera/Safari/IE9). Submit handler
`jst_clock_admin_settings_submit()` (registered first via `array_unshift`) writes both keys into
`jstimer.settings`. Config object owned by the parent —
[../../../../8.x-1.x/agent/config/settings.md](../../../../8.x-1.x/agent/config/settings.md).

## Notes

- The clock uses the **browser's** local time (`new Date()`), not server time — no server request.
- `jst_clock_sva_file` is an `administer site configuration` setting used to build the SVG
  `<object data>` path (`/<module-path>/clocks/<file>`); the shipped faces live in
  `widgets/clocks/`.
- Uses the shared jstimer loop and utilities (`LZ`) from the parent-generated `timer.js`; enable
  and configure through the parent module.
