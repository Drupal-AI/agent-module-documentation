<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# edw_healthcheck — HTTP endpoint & Drush

## Route
`edw_healthcheck.status` → path `/edw_healthcheck/{type}`, `{type}` default `all`.
Controller: `EDWHealthCheckPageController::content($type)`.

- Auth: `_auth: ['basic_auth', 'cookie']`
- Access: `_permission: 'edw healthcheck access'` (granted on install to role `edw_healthcheck_role`).
- If `edw_healthcheck.statuspage.enabled` config is false → `AccessDeniedHttpException` ("Edw health check page is disabled!").
- Response: `Content-Type: text/json`, `Cache-Control` no-store (max-age 0, expires null). Body is `Json::encode($data)`.

### Type handling
- `type = all` → iterate every registered plugin definition, merge each enabled component's `getData()`.
- `type = <component>` → resolve the plugin whose annotation `type` matches, render only it.
- For `type` in `all|core|modules` the controller calls `update.manager->refreshUpdateData()` first (network fetch to the update source; can be slow).
- A component is included only if `edw_healthcheck.components.{type}.enabled` is truthy in config.

### Component payloads (default-enabled)
- `core` — the `drupal` project row from `update_calculate_project_data()`: `existing_version`, `latest_version`, `status`, `project_type: core`, etc.
- `modules` — same, keyed by every non-`drupal` project.
- `themes` — each theme's info array + `project_type: theme`.
- `last_cron` — `{ last_cron_run, timestamp, request_time, active_and_running (bool, stale if > 6h), project_type: last_cron }`.
- `enabled_modules` — `{ enabled_modules: { project_type, modules: [<machine names>] } }`.
- `system` — `{ system_info: { project_type, php_version: PHP_VERSION, mysql_version: <db->version()> } }`.

### Component payloads (opt-in; require enabling on the settings form)
- `status_report` — core status-report `error`/`warning` items (title/value/description, decoded, base-url-rewritten links), `database_read_committed` flag, extra dblog row-limit warnings.
- `log_report` — dblog counts by severity (error/notice/warning/critical/alert/emergency) + repetitive-warning count. Empty if `dblog` not installed.
- `inactive_accounts` — reads `?inactive_accounts=<unix timestamp>` from the query string; returns active accounts (uid>0, status=1) whose `login` < that timestamp as `{ uid: username }`. Empty when the query arg is absent.

## Example
```
curl -u monitor_user:secret https://example.com/edw_healthcheck/all
curl -u monitor_user:secret https://example.com/edw_healthcheck/modules
```
Anonymous requests receive **401** (verified). Serve over HTTPS — basic auth transmits the password on every poll.

## Other routes
- `/admin/config/system/edw_healthcheck` — `SettingsForm` (`administer site configuration`). Toggles status page, each component checkbox (driven by discovered plugin definitions), and the daily-email option + hour window.
- `/admin/reports/dblog-repetitions` — `repetitiveWarnings()` render-array table; `administer site configuration`; 404 if `dblog` absent.
- `/admin/edw_healthcheck/maintenance-status` — `viewMaintenanceStatus()`; returns plain text "The site is currently live." / "…in maintenance mode."; access `access content`.

## Drush (legacy Drush 8 hook style, `edw_healthcheck.drush.inc`)
- `edw_healthcheck-status` — prints "EDWHealthCheck is up and running!".
- `edw_healthcheck-updates [all|security]` (alias `edw_healthcheck-up`) — core+modules+themes rendered as text tables via `ConsoleEDWHealthCheckRender`.
- `edw_healthcheck-check <cmd>` (alias `edw_healthcheck`) — runs a check registered via `hook_edw_healthcheck_checks()`; JSON-encodes and exits.
- `edw_healthcheck-list` (alias `edw_healthcheck-ls`) — lists available commands/checks.

## Extension hooks
Legacy procedural hooks let other modules add checks: `hook_edw_healthcheck_checks()`, `hook_edw_healthcheck_check($fn)`, `hook_edw_healthcheck()`. The modern path is to add an `EDWHealthCheckPlugin` annotated plugin class in `src/Plugin/EDWHealthCheckPlugin/` implementing `getData()`, plus a matching `edw_healthcheck.components.<type>.enabled` config key.
