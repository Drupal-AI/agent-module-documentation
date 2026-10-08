CSP logging provides a dedicated Content-Security-Policy report endpoint that writes violation reports to its own database table instead of flooding Drupal's watchdog/dblog, plus admin screens to browse and aggregate those reports.

---

The module exposes a public report endpoint at `/log-report-uri/{type}` (`type` is `report-only`/`reportOnly` or `enforce`) that accepts POSTed CSP violation JSON, parses the `csp-report` payload, and stores each violation as a row in a dedicated `csp_log` table (document URI, effective directive, blocked URI, referrer, type, raw report blob and timestamp). Reports are viewed at `/admin/reports/csp` (per-violation list with search, type and date filters) and `/admin/reports/csp/aggregated-logs` (violations grouped by blocked URI + effective directive with counts), both gated by the `access csp_log reports` permission. It ships a `CspReportingHandler` plugin ("Dedicated CSP log", id `csp_log`) for the [CSP](https://www.drupal.org/project/csp) module, so selecting that handler for the enforce or report-only policy automatically points the `report-uri` directive at this endpoint. The handler adds a "Log lifetime (days)" option; `hook_cron()` reads that `cleanup` value from `csp.settings` and deletes logs older than the configured age (0 = keep forever). The reporting endpoint itself is unauthenticated (`_access: TRUE`, `no_cache`) so browsers can post reports, returning HTTP 202 on success, 400 on a malformed or incomplete report, and 500 on other errors. The module works with the CSP module for automatic wiring, but the endpoint can also be used standalone by pointing any CSP `report-uri`/`report-to` directive at the path manually. All logging goes through the `csp_log` service (`CspLogService`), which also backs the admin forms and can be called programmatically.

---

- Collect Content-Security-Policy violation reports without crowding the site's watchdog/dblog logs.
- Provide a ready-made CSP `report-uri` endpoint so you don't have to write a custom route.
- Wire a CSP report endpoint automatically by selecting the "Dedicated CSP log" handler in the CSP module.
- Store enforced-policy violations separately from report-only violations via the `{type}` path segment.
- Browse individual CSP violations at `/admin/reports/csp` with date, type and free-text search filters.
- See which resources are most often blocked using the aggregated view grouped by blocked URI and directive.
- Identify third-party scripts, images or fonts that your CSP is blocking so you can whitelist or remove them.
- Tune a report-only CSP policy before enforcing it by watching real violation reports roll in.
- Detect potential XSS / injection attempts surfaced as inline-script or unexpected-origin violations.
- Automatically prune old CSP logs on cron by setting a "Log lifetime (days)" value on the handler.
- Keep an unauthenticated, cache-bypassing endpoint that accepts browser-posted violation JSON.
- Return correct CSP report status codes (202 accepted, 400 bad request, 500 error) to reporting user agents.
- Search across document URI, referrer, blocked URI and effective directive to find a specific violation.
- Filter aggregated violations by a minimum or maximum occurrence count to focus on noisy directives.
- Point any external or non-CSP-module policy at `/log-report-uri/enforce` or `/log-report-uri/report-only` manually.
- Restrict who can read CSP reports with the dedicated `access csp_log reports` permission.
- Query stored CSP violations programmatically through the `csp_log` service (`fetchLogs`, `aggregateLogs`).
- Insert CSP report rows from custom code via `CspLogService::insertLog()`.
- Bulk-delete logs by type and date range from custom code with `CspLogService::removeLogs()`.
- Keep the full raw CSP report JSON for each violation for later inspection.
- Log CSP violations from a decoupled/front-end app by POSTing report JSON to the endpoint.
- Audit which pages (document URIs) trigger the most CSP violations.
- Diagnose CSP breakage after a deployment by watching new violations appear in the dedicated log.
- Separate CSP report noise from real application errors for cleaner monitoring/alerting.
- Provide site builders a report UI under the standard Reports menu without extra configuration.
