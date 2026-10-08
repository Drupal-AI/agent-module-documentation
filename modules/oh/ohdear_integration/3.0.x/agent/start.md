<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ohdear_integration — agent index

Integrates a Drupal site with the **Oh Dear** monitoring service. It publishes the
`monitoring` module's sensor results as an Oh Dear *application health check* JSON
endpoint, pings Oh Dear on cron (scheduled-tasks monitoring), and pulls Oh Dear data
(checks, uptime, broken links, maintenance windows) back into Drupal admin report
pages and drush commands through the Oh Dear PHP SDK.

- Requires `monitoring` (`monitoring:monitoring`); Composer also pulls
  `ohdearapp/ohdear-php-sdk ^4.4.0` and `ohdearapp/health-check-results ^1.0`.
- Core: `^10 || ^11`. Configure route: `ohdear_integration.settings`
  (`/admin/config/system/ohdear-settings`).
- Defines 1 permission, 4 drush commands and config schema; no plugin types.

## What you'd do → doc
- **Set the health secret / API key / cron URI / monitor id** → [configure/settings.md](configure/settings.md)
- **Understand the health-check JSON endpoint & its caching** → [api/healthcheck-endpoint.md](api/healthcheck-endpoint.md)
- **Call the Oh Dear data services / read the report pages** → [api/services.md](api/services.md)
- **Run maintenance / info / uptime / broken-links from the CLI** → [drush/commands.md](drush/commands.md)
- **Grant access to the Oh Dear report pages** → [permissions/permissions.md](permissions/permissions.md)
- **Ping Oh Dear scheduled-tasks on cron** → [hooks/cron.md](hooks/cron.md)

## Key facts
- Config object `ohdear_integration.settings` — keys `ohdear_healthcheck_secret`,
  `ohdear_cron_uri`, `ohdear_api_key`, `ohdear_monitor_id`, plus optional
  `healthcheck_cache_max_age` (read by code, not in the shipped schema).
- Env overrides (each wins over config): `OHDEAR_API_KEY`, `OHDEAR_HEALTHCHECK_SECRET`,
  `OHDEAR_MONITOR_ID`, `OHDEAR_CRON_URI`.
- Routes: `ohdear_integration.healthcheck` → `/json/oh-dear-health-check-results`;
  `ohdear_integration.settings` → `/admin/config/system/ohdear-settings`;
  `ohdear_integration.info` / `.broken_links` / `.uptime` →
  `/admin/reports/ohdear/{info,broken-links,uptime}/{monitor_id}`.
- Services: `ohdear_healthcheck.generator` (OhDearHealthcheckGenerator),
  `ohdear_sdk` (OhDearSdkService), `ohdear_integration.info` (OhDearInfo), and a
  page-cache request policy `ohdear_healthcheck.page_cache_request_policy.disallow_ohdear_healthcheck_requests`.
- Permission: `access ohdear info`. Drush: `ohdear:maintenance`, `ohdear:info`,
  `ohdear:broken-links`, `ohdear:uptime`.
