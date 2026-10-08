<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Javascript Timer API - Clock (jst_clock) — agent index

Optional **widget submodule** of the `jstimer` project (source `widgets/jst_clock.module`). It
registers the live **clock** widget with the parent's `hook_jstwidget()` API, so its JavaScript is
compiled into `public://jstimer/timer.js` and its settings are merged into the jstimer admin form.
Package *"Javascript timer api"*. **Depends on `jstimer`**. Core `>=8`. License GPL-2.0-or-later.
Version 8.x-1.5 (dir `8.x-1.x`). No routes, permissions, services, config schema, plugins, or
field formatter of its own — a clock is placed as raw `<div class="jst_clock"></div>` markup.

- **The widget: clock types, SVG faces, settings, microformat** →
  [widgets/clock.md](widgets/clock.md)

## What it provides (from source)

- **`jst_clock_jstwidget()`** — returns the descriptor (`name='jst_clock'`, `label='Clock'`,
  `js_name='Drupal.jstimer.jst_clock'`, `theme_function='jst_clock_show'`) and the `->js_code`:
  the `Drupal.jstimer.jst_clock` / `jst_clock_item` client classes. `update()` renders the current
  time per `clock_type` (0=12h text, 1=24h text, 2=`<canvas>` analog, 3=SVG analog). Reads config
  `jstimer_jst_clock_type` and `jst_clock_sva_file` at build time; the SVG type appends
  `<object data="/<module-path>/clocks/<svg>">`.
- **`jst_clock_form_jstimer_admin_settings_alter()`** — adds the "Clock widget" fieldset to
  `/admin/config/system/jstimer` (a live demo `<div class="jst_clock">`, the **Clock type** radios,
  and the **Clock svg file** textfield). Submit handler `jst_clock_admin_settings_submit()` is
  `array_unshift`ed first.
- **`jst_clock_show($widget_args)`** — theme function emitting the `.jst_clock` microformat span
  (hidden `clock_type`/`size` spans).
- **`jst_clock_install()`** — rebuilds `timer.js` + clears JS aggregation.
- Ships SVG faces in `widgets/clocks/` (`sleek1.svg`, `24h.svg`, `hamilton37500.svg`).
- Config keys live in the shared **`jstimer.settings`** object (owned by the parent) — see
  [../../../8.x-1.x/agent/config/settings.md](../../../8.x-1.x/agent/config/settings.md).

## Operate

```bash
drush en jstimer jst_clock -y
```

Pick a clock type at `/admin/config/system/jstimer`, place `<div class="jst_clock"></div>` where
you want the clock, and **reload** after saving (`timer.js` is browser-cached). Parent index:
[../../../8.x-1.x/agent/start.md](../../../8.x-1.x/agent/start.md).
