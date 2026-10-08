<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Siteimprove Accessibility (siteimprove_accessibility) — agent index

**Runs the Siteimprove Alfa engine against pages, stores scans/issues/daily-stats as entities, and reports WCAG 2.1 AA compliance over time.**

- **Version:** 1.0.x
- **Core:** ^10 || ^11 — depends on drupal:rest, drupal:language.
- **Entities:** `alfa_scan`, `occurrence`, `daily_stats`; rules taxonomy `siteimprove_accessibility_rules`.
- **Reporting routes:** `/admin/reports/siteimprove_accessibility` (compliance dashboard + issue reporting via `SiteimproveAccessibilityReportingController`), `/admin/content/alfa-scan` (collection view). Settings: `/admin/config/siteimprove_accessibility/settings`.
- **REST resources:** alfa_scan (`POST /siteimprove-accessibility/save-scan`), issues, pages-with-issues, daily-stats, alfa-scan-by-node.
- **Permissions:** `run siteimprove_accessibility scan`, `administer siteimprove_accessibility configuration` (restrict access), `delete siteimprove_accessibility scan` (restrict access).
- **Cron:** `DailyStatsAggregationCron` rolls scans into daily stats.

**Security:** All admin/reporting routes are permission-gated (`run …scan` / `administer …configuration`). The `save-scan` REST POST is `granularity: method`, `supported_auth: cookie` — so core REST permission + CSRF token apply; no anonymous mutation. `AlfaScanAccessControlHandler` grants scan entities only to admin-permission / `delete …scan` holders. No `_access: 'TRUE'` endpoints, no disabled TLS, no raw SQL observed. Sound access posture.

See [api/rest.md](api/rest.md).