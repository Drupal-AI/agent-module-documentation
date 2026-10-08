# Services, report routes & extending storage (API)

## Services (`xhprof.services.yml`)

| Service id | Class | Args / tags |
|---|---|---|
| `xhprof.profiler` | `Drupal\xhprof\Profiler` | `config.factory`, `xhprof.storage`, `xhprof.matcher` |
| `xhprof.storage` | `…\XHProfLib\Storage\StorageInterface` | built by `StorageFactory::getStorage(config.factory, service_container)` — returns the service named by `xhprof.config:storage` (default `xhprof.file_storage`). |
| `xhprof.file_storage` | `…\XHProfLib\Storage\FileStorage` | tag `xhprof_storage` |
| `xhprof.storage_manager` | `…\XHProfLib\Storage\StorageManager` | populated by `StoragePass` |
| `xhprof.report_engine` | `…\XHProfLib\Report\ReportEngine` | — |
| `xhprof.matcher` | `…\RequestMatcher\XHProfRequestMatcher` | `config.factory`, `path.matcher` |
| `xhprof.run_converter` | `…\Routing\RunConverter` | `xhprof.profiler`; tag `paramconverter` |
| `xhprof.xhprof_event_subscriber` | `…\EventSubscriber\XHProfEventSubscriber` | `xhprof.profiler`, `current_user`, `module_handler`; tag `event_subscriber` |

## Profiler API — `Drupal\xhprof\ProfilerInterface`

`$p = \Drupal::service('xhprof.profiler');`

- `canEnable(Request $r): bool` — TRUE if extension loaded **and** `xhprof.config:enabled` **and**
  `matcher->matches($r)` **and** the sampling interval selects the request.
- `enable()` — computes the flag modifier from `xhprof.config:flags` (OR of `@constant()` of each
  extension flag) and `exclude_indirect_functions`, then `activeExtension->enable()`.
- `shutdown($runId)` — `activeExtension->disable()` then `storage->saveRun($data, $namespace, $runId)`.
- `createRunId()` — lazily returns a `uniqid()` run id.
- `getRun($run_id): Run` — `storage->getRun($run_id, $namespace)`; throws (converter catches) if missing.
- `getStorage()`, `getExtensions()`, `isLoaded()`, `isEnabled()`, `link($run_id)` (absolute link to
  `xhprof.run`). The site "namespace" is `system.site:name` sanitised.

The **event subscriber** drives all of this automatically: `onKernelRequest` → `enable()` if
`canEnable`; `onKernelResponse` → creates the run id and (unless `webprofiler` is enabled) injects
`<div class="xhprof-ui">{link}</div>` before `</body>` **only for users with `access xhprof data`**,
and only for HTML responses (returns early for xml/json/csv/image/etc. content types);
`onKernelTerminate` → `shutdown()` saves the run.

## Storage backend — `StorageInterface`

Methods: `getRun($run_id, $namespace): Run`, `getRuns($namespace = NULL): array`,
`saveRun($data, $namespace, $run_id)`, `getName(): string`.

`FileStorage` details: dir = `ini_get('xhprof.output_dir')` or `sys_get_temp_dir()`; file
`{run_id}.{namespace}.xhprof`; `saveRun()` `serialize()`s, `getRun()` `@unserialize()`s;
`getRuns()` globs `*.xhprof` and parses `run_id`/`namespace` from the filename.

### Add a custom storage backend

1. Create a class implementing `StorageInterface`.
2. Register it as a service tagged `xhprof_storage` (the `StoragePass` compiler pass adds every such
   service to `StorageManager`, and it becomes a radio option on the settings form).
3. Select it at `/admin/config/development/xhprof` (writes its service id to `xhprof.config:storage`,
   which `StorageFactory` resolves for `xhprof.storage`).

## Report engine & controller

`ReportEngine::getReport($url_params, $source, Run $run, $wts, $symbol, $sort = 'wt', ?Run $run1, ?Run $run2)`
builds a `Report` from a `Parser($run, $sort, $symbol)` (or a `DiffReport` from two runs). Metrics /
descriptions / sortable columns come from `XHProfLib\Report\ReportConstants`.

`XHProfController` actions:

| Action | Builds | Notable input |
|---|---|---|
| `runsAction()` | table of runs (`View` link, file size, path, date) from `storage->getRuns()`. | — |
| `runAction(Run $run, Request $r)` | summary table + top-N function table. | `?length` (default 100, `-1`=all), `?sort` (default `wt`). Cache context `url.query_args`. |
| `symbolAction(Run $run, $symbol, Request $r)` | parent/child drill-down for one function. | `{symbol}` (route, `.+`), `?sort`. |
| `diffAction(Run $run1, Run $run2)` | **stub** — returns `#markup: 'Not working yet'`. | — |

`{run}`/`{run1}`/`{run2}` are upcast to `Run` objects by `RunConverter` (param type `xhprof:run_id`);
a missing run makes the converter return `NULL` → 404.

## Webprofiler data collector

`XhprofServiceProvider` registers `webprofiler.xhprof` (`XHProfDataCollector`) when the `profiler`
service exists (data_collector id `xhprof`, template `@xhprof/Collector/xhprof.html.twig`). It exposes
`getCalls()`/`getWt()`/`getShowSummaryData()` for the toolbar; `hasPanel()` is FALSE.

## Drush (legacy, non-functional)

`xhprof.drush.inc` uses the removed Drush-8 `hook_drush_command()` API to declare `xhprof-list`,
`xhprof-combine`, `xhprof-clear`, and calls an **undefined** `XHProfRuns_Default` class. Modern Drush
(9+) ignores `*.drush.inc`, so these commands do not register — do not rely on them.
