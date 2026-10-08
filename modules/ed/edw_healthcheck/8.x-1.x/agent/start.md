<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EDW Health check monitoring (edw_healthcheck) — agent index

Client module that exports a Drupal site's status and versions **as JSON** for an external EDW HealthCheck
monitoring server. Endpoint: `GET /edw_healthcheck/{type}` (`{type}` defaults to `all`). Depends on core
`update` (version comparison) and **`basic_auth`** (authentication). Version **8.x-1.31**, core `^8 || ^9 || ^10 || ^11`.
Package `Custom`. Not covered by Drupal's security advisory policy.

## What the endpoint returns
Data is assembled by pluggable **component plugins** (plugin type `EDWHealthCheckPlugin`, discovered in
`src/Plugin/EDWHealthCheckPlugin/`). Each component is rendered only if enabled in config
(`edw_healthcheck.components.{type}.enabled`). Enabled by default on install:

| type | plugin | payload |
|------|--------|---------|
| `core` | CoreEDWHealthCheckPlugin | Drupal core project data + update status |
| `modules` | ModulesEDWHealthCheckPlugin | every non-core project: installed version + update status |
| `themes` | ThemesEDWHealthCheckPlugin | theme list with version/enabled state |
| `last_cron` | LastCronEDWHealthCheckPlugin | last cron timestamp + `active_and_running` (6h threshold) |
| `enabled_modules` | EnabledModulesEDWHealthCheckPlugin | flat list of enabled module machine names |
| `system` | SystemEDWHealthCheckPlugin | `php_version` + `mysql_version` (DB `->version()`) |

Opt-in (present but **no default config key**, so dormant until an admin ticks them on the settings form):
`status_report` (core status-report errors/warnings + read-committed check), `log_report` (dblog counts by
severity), `inactive_accounts` (usernames whose last login precedes a `?inactive_accounts=<timestamp>` query arg).

For `type` in `all|core|modules` the controller first calls `update.manager->refreshUpdateData()`, then renders
via `JsonEDWHealthCheckRender` (`Json::encode`). Response is `text/json`, max-age 0.

## Access model (verify on any module of this kind)
```yaml
edw_healthcheck.status:            # /edw_healthcheck/{type}
  options:  { _auth: ['basic_auth', 'cookie'] }
  requirements: { _permission: 'edw healthcheck access' }
```
`hook_install()` creates role `edw_healthcheck_role` holding only `edw healthcheck access`. The intended pattern:
a dedicated monitoring user in that role, credentials supplied to the monitoring server (see README —
`$config['edw_healthcheck.settings']['hc_user'|'hc_password']`, though those config keys are legacy and not read
by current code). Confirmed on the running site: `GET /edw_healthcheck/all` returns **401** anonymously; the
main feed is **not** open. The payload is a reconnaissance inventory (exact module list + versions), so the
monitoring account should hold that permission and nothing else, over **TLS** (basic auth sends the password each poll).

## Other routes
- `/admin/config/system/edw_healthcheck` — settings form (`administer site configuration`); toggles the status
  page and each component, plus the daily-email option.
- `/admin/reports/dblog-repetitions` — admin table of repetitive dblog warnings (`administer site configuration`).
- `/admin/edw_healthcheck/maintenance-status` — plain-text "live"/"maintenance" state (`access content`).

## Drush (legacy Drush 8 `.drush.inc`, hook_drush_command)
`edw_healthcheck-status`, `edw_healthcheck-updates [all|security]` (alias `-up`), `edw_healthcheck-check <cmd>`
(alias `edw_healthcheck`), `edw_healthcheck-list` (alias `-ls`). `-updates` renders core/modules/themes via
`ConsoleEDWHealthCheckRender` as text tables. NOTE: this is the Drush 8 hook style, not a Drush 9+ command class.

## Cron
`edw_healthcheck_cron()` — only when `edw_healthcheck.daily_email.enabled` (default **false**). Once per day within
a configured hour window (Europe/Bucharest tz), sends a `password_reset` mail to every active user in
`edw_healthcheck_role` as an email-delivery test. Off by default.

## Solution docs
- `api/endpoint.md` — request/response shape, component types, per-type behaviour, integration notes.

## Key files
- `src/Controller/EDWHealthCheckPageController.php` — the endpoint (`content()`), `viewMaintenanceStatus()`, `repetitiveWarnings()`.
- `src/Plugin/EDWHealthCheckPlugin/*` — the component plugins + base/interface/manager/annotation.
- `src/Render/{Json,Console}EDWHealthCheckRender.php` — output formatters.
- `src/Form/SettingsForm.php`, `config/install/edw_healthcheck.settings.yml`, `edw_healthcheck.routing.yml`,
  `edw_healthcheck.permissions.yml`, `edw_healthcheck.install`, `edw_healthcheck.module`, `edw_healthcheck.drush.inc`.
