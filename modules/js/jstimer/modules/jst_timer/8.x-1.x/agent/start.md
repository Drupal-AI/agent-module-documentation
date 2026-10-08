<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Javascript Timer API - Timer (jst_timer) — agent index

Optional **widget submodule** of the `jstimer` project (source `widgets/jst_timer.module`). It
registers the countdown/count-up **timer** widget with the parent's `hook_jstwidget()` API, so its
JavaScript is compiled into `public://jstimer/timer.js` and its settings are merged into the
jstimer admin form. Package *"Javascript timer api"*. **Depends on `jstimer`**. Core `>=8`. License
GPL-2.0-or-later. Version 8.x-1.5 (dir `8.x-1.x`). No routes, permissions, services, config schema,
or plugins of its own.

- **The widget: tokens, settings, microformat, completion/redirect/highlight behaviour** →
  [widgets/timer.md](widgets/timer.md)

## What it provides (from source)

- **`jst_timer_jstwidget()`** — returns the widget descriptor (`name='jst_timer'`,
  `js_name='Drupal.jstimer.jst_timer'`, `theme_function='jst_timer_show'`, default settings
  `dir=down`/`format_txt=''`) and the widget's `->js_code`: the `Drupal.jstimer.jst_timer` /
  `jst_timer_item` client classes (ISO date parse, `get_duration()`, per-second `update()` that
  replaces format tokens, proximity styling, completion message/alert, redirect).
- **`jst_timer_form_jstimer_admin_settings_alter()`** — injects the "Timer widget" fieldset into
  `/admin/config/system/jstimer`: format presets (`jst_timer_formats`), proximity styling
  (`jstimer_highlight*`), timer-complete redirect (`jst_timer_redirect_path/_delay`), complete
  message (`jst_timer_complete_message`), complete alert (`jst_timer_complete_alert_message`).
  Its submit handler `jst_timer_admin_settings_submit()` is `array_unshift`ed first so values are
  saved before `timer.js` is rebuilt.
- **`jst_timer_show($widget_args)`** — theme function emitting the `.jst_timer` microformat span
  (used by the parent's `JsTimerDefaultFormatter` and callable from custom markup).
- **`jst_timer_get_formats()` / `jst_timer_get_js_formats()`** — read `jst_timer_formats` from
  `jstimer.settings` (falling back to four built-in presets) and JS-encode them.
- **`jst_timer_install()`** — rebuilds `timer.js` + clears JS aggregation, same as the parent.
- Config keys live in the shared **`jstimer.settings`** object (owned by the parent) — see
  [../../../8.x-1.x/agent/config/settings.md](../../../8.x-1.x/agent/config/settings.md).

## Operate

```bash
drush en jstimer jst_timer -y
```

Then either set a datetime field's display to **"JsTimer - Timer"** (parent formatter) or place a
`.jst_timer` microformat span in markup, and configure formats/behaviour at
`/admin/config/system/jstimer`. **Reload** after saving — `timer.js` is browser-cached. Parent
index: [../../../8.x-1.x/agent/start.md](../../../8.x-1.x/agent/start.md).
