<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
OhDear Integration connects a Drupal site to the Oh Dear monitoring service: it exposes Drupal's health as a JSON endpoint Oh Dear can poll, pings Oh Dear on cron for scheduled-task monitoring, and brings Oh Dear's own data — checks, uptime and broken links — back into the Drupal admin.

---

The traffic goes both ways. Outbound, `/json/oh-dear-health-check-results` republishes the results of the `monitoring` module's sensors in Oh Dear's application-health-check format, so cron failures, disk pressure and available security updates surface in the same dashboard as uptime; a request must present the configured health-check secret (header or query arg) or hold the `monitoring reports` permission, and Oh Dear caps a report at 50 checks so the enabled sensor count should stay under that. The endpoint can be cached by setting `healthcheck_cache_max_age`, and a page-cache request policy keeps secret-header requests out of Drupal's internal Page Cache. On cron, `ohdear_integration_cron()` pings the configured Oh Dear scheduled-tasks URL so a missed cron shows up as a late task. Inbound, the module wraps the Oh Dear PHP SDK (`ohdear_sdk` / `ohdear_integration.info` services) behind an API key and monitor id: the report pages under `/admin/reports/ohdear/{info,broken-links,uptime}/{monitor_id}` (permission `access ohdear info`) and the `ohdear:maintenance`, `ohdear:info`, `ohdear:broken-links` and `ohdear:uptime` drush commands read checks, uptime percentages, broken links and maintenance windows, and can start or stop a maintenance window (optionally toggling Drupal's maintenance mode with it). Credentials, the cron URI and the monitor id are set on the settings form at `/admin/config/system/ohdear-settings` and each can be overridden by an environment variable.

---

- Publish Drupal health to Oh Dear as application health checks.
- Expose monitoring sensor results as JSON at a single endpoint.
- Monitor cron failures externally through Oh Dear.
- Alert on available security updates via a monitoring sensor.
- Surface disk or database pressure in Oh Dear.
- Send a scheduled-tasks ping to Oh Dear on every cron run.
- Detect a stalled or missed cron job.
- Cache the health-check endpoint for a fixed number of seconds.
- Keep secret-header health requests out of the internal Page Cache.
- Show Oh Dear uptime percentages inside the Drupal admin.
- Review Oh Dear's broken-link report from Drupal.
- List a monitor's Oh Dear checks from an admin page.
- Start or stop an Oh Dear maintenance window from drush.
- Put Drupal into maintenance mode alongside an Oh Dear window.
- Print monitor id, url and summarized check result from the CLI.
- List every monitor available to the configured API key.
- Query uptime for a custom date range and split (hour/day/month).
- Point the module at a different monitor per drush call.
- Configure Oh Dear credentials from environment variables.
- Combine application-health and uptime monitoring in one dashboard.
- Give an SRE team a single Drupal-fleet monitoring view.
