Status Dashboard Client is the client-side companion to the Status Dashboard module: it exposes a secret-protected JSON endpoint reporting the site's core/module versions, pending security and feature updates, and requirement errors, so a central Status Dashboard site can monitor many client sites.

---

Enabling the module adds one endpoint, `GET /status_dashboard/check` (route `status_dashboard_client.check`), guarded by a custom access check that compares the request's `x-dashboard-secret` header against the `secret` string saved on the settings form (`/admin/config/development/status-dashboard-client`, permission `administer status_dashboard_client configuration`). On a matching request the controller runs core Update Manager (`update_get_available(TRUE)` + `update_calculate_project_data()`), then returns a JSON document with `date`, `core` (Drupal version), `modules` (name → version map), `security_updates`, `feature_updates`, `sitename`, `url`, and `error_count` (count of requirement errors of severity > warning). The response is `no_cache` and modules can extend it via `hook_status_dashboard_json_response_alter(&$json_response, $projects_data)` (e.g. to append PHP version or last cron run). The base **Status Dashboard** module (installed on a separate monitoring site) is configured with each client's URL + secret and polls these endpoints to aggregate update/security status, optionally emailing daily/weekly/monthly notifications. This module depends only on core `update`; it stores just the shared `secret` in `status_dashboard_client.settings` and defines no plugins, Drush commands, or config schema. Set the shared secret after enabling; no default secret ships.

---

- Report a client site's available core and contributed-module updates to a central dashboard.
- Surface which installed projects have pending security updates across many sites at once.
- Track the exact core and module versions running on each monitored site.
- Feed a multi-site "needs updating" overview without logging into each site individually.
- Count outstanding status-report requirement errors (severity above warning) per site.
- Trigger email notifications (from the base module) when a client site has security updates.
- Provide a machine-readable site inventory (`modules` map) for an ops dashboard.
- Authenticate dashboard polls with a per-site shared secret via the `x-dashboard-secret` header.
- Monitor a fleet of Drupal sites for feature (non-security) update availability.
- Expose the current site name and base URL to the monitoring dashboard.
- Append custom telemetry (PHP version, last cron run) to the report via the alter hook.
- Centralize update compliance reporting for an agency managing many client sites.
- Detect drift where a site is running an unsupported or out-of-date release.
- Integrate site health into an external monitoring pipeline that reads the JSON endpoint.
- Let a monitoring site pull status on a schedule instead of pushing from each client.
- Provide a lightweight alternative to logging into `/admin/reports/updates` per site.
- Give an operations team a single pane of glass for update status across environments.
- Rotate the shared secret per client site by editing one settings field.
- Extend the payload with project-specific data for a custom dashboard consumer.
- Report requirement/status-page errors so failing sites can be triaged centrally.
