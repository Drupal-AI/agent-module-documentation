<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SendGrid Integration Simplenews Reports adds a per-node statistics tab that pulls SendGrid email metrics for a Simplenews newsletter issue and shows charts, a summary table, and a CSV export.
---
The route `node/{node}/sendgrid-statistics` renders opens/clicks/delivered/spam and related metrics for the newsletter. It delegates all SendGrid API access to the parent `sendgrid_integration_reports.api` service — this module holds no API key and makes no direct HTTP call, so credential storage and TLS are the parent module's responsibility. `SendGridSimplenewsReportsService::getNewsletterStatistics()` queries stats scoped to the SendGrid category `node_{nid}`; a date-range form lets the user pick a window (defaults from the node's created date to today).

Access is doubly gated: the route requires the `access sendgrid simplenews report` permission **and** a custom access check (`checkNodeAccess`) that only allows nodes which have the `simplenews_issue` field, returning forbidden otherwise. CSV export escapes each cell (quotes doubled, fields with comma/quote/newline wrapped). The report is an `_admin_route`. (Minor code smell: the service `use`s `Drupal\shs\StringTranslationTrait` — an unusual namespace — but this does not affect access.)

Typical setup: ensure sendgrid_integration(+reports) and simplenews are configured, grant `access sendgrid simplenews report`, then open the "SendGrid statistics" tab on a newsletter node.
---
- View SendGrid open/click/delivery stats for a newsletter.
- See spam-report metrics per issue.
- Filter statistics by a custom date range.
- Export newsletter statistics as CSV.
- Render sending-volume and spam charts.
- Show a totals summary table.
- Scope metrics to a single node via the `node_{nid}` category.
- Gate report access with a permission.
- Limit reports to actual Simplenews issue nodes.
- Link editors to the SendGrid dashboard for detail.
- Compare issue performance across date ranges.
- Download stats for offline analysis.
- Restrict reports to newsletter (issue) nodes only.
- Gate access with a dedicated permission.
- Link editors through to the SendGrid dashboard.
- Render charts with the reports library.
