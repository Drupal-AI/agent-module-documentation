<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Render Auditor (ara) — agent index

A **local-development render-tree profiler**. It swaps the core `renderer` service for a decorator
(`ProfilingRenderer`) that times every `doRender()` call, captures the SQL queries and `#cache`
metadata for each element, and renders a floating results panel (plus optional inline timing
badges). Package `Development`. Depends only on core **`system`**. Core `^10 || ^11`. License
GPL-2.0-or-later. Version 1.0.1. No composer/contrib dependencies, no submodules, no Drush.

- **Enable, configure, permission, routes, the Status Report warning** →
  [config/settings.md](config/settings.md)
- **How profiling works: the renderer decorator, tracer, logger, hooks, annotations** →
  [api/profiler.md](api/profiler.md)

## What it actually is

- **Service decorator**, not a plugin type. `AraServiceProvider::alter()` (in
  `src/AraServiceProvider.php`) reclasses core's `renderer` to `Drupal\ara\ProfilingRenderer` and
  wires three collaborators via setter injection: `ara.run_settings`, `ara.tracer`, `ara.logger`.
- **Services** (`ara.services.yml`, autowired): `ara.tracer` (`Tracer`), `ara.run_settings`
  (`ProfileRunSettings`), `ara.logger` (`ProfilerLogger`), and the OOP hook class
  `Drupal\ara\Hook\AraHooks`.
- **One route**: `ara.settings` → `/admin/config/development/ara` (`SettingsForm`), gated by
  permission `use ara profiler`. Menu link under *Configuration → Development*.
- **One permission**: `use ara profiler` (`restrict access: true`) — gates both the settings form
  and whether profiling runs for a request.
- **One config object**: `ara.settings` (`enabled`, `display_annotations`,
  `annotation_threshold_ms`); schema in `config/schema/ara.schema.yml`, defaults in
  `config/install/ara.settings.yml`.
- **Two theme hooks**: `ara_results` (`templates/ara-results.html.twig`) and `ara_cache_details`
  (`templates/ara-cache-details.html.twig`); library `ara/profiler` (`js/ara.js`, `css/ara.css`).
- **Hooks** (`AraHooks`, attribute-based `#[Hook]` with `#[LegacyHook]` procedural shims in
  `ara.module`): `page_attachments`, `page_bottom`, `theme`, `help`. Install hook
  `ara_requirements()` warns on the Status Report while enabled; `ara_update_11001()` migrates the
  old `dxp_performance.settings` config + `use dxp performance profiler` permission.
- **Enums** (`src/Enum/`) centralize string constants: `Permissions`, `ConfigNames`, `Templates`,
  `FormFieldNames`, `Severity` (render-time → CSS band).

## Gate (from source)

`ProfilingRenderer::doRender()` returns `parent::doRender()` immediately unless
`ProfileRunSettings::isActive()` is TRUE. `isActive()` requires: not stopped, **not an admin
route**, config `enabled` TRUE, and `currentUser->hasPermission('use ara profiler')`. The results
panel is deferred via a `#lazy_builder` placeholder (`ara.logger:buildResultsPanel`) so it renders
after all blocks/BigPipe fragments; that build then calls `stop()` so the panel does not profile
itself.
