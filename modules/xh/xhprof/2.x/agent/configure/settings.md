# Configure profiling — `xhprof.admin_configure`

Route `xhprof.admin_configure` → `/admin/config/development/xhprof` → `Drupal\xhprof\Form\ConfigForm`
(perm `administer xhprof`). It edits the single config object **`xhprof.config`**.

If no supported profiler PHP extension is loaded (`Profiler::isLoaded()` counts
`XHProfExtension`/`UprofilerExtension`/`TidewaysExtension`/`TidewaysXHProfExtension` `::isLoaded()`),
the form shows a warning and **disables the "enabled" checkbox** — you cannot turn profiling on
without the extension.

## Config keys (`xhprof.config`)

| Key | Form field | Type | Default (install) | Meaning |
|---|---|---|---|---|
| `enabled` | "Enable profiling of page views" | bool | `false` | Master switch. Effective value is `extension_loaded & enabled`. |
| `extension` | "Extension" (select) | string | *(unset)* | One of `xhprof`, `uprofiler`, `tideways`, `tideways_xhprof`. Options come from `Profiler::getExtensions()` (only currently-loaded ones). |
| `exclude` | "Exclude" (textarea) | string | `/contextual/*`,`/toolbar/*`,`/edit/*`,`/admin/*`,`/profiler/*`,`*.js`,`*.css` (one per line) | Paths NOT to profile; matched by `path.matcher`. |
| `interval` | "Profiling interval" (number, min 0) | int | `0` | Approx. requests between samples. `0` = profile every request. Sampling test: `mt_rand(1,$interval) % $interval != 0` skips. |
| `flags` | "Profile" (checkboxes) | mapping | all `'0'` | `FLAGS_CPU`, `FLAGS_MEMORY`, `FLAGS_NO_BUILTINS`; each checked flag is OR-ed into the extension's option constant via `@constant($extensionFlag)`. |
| `exclude_indirect_functions` | "Exclude indirect functions" | bool | `false` | When true, passes `ignored_functions => [call_user_func, call_user_func_array]` to the extension. |
| `storage` | "Profile storage" (radios) | string | `xhprof.file_storage` | A service id tagged `xhprof_storage`. Options come from `StorageManager::getStorages()`. |
| `show_summary_toolbar` | "Show summary data in toolbar" | bool | `false` | Only shown/used when the `webprofiler` module is enabled; renders summary into its toolbar. |

`submitForm()` always writes all eight keys (including `show_summary_toolbar` even when webprofiler
is absent — the value is then whatever was posted / null).

## Path exclusion (`XHProfRequestMatcher`)

`xhprof.matcher` (`XHProfRequestMatcher::matches()`) reads `xhprof.config:exclude`, **always appends
`\r\n/admin/reports/status/php`** (the phpinfo page is never profiled), and returns
`!path.matcher->matchPath($requestPath, $patterns)`. So the report/admin pages are excluded by the
default patterns; profiling targets front-end/business routes.

## Storage location (file backend)

`FileStorage` writes to `ini_get('xhprof.output_dir')` if set, else `sys_get_temp_dir()`. File name is
`{run_id}.{namespace}.xhprof`, where `namespace` = `system.site:name` with `.`/`/`/`\` replaced by `-`,
and `run_id` = `uniqid()`. Runs are stored as `serialize()`d raw profiler arrays and read back with
`@unserialize()`.

## Enable from the CLI (example)

```bash
# Requires a profiler PHP extension to be loaded for data to be collected.
ddev drush config:set xhprof.config extension xhprof -y
ddev drush config:set xhprof.config enabled 1 -y
ddev drush config:set xhprof.config interval 0 -y     # profile every request
# Then browse a non-excluded page and open /admin/reports/xhprof.
```
