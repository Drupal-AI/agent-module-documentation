<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — Word Monitor

## Enable
Enable the base `word_monitor` plus the submodules you need:
```
drush en word_monitor word_monitor_search word_monitor_status_warning -y
```
- **word_monitor** — framework + admin list (no detection on its own).
- **word_monitor_search** — finds entities containing banned words via **core Search**; depends on `search`.
- **word_monitor_status_warning** — adds a warning to `/admin/reports/status` when any banned word is present.

## Define words
Go to `/admin/content/words` (permission `administer site configuration`; also a "Words to monitor" tab under Content). Enter the list of banned words/expressions. The list is stored via `@state` by the `WordMonitor` service.

## Make results appear
`word_monitor_search` relies on the core search index. Ensure content is fully indexed at `/admin/config/search/pages` (run cron / index). Once indexed, `/admin/content/words` lists the entities containing banned words, and `/admin/reports/status` shows a warning if any exist.

## Extend
Detection is plugin-based (`@WordMonitorPluginAnnotation`, base class `WordMonitorPluginBase`, managed by `WordMonitorPluginManager` / collected in `WordMonitorPluginCollection`). To monitor a different data source, create a plugin modeled on the `word_monitor_search` submodule. Access the service in code with the `word_monitor()` helper.

## Notes
- Entirely local: no external calls, API keys, or credentials.
- If no entities are listed, the most common cause is an unindexed site.
