<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Convivial Profiler (convivial_profiler) — agent index

Client-side visitor **personalization / behavioural profiling** engine. Drupal stores an
admin-built pipeline in one config object and hands it to an **external JavaScript SDK**
(`cdn.jsdelivr.net/gh/morpht/convivial-profiler@v0.1.40/dist/bundle.js`) via `drupalSettings`.
All collection, storage (browser cookies + localStorage) and personalisation run in the browser —
there is **no server-side profile store, no REST/collector route, no PHP outbound HTTP**.

- Package `Convivial`. Depends on **`convivial_core`**. Core `^10.2 || ^11 || ^12`. GPL-2.0-or-later.
  Version **1.0.0-alpha14**. `configure` = `convivial_profiler.settings`.
- Submodule **`convivial_profiler_sync`** — JSON export/import of profiler definitions.

## What it actually is (from source)

- **One config object** `convivial_profiler.settings` (schema in `config/schema/`): `site_id`,
  `license_key`, booleans `client_cleanup` / `event_tracking` / `cookieconsent`, a `profilers`
  sequence (each = label/name/weight/status/deferred/description + `sources`, `processors`,
  `destinations` arrays), and a `visibility` map of core condition-plugin configs.
- **hook_page_attachments** (`src/Hook/ConvivialProfilerHooks.php`): only if BOTH `site_id` and
  `license_key` are non-empty, evaluates the visibility conditions, then attaches
  `convivial_profiler/init` and injects `drupalSettings.convivialProfiler` = site, license_key,
  client_cleanup, event_tracking, cookieconsent, and `config.profilers`.
- **`js/convivial_profiler.init.js`**: `new ConvivialProfiler(config, site, license_key, undefined, cookieconsent)`,
  `.collect()`, and a click handler pushing `convivialProfiler.event` into `window.dataLayer`.
- **Three plugin types** (YAML-discovered + attribute/annotation, manager base
  `src/Plugin/ProfilerPluginManagerBase.php`): `profiler_source`, `profiler_processor`,
  `profiler_destination`. Definitions ship in the three `*.profiler_*.yml` files; default plugin
  classes are `ProfilerSourceDefault` / `ProfilerProcessorDefault` / `ProfilerDestinationDefault`.
  Alterable via `hook_convivial_profiler_profiler_{source,processor,destination}_info_alter()`
  (`convivial_profiler.api.php`).

## Routes (all `_permission: administer convivial profiler`, `_admin_route`)

- `convivial_profiler.settings` — `/admin/config/convivial/profiler/settings` — `SettingsForm`.
- `convivial_profiler.list` — `/admin/config/convivial/profiler` — `ProfilerListForm` (reorder/enable).
- `.profiler_add_form` / `.profiler_edit_form/{profiler_id}` / `.profiler_delete/{profiler_id}` —
  add/edit (AJAX draggable source/processor/destination builder) / delete a profiler.

There are **no anonymous or non-admin routes**; profile data never reaches a Drupal endpoint.

## Permissions / services

- One permission: **`administer convivial profiler`** (menu under `convivial_core.admin_convivial`).
- Services: three plugin managers (`plugin.manager.profiler_{source,processor,destination}`,
  parent `default_plugin_manager`, arg `@theme_handler`) + the hooks class.

## Solution docs

- **Settings, config object, drupalSettings payload, visibility gating** →
  [config/settings.md](config/settings.md)
- **The source→processor→destination pipeline, plugin types, edit-form builder, extension API** →
  [plugins/pipeline.md](plugins/pipeline.md)
- **Submodule `convivial_profiler_sync` (JSON export/import)** →
  [../../../modules/co/convivial_profiler/modules/convivial_profiler_sync/1.0.x/agent/start.md](../../../modules/co/convivial_profiler/modules/convivial_profiler_sync/1.0.x/agent/start.md)
