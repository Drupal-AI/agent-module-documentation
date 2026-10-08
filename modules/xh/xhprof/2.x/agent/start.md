<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# XHProf (xhprof) — agent index

Hierarchical PHP profiler integration. When enabled, an event subscriber
(`XHProfEventSubscriber`) starts the active profiler extension on `kernel.request`
(if the extension is loaded, `xhprof.config:enabled` is TRUE, the path is not excluded, and the
optional sampling `interval` selects this request), stops it and serialises the raw run to storage
on `kernel.terminate`, and — for users holding `access xhprof data` — injects an "XHProf output"
link before `</body>` on `kernel.response` (skipped when the `webprofiler` module is present, which
gets a data-collector widget instead). Runs are viewed through `XHProfController` under
`/admin/reports/xhprof`: a runs list, a per-run function table (sortable, top-N/all), and a
parent/child drill-down per symbol. The report engine parses the stored xhprof array into
inclusive/exclusive metric tables.

Supports four profiler extensions selected in config: `xhprof`, `uprofiler`, `tideways`,
`tideways_xhprof` (wrapper classes under `src/Extension/`). Run storage is pluggable via
tagged services (`xhprof_storage`); only one backend ships — `xhprof.file_storage`
(`FileStorage`), which writes `{run_id}.{namespace}.xhprof` files into `ini_get('xhprof.output_dir')`
or `sys_get_temp_dir()`. There is **no plugin manager** (storage backends are plain tagged services
collected by a compiler pass, not annotated/attribute plugins).

- Depends on: nothing (info.yml has no `dependencies`). Optional soft integration: `webprofiler`
  (detected via `module_handler`).
- Core: `^10.2 || ^11`. Package: `Development`. Version: `2.0.0-beta1`.
- Requires a profiler **PHP extension** (`xhprof`/`tideways`/…) to actually collect data; without it
  the config form disables the "enabled" checkbox and no runs are produced.
- Settings page: **yes** — `configure: xhprof.admin_configure` (`/admin/config/development/xhprof`).
- Permissions: **yes** — `administer xhprof` (restrict access), `access xhprof data`.
- Config schema: **yes** (`xhprof.config`). Plugin types: **none**. Drush: legacy `xhprof.drush.inc`
  only (Drush-8 `hook_drush_command` API; broken on modern Drush — see below), so effectively none.
- Off by default: `config/install/xhprof.config.yml` ships `enabled: false`.

## What you'd do → where

- **Turn profiling on/off, pick the extension, exclude paths, set sampling interval, choose storage**
  → [configure/settings.md](configure/settings.md)
- **Call the profiler/storage/report services from PHP, add a custom storage backend, understand the
  report routes & controller actions** → [api/services.md](api/services.md)
- **Who can view profiles / administer settings, and how the routes are gated** →
  [permissions/permissions.md](permissions/permissions.md)

## Key facts (real machine names)

- Routes (controller `Drupal\xhprof\Controller\XHProfController`):
  - `xhprof.admin_configure` — `/admin/config/development/xhprof` — `_form` `ConfigForm`,
    `_permission: administer xhprof`.
  - `xhprof.runs` — `/admin/reports/xhprof` — `runsAction`; perm `access xhprof data+administer xhprof`.
  - `xhprof.run` — `/admin/reports/xhprof/{run}` — `runAction`; query `?length` (default 100, `-1`=all),
    `?sort` (default `wt`); `{run}` upcast via param converter `xhprof:run_id`.
  - `xhprof.symbol` — `/admin/reports/xhprof/{run}/symbol/{symbol}` — `symbolAction`;
    requirement `symbol: .+`.
  - `xhprof.diff` — `/admin/reports/xhprof/diff/{run1}/{run2}` — `diffAction`; **returns
    `'Not working yet'`** (stub, non-functional in this release).
  - Report routes all use `_permission: 'access xhprof data+administer xhprof'` (the `+` means **OR**).
- Services (`xhprof.services.yml`): `xhprof.profiler` (`Profiler`), `xhprof.storage`
  (`StorageInterface` built by `StorageFactory::getStorage`), `xhprof.file_storage` (`FileStorage`,
  tag `xhprof_storage`), `xhprof.storage_manager` (`StorageManager`), `xhprof.report_engine`
  (`ReportEngine`), `xhprof.matcher` (`XHProfRequestMatcher`), `xhprof.run_converter` (`RunConverter`,
  tag `paramconverter`), `xhprof.xhprof_event_subscriber` (`XHProfEventSubscriber`, tag
  `event_subscriber`).
- Param-converter type: `xhprof:run_id` (`RunConverter` → `Profiler::getRun()` → `Run` value object).
- Storage collection: compiler pass `Drupal\xhprof\Compiler\StoragePass` gathers all `xhprof_storage`
  tagged services into `StorageManager::addStorage()`; the active backend is chosen by
  `xhprof.config:storage` (default `xhprof.file_storage`).
- Config object `xhprof.config` keys: `enabled` (bool), `extension` (string:
  `xhprof|uprofiler|tideways|tideways_xhprof`), `exclude` (multiline paths), `interval` (int sampling),
  `flags` (`FLAGS_CPU`/`FLAGS_MEMORY`/`FLAGS_NO_BUILTINS` string '0'/name), `exclude_indirect_functions`
  (bool), `storage` (service id), `show_summary_toolbar` (bool, webprofiler only).
- Permissions: `administer xhprof` (`restrict access: true`), `access xhprof data`.
- Library: `xhprof/xhprof` (`css/xhprof.css`, `js/xhprof.js`, dep `core/jquery`).
- Menu links (`xhprof.links.menu.yml`): `xhprof.admin_configure` (parent
  `system.admin_config_development`), `xhprof.runs` (parent `system.admin_reports`).
- Webprofiler integration: `XhprofServiceProvider` registers data collector `webprofiler.xhprof`
  (`XHProfDataCollector`) when the `profiler` service exists; template
  `@xhprof/Collector/xhprof.html.twig`; collector id `xhprof`.
- Extension wrappers (`src/Extension/`): `XHProfExtension`, `UprofilerExtension`, `TidewaysExtension`,
  `TidewaysXHProfExtension` (each `::isLoaded()` / `enable()` / `disable()` / `getOptions()`).
- Run namespace = sanitised `system.site:name` (`.`,`/`,`\` → `-`); file name `{run_id}.{namespace}.xhprof`.
- Legacy `xhprof.drush.inc` declares `xhprof-list` / `xhprof-combine` / `xhprof-clear` via the
  removed Drush-8 `hook_drush_command()` API and references an undefined `XHProfRuns_Default` class;
  treat as **non-functional** on Drush 12/13.
