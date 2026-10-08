<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EDW Health check monitoring is a client module that exports a Drupal site's core, module and theme versions, update status, last-cron run, enabled-module list and PHP/database versions as JSON at `/edw_healthcheck/{type}`, so an external EDW HealthCheck monitoring server can poll it over HTTP basic auth with a dedicated account.

---

An organisation running many Drupal sites needs to know, centrally, which of them are behind on security updates — and asking each site's update report by hand does not scale past a handful. This module supplies the machine-readable endpoint a central dashboard polls: `GET /edw_healthcheck/{type}` returns a JSON document assembled by a set of pluggable "component" checks. With the default configuration the payload carries Drupal core update status, every contrib/custom module with its installed version and update status, the theme list, the last-cron timestamp plus a healthy/stale flag (6-hour threshold), the full list of enabled modules, and the server's PHP version and database version. `{type}` defaults to `all`; a specific type (`core`, `modules`, `themes`, `last_cron`, `enabled_modules`, `system`, …) returns just that component. Each component is toggled on the settings form at `/admin/config/system/edw_healthcheck`, and requesting `all`/`core`/`modules` triggers a fresh `update.manager` refresh so version data is current. It depends on core `update` for the version comparison and core `basic_auth` for authentication. The route is gated by an `edw healthcheck access` permission and declares `_auth: ['basic_auth', 'cookie']`; on install the module creates an `edw_healthcheck_role` holding exactly that permission, and the intended pattern is to create a monitoring user in that role and hand its credentials to the monitoring server. Because the JSON is an exact inventory of installed modules and versions — the reconnaissance an attacker most wants — the monitoring account should hold that permission and nothing else, its credentials belong in the monitoring system's secret store, and the endpoint should be served over TLS since basic auth sends the password on every poll. Beyond the web endpoint the module ships legacy Drush 8 commands (`edw_healthcheck-status`, `edw_healthcheck-updates`, `edw_healthcheck-check`, `edw_healthcheck-list`) that render the same data as console tables, extra opt-in components (a core status-report error/warning summary, dblog message counts, an inactive-accounts listing), an admin-only repetitive-warnings report at `/admin/reports/dblog-repetitions`, a `/admin/edw_healthcheck/maintenance-status` route reporting live/maintenance state, and an optional cron job that emails a daily password-reset to healthcheck-role users to verify mail delivery. Version **8.x-1.31**, `^8` through `^11`.

---

- Monitor a fleet of Drupal sites from one dashboard.
- Report every module's installed version and update status as JSON.
- Detect sites behind on security updates centrally.
- Poll site status from an external monitoring server over basic auth.
- Track Drupal core versions across an estate.
- Support an organisation-wide patching programme.
- Expose the last-cron run and a stale-cron flag to monitoring.
- Report the full enabled-module list for inventory.
- Surface PHP and database versions to a monitoring dashboard.
- Monitor an agency's client sites for outdated dependencies.
- Feed a compliance / SLA reporting dashboard.
- Request a single component (`/edw_healthcheck/modules`) instead of the full report.
- Run `drush edw_healthcheck-updates` to list projects with available updates.
- Render update status as console tables in CI or a cron script.
- Summarise the core status report (errors and warnings) for monitoring.
- Report dblog message counts by severity to a dashboard.
- Flag repetitive warning log entries for an administrator.
- List inactive user accounts older than a given last-login timestamp.
- Gate the whole feed behind a dedicated monitoring account and permission.
- Report whether a site is live or in maintenance mode.
- Verify outbound email delivery with a scheduled daily test message.
- Track versions across dev/stage/prod environments.
- Automate update surveillance across a multisite platform.
