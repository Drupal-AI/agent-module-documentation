<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config object, admin form, and the `timer.js` build pipeline

## Install & enable

```bash
composer require drupal/jstimer
drush en jstimer -y      # then jst_timer and/or jst_clock for the actual widgets
```

`jstimer_install()` (in `jstimer.install`) calls `jstimer_build_js_cache()` and then
`asset.js.collection_optimizer->deleteAll()`. Only dependency is core **`field`**.

## Admin settings route

- Route `jstimer.admin_settings` → `/admin/config/system/jstimer`, form
  `Drupal\jstimer\Form\JstimerAdminSettings`, requirement **`_permission: administer site
  configuration`** (`jstimer.routing.yml`). Menu link `jstimer.admin_settings` under
  `system.admin_config_system` (`jstimer.links.menu.yml`).
- The base form (`JstimerAdminSettings::buildForm()`) is intentionally **empty** — all real fields
  are injected by the widget submodules through `hook_form_alter()`
  (`jst_timer_form_jstimer_admin_settings_alter()`, `jst_clock_form_jstimer_admin_settings_alter()`).
  So with neither submodule enabled the page shows only a Save button.
- `validateForm()` rejects any submitted key starting with `jstimer_js_` that contains a single
  quote. (Those two keys — `jstimer_js_load_pages` / `jstimer_js_exclude_pages` — exist in the
  schema but are **not read anywhere** in the D8+ code.)
- `submitForm()` saves `jstimer.settings`, then (via `_submitForm()`) rebuilds `timer.js` and
  clears the JS aggregation cache. The two submodule submit handlers are `array_unshift`ed onto
  `$form['#submit']` so they persist their own values *before* the file is rebuilt.

## Config object `jstimer.settings`

Install defaults (`config/install/jstimer.settings.yml`):

| Key | Default | Read by | Meaning |
|---|---|---|---|
| `jstimer_output_format` | `<em>(%dow% %moy%%day%)</em><br/>%days% days + %hours%:%mins%:%secs%` | legacy | Old single-format keys (D7). Superseded by `jst_timer_formats`. |
| `jstimer_output_format_1..3` | preset strings | legacy | Old preset slots (unused by D8 code paths). |
| `jst_timer_complete_message` | `<em>Timer Completed</em>` | `jst_timer` | HTML shown in place of a finished countdown. |
| `jst_timer_complete_alert_message` | `''` | `jst_timer` | Text popped in a JS `alert()` on completion. |
| `jstimer_highlight` | `style="color:red"` | `jst_timer` | CSS attribute statement applied near completion. |
| `jstimer_highlight_threshold` | `5` | `jst_timer` | Minutes before completion to apply highlight. |
| `jstimer_highlight_down` | `1` | `jst_timer` | Apply highlight to countdown timers. |
| `jstimer_highlight_up` | `0` | `jst_timer` | Apply (latching) highlight to count-up timers. |
| `jst_timer_redirect_path` | `''` | `jst_timer` | URL (or `<reload>`) to send the browser to on completion. |
| `jst_timer_redirect_delay` | `3` | `jst_timer` | Seconds to wait after completion before redirecting. |
| `jstimer_jst_clock_type` | `''` | `jst_clock` | 0=12h text, 1=24h text, 2=canvas, 3=SVG. |
| `jst_clock_sva_file` | `sleek1.svg` | `jst_clock` | SVG filename under `widgets/clocks/` for clock type 3. |
| `jst_timer_formats` | (not in install; seeded on first save) | `jst_timer` | Array of format-template strings; index 0 is the global default. |

**Schema caveat** (`config/schema/jstimer.schema.yml`): it declares only
`jstimer_js_load_pages`, `jstimer_js_exclude_pages`, `jstimer_output_format`,
`jstimer_output_format_1..3`, `jstimer_complete_statement`. Most keys the code actually reads
(`jst_timer_*`, `jstimer_highlight*`, `jstimer_jst_clock_type`, `jst_clock_sva_file`,
`jst_timer_formats`) have **no schema entry** — strict config-schema tooling will flag them; they
still save and work.

## The `timer.js` build pipeline

`jstimer_build_js_cache()` (`jstimer.module`):

1. `file_system->prepareDirectory('public://jstimer', CREATE_DIRECTORY)`.
2. `jstimer_get_javascript(TRUE)` — collects widgets via `jstimer_get_widgets()`
   (`moduleHandler()->invokeAll('jstwidget')`), concatenates each widget's `->js_code`, and wraps
   it in a heredoc that defines `Drupal.behaviors.jstimer` (which calls
   `Drupal.jstimer.countdown_auto_attach([...])`), the `Drupal.jstimer` namespace,
   `timer_stack`, the `timer_loop()` (a `setTimeout(..., 999)` one-second loop), plus utility
   helpers `LZ()`, `Date.prototype.jstimer_set_iso8601_date`, `jstimer_get_moy`, `jstimer_get_dow`.
3. `file.repository->writeData($data, 'public://jstimer/timer.js', EXISTS_REPLACE)` and stores the
   path in `jstimer.settings:jstimer_timerjs_path`.

The file is served through the `jstimer` library (`jstimer.libraries.yml`, js
`/sites/default/files/jstimer/timer.js`, deps `core/drupal`, `core/drupalSettings`, `core/once`)
and attached everywhere by `jstimer_page_attachments_alter()`.

`jstimer_clean_for_javascript($s)` is the string sanitiser used when embedding config into that JS:
it `preg_replace`s `\n`→`<br/>`, `\r`→``, and `'`→`"` (so a value cannot break out of a
single-quoted JS string literal). It is the module's own trusted-admin sanitiser — the config it
cleans is only writable through the `administer site configuration` form above.

## Operate

- After changing settings, **hard-reload** — browsers cache `timer.js`; the submodule submit
  handlers even print a reminder.
- To force a rebuild from code: call `jstimer_build_js_cache()` (e.g. `drush php:eval`), or just
  re-run the module install / re-save the settings form.
- The `InitSubscriber` service (`jstimer.services.yml`) is a dead D7-migration stub; the working
  attach path is `hook_page_attachments_alter()`.
