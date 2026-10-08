<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Real-time Performance Monitor watches SQL execution time, duplicate queries, slow/"bad" PHP functions and frontend page-load metrics, then raises alerts through watchdog, email and Slack with per-URL frequency throttling.

---

Backend monitoring runs via `PerformanceMonitorSubscriber`, comparing measured timings against configurable thresholds (query time, duplicate-query count, PHP execution time). A frontend library posts browser timing telemetry (load time, TTFB, FCP, CSS coverage, payload sizes) to `/api/real-time-performance-monitor/telemetry`, whose handler formats an HTML alert and dispatches it to the enabled channels, throttled per URL (always/daily/weekly/2-weeks/monthly). All settings — master kill switch, path exclusions, thresholds and notification channels/webhook — live at `/admin/config/development/real-time-performance-monitor` (permission `administer site configuration`).

Note the telemetry route is declared `_access: 'TRUE'` (anonymous) so the browser client can post without a session; its JSON payload fields (notably `url`, `browser`, `version`, `os`) are interpolated into the HTML alert body that is written to the dblog watchdog and emailed/Slacked to administrators. Treat the resulting log/alert as untrusted, browser-supplied content.

Set up by enabling the module, choosing which layers to monitor, setting thresholds, and configuring email recipients and/or a Slack webhook with per-channel frequency caps.

---
- Monitor SQL query execution time against a threshold.
- Detect duplicate queries above a configurable count.
- Flag slow or bad PHP function execution.
- Capture frontend page-load, TTFB and FCP metrics.
- Report CSS coverage and JS/CSS payload sizes.
- Send performance alerts to watchdog (dblog).
- Email performance alerts to a recipient list.
- Post performance alerts to a Slack webhook.
- Throttle alerts per URL (daily/weekly/monthly, etc.).
- Exclude paths from monitoring with wildcards.
- Use the master switch to disable all monitoring instantly.
- Disable individual layers (DB / backend / frontend).
- Set a page-load time limit for frontend alerts.
- Tune query-time and duplicate-query limits.
- Identify the primary culprit in a duplicate-query storm.
- Review slow-query and execution reports via templates.
- Configure independent frequency caps per channel.
- Point developers to Chrome DevTools coverage steps.
- Keep alerts off admin/dev paths.
- Collect anonymous browser telemetry for real-user monitoring.
