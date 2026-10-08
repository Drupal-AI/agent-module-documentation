# csp_log — agent index

Dedicated Content-Security-Policy report endpoint + logging for Drupal 9.2/10/11.
Accepts POSTed CSP violation JSON at `/log-report-uri/{type}`, stores each report in
its own `csp_log` table (not watchdog/dblog), and shows list + aggregated admin views.
Integrates with the [csp](https://www.drupal.org/project/csp) module via a reporting
handler plugin, but the endpoint also works standalone.

Key facts:
- Report endpoint route `csp_log.reporturi` → path `/log-report-uri/{type}` (`_access: TRUE`, `no_cache`). `{type}` is `enforce` or anything else → stored as `reportOnly`.
- Admin routes `csp_log.overview` (`/admin/reports/csp`) and `csp_log.aggregated` (`/admin/reports/csp/aggregated-logs`), both need permission `access csp_log reports`.
- info.yml declares `configure: csp_log.settings`, but **no such route exists** — there is no settings form; configuration happens on the CSP module's policy form.

Solution docs:
- [Configure the endpoint & view reports](configure/configure.md) — wiring via the CSP module, report URIs, cron cleanup, permission, admin screens.
- [Provided plugin: Dedicated CSP log handler](plugins/plugins.md) — the `csp_log` CspReportingHandler for the csp module.
- [Programmatic API: the `csp_log` service](api/api.md) — insert/fetch/aggregate/remove logs from code.
