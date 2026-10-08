<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SendGrid Simplenews Reports — route & data flow

## Route
`node/{node}/sendgrid-statistics` (`SendGridSimplenewsReportsController::getNodeReports`).
Access = `_permission: access sendgrid simplenews report` **AND** `_custom_access: checkNodeAccess`, which returns `AccessResult::allowed()` only when the node has field `simplenews_issue`, else `forbidden()`. `_admin_route: TRUE`.

Query params: `start_date`, `end_date` (YYYY-MM-DD), `format=csv` for export.

## Data
`SendGridSimplenewsReportsService::getNewsletterStatistics($nid,$start,$end)` calls
`sendgrid_integration_reports.api::getStats('simplenews_sendgrid_stat_'.$nid, ['node_'.$nid], $start, $end, TRUE)`.
Default date range: node created date → today (`getDateRangeFromRequest`).

Metrics (`getMetricDefinitions`): opens, processed, requests, clicks, delivered, deferred, unsubscribes, unsubscribe_drops, invalid_emails, bounces, bounce_drops, unique_clicks, blocks, spam_report_drops, spam_reports, unique_opens.

## Output
- Charts via `sendgrid_integration_reports/googlejsapi` + `/main` libraries and `drupalSettings`.
- Summary table + totals.
- CSV export: `generateCsvContent` → `csvEscapeRow` (doubles `"`, wraps fields containing `, " \n \r`).

## Notes
- No credentials or outbound HTTP live in this module; audit `sendgrid_integration` for key storage / TLS.
