<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Word Monitor (word_monitor) — agent index

**Define banned words/expressions and get warned when any appear in your site's content, via core-search integration and a status-report warning.**

- **Version:** 4.0.x (installed 4.0.0)
- **Core:** ^10 || ^11 · **PHP:** 8.x
- **Configure route:** `word_monitor.settings` → `/admin/content/words` (form `AdminForm`, permission: `administer site configuration`); local task under `system.admin_content`
- **Services:** `word_monitor` (`WordMonitor`, uses `@state`), `plugin.manager.word_monitor` (`WordMonitorPluginManager`), `word_monitor_plugin_collection`
- **Plugin type:** `@WordMonitorPluginAnnotation` (extend via `WordMonitorPluginBase`) — detection is plugin-driven
- **Submodules:** `word_monitor_search` (core Search integration — site must be indexed) and `word_monitor_status_warning` (warning on `/admin/reports/status`)
- **Helper:** `word_monitor()` returns the service

**Security:** Only route is the admin word-list form, gated by `administer site configuration`. No anonymous or mutating endpoints. **No external HTTP calls, credentials, or API keys** anywhere — all scanning is against local indexed content (read-only).

See [configure/setup.md](configure/setup.md)
