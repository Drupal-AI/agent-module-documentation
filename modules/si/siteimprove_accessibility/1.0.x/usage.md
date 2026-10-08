<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Integrates Siteimprove's open-source Alfa accessibility engine to scan pages for WCAG 2.1 AA issues, persist the results as entities, and report compliance over time.

---

The module runs Alfa (client-side) against rendered pages and posts the findings back to Drupal, where they are stored as custom content entities: `alfa_scan` (a scan of a page), `occurrence` (an individual issue occurrence), and `daily_stats` (aggregated conformance numbers). A node-form integration lets editors preview/auto-scan a node and see its dashboard inline, while a cron job (`DailyStatsAggregationCron`) rolls scans up into daily statistics. Rule metadata is modelled as a `siteimprove_accessibility_rules` taxonomy with a conformance field. REST resources expose the stored data (scans, issues, pages-with-issues, daily stats, save-scan) for the front-end and external reporting.

Admin/reporting routes provide a compliance-history dashboard and an issue-reporting view under `/admin/reports/siteimprove_accessibility`, plus an Alfa Scan collection view at `/admin/content/alfa-scan`. All of these are gated by module permissions: `run siteimprove_accessibility scan` (run scans / view reports), `administer siteimprove_accessibility configuration` (settings), and `delete siteimprove_accessibility scan` (deletion) — the latter two flagged `restrict access`. The REST `save-scan` POST resource uses cookie authentication (so Drupal's CSRF token applies) and the standard per-resource REST permission; the entity access handler grants scan entities only to holders of those permissions.

Setup: enable the module (requires core `rest` and `language`), grant the scan/admin permissions to the right roles, configure the checker at `/admin/config/siteimprove_accessibility/settings`, and enable the REST resources. Editors then scan nodes from the node form and review results in the reporting dashboards.

---

- Scan a node's rendered page for accessibility issues with Alfa
- Check pages against WCAG 2.1 AA conformance
- Store each scan as an `alfa_scan` entity
- Record individual issue occurrences per page
- Aggregate daily accessibility statistics via cron
- View a compliance-history dashboard over time
- View an issue-reporting breakdown of current problems
- Browse all scans in the Alfa Scan collection view
- Preview and auto-scan a node from its edit form
- Expose scan data through REST resources for a front-end app
- POST scan results back via the `save-scan` REST resource
- Query pages-with-issues through a dedicated REST resource
- Retrieve daily stats through the daily-stats REST resource
- Fetch a node's scan via the alfa-scan-by-node resource
- Restrict who can run scans with a dedicated permission
- Restrict configuration to trusted admins (`restrict access`)
- Grant scan deletion separately from scan running
- Model accessibility rules as a taxonomy with conformance metadata
- Configure the checker at the settings route
- Bulk-delete scans/occurrences via provided system actions
- Track accessibility trend and regressions across the site
- Surface accessibility status to editors during content creation
