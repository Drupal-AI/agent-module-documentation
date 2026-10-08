<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Javascript Timer API (jstimer) — agent index

Front-end **timer/clock API + widgets**. It compiles a single `Drupal.jstimer` JavaScript file at
`public://jstimer/timer.js` from config + enabled widgets, attaches it to every page, and updates
any matching microformat element once per second via one shared jQuery loop. Package
*"Javascript timer api"*. Depends only on core **`field`**. Core `>=8`. License GPL-2.0-or-later.
Version 8.x-1.5 (dir `8.x-1.x`). No permissions of its own, no Drush, no routes except the admin
settings form.

- **Config object, schema, admin route, and the `timer.js` build pipeline** →
  [config/settings.md](config/settings.md)
- **The `datetime` field formatter (`JsTimerDefaultFormatter`)** →
  [fields/formatter.md](fields/formatter.md)
- **The widget API (`hook_jstwidget`), the microformat markup, and the client-side engine** →
  [api/widgets.md](api/widgets.md)

## What it actually is (from source)

- **`jstimer.module`**: `hook_theme()` (`jstimer` theme + `theme_jstimer()`), `hook_help()`,
  legacy `hook_menu()` (unused under D8+), `hook_page_attachments_alter()` attaching the
  `jstimer/jstimer` library, and the build helpers `jstimer_build_js_cache()`,
  `jstimer_get_javascript()`, `jstimer_get_widgets()` (invokes `hook_jstwidget()`), and
  `jstimer_clean_for_javascript()` (strips newlines/CRs, converts `'`→`"`). It also
  `loadInclude()`s the legacy `jstimer.field.inc.old` — a no-op D7 formatter shim (its
  `theme()`/`date_formatter_process()` calls are commented out); real formatting is done by the
  D8 plugin.
- **`src/Plugin/Field/FieldFormatter/JsTimerDefaultFormatter.php`** — formatter id
  `jstimer_jst_timer`, label *"JsTimer - Timer"*, `field_types = { datetime }`.
- **`src/Form/JstimerAdminSettings.php`** — `ConfigFormBase` at route `jstimer.admin_settings`
  (`/admin/config/system/jstimer`, `_permission: administer site configuration`), editing
  `jstimer.settings`. On save it rebuilds `timer.js` and clears the JS aggregation cache.
- **`src/EventSubscriber/InitSubscriber.php`** — subscribes to `KernelEvents::REQUEST` but its
  `onEvent()` body is an empty D7-migration stub (does nothing).
- **`config/install/jstimer.settings.yml`** + **`config/schema/jstimer.schema.yml`** — the
  `jstimer.settings` object (formats, completion message/alert, proximity highlight, redirect,
  clock type/svg). Note: the schema only declares a subset of the keys the code actually reads.
- **`jstimer.libraries.yml`** — library `jstimer` loads `/sites/default/files/jstimer/timer.js`
  (the generated file), deps `core/drupal`, `core/drupalSettings`, `core/once`. Widget JS calls
  the global `jQuery`, which must be present on the page.

## Widget submodules (own nested doc trees)

- **`jst_timer`** (source `widgets/jst_timer.module`) — the countdown/count-up timer widget →
  [../modules/jst_timer/8.x-1.x/agent/start.md](../modules/jst_timer/8.x-1.x/agent/start.md)
- **`jst_clock`** (source `widgets/jst_clock.module`) — the live-clock widget →
  [../modules/jst_clock/8.x-1.x/agent/start.md](../modules/jst_clock/8.x-1.x/agent/start.md)

Both live under the source `widgets/` directory, depend on `jstimer`, and register themselves
through `hook_jstwidget()` so their JS is compiled into `timer.js` and their admin settings are
merged into the jstimer settings form via `hook_form_alter()`.

## Operate

`composer require drupal/jstimer` → `drush en jstimer -y` (install regenerates `timer.js`). Enable
`jst_timer` and/or `jst_clock` for the actual widgets. Configure at `/admin/config/system/jstimer`;
**reload the page after saving** because browsers cache the generated `timer.js`.
