<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure WebProfiler

Settings form: route `webprofiler.settings` at
**`/admin/config/development/devel/webprofiler`** (permission `access webprofiler`). Edits the
config object **`webprofiler.settings`**.

## Config keys (`webprofiler.settings`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `exclude_paths` | string (newline list) | `/contextual/*`, `/toolbar/*`, `/edit/*`, `*.js`, `*.css` | Paths not profiled at all. |
| `exclude_toolbar` | string | `/media/oembed` | Paths where the toolbar is not injected. |
| `intercept_redirects` | boolean | `false` | Stop on redirect responses so you can open the profiler instead of following the redirect. |
| `purge_on_cache_clear` | boolean | `true` | Delete stored profiles when the cache is cleared. |
| `active_toolbar_items` | sequence | `ajax, blocks, database, devel, forms, memory, request, time, user, views` | Which collectors show in the toolbar (map of `id: id`). Other installed collectors exist but are off by default. |
| `query_sort` | string | `source` | How the database query log is sorted (`source` / `duration`). |
| `query_highlight` | integer | `5` | Slow-query highlight threshold (ms). |
| `query_detailed_output_threshold` | integer | `1000` | Above this many queries, detailed output is disabled (perf). |
| `ide` | string | `phpstorm://open?file=%f&line=%l` | IDE link format; `%f`=file, `%l`=line. |
| `ide_remote_path` / `ide_local_path` | string | `''` | Path mapping for the IDE link when code runs in a container. |

```bash
drush cget webprofiler.settings
drush cset -y webprofiler.settings intercept_redirects true
drush cset -y webprofiler.settings ide 'vscode://file/%f:%l'
```

## `settings.php` flags (not in config)

- Time metrics: `$settings['tracer_plugin'] = \Drupal\webprofiler\Plugin\Tracer\StopwatchTracer::class;`
  (or point `tracer` at an external store such as Grafana Tempo).
- Disable the custom error handler (e.g. conflict with another error-page module):
  `$settings['webprofiler_error_page_disabled'] = TRUE;` then rebuild cache.
- Profiles are stored under the `profiler` folder in the public files dir (overridable via a
  settings/service parameter — see README "Choose a different folder").

## Notes

- After enabling the module only some toolbar widgets show; enable the rest on the settings
  page (`active_toolbar_items`).
- Development only: WebProfiler swaps in instrumented versions of several core services, which
  adds overhead — never enable it in production.
