<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Siteimprove Accessibility — REST & data model

## Entities
- `alfa_scan` — one accessibility scan of a page (access via `AlfaScanAccessControlHandler`).
- `occurrence` — a single issue occurrence found in a scan.
- `daily_stats` — aggregated conformance counts per day (built by `DailyStatsAggregationCron` + `DailyStatsProcessor`).
- Taxonomy `siteimprove_accessibility_rules` — rule metadata with a `field_si_conformance` conformance field.

## REST resources (config/install/rest.resource.*)
- `siteimprove_accessibility_alfa_scan_resource` — `POST /siteimprove-accessibility/save-scan`; `granularity: method`, `supported_formats: json`, `supported_auth: cookie`. Client posts Alfa results back.
- `siteimprove_accessibility_issues_resource` — read issues.
- `siteimprove_accessibility_pages_with_issues_resource` — pages that currently have issues.
- `siteimprove_accessibility_daily_stats_resource` — daily conformance stats.
- `siteimprove_accessibility_alfa_scan_by_node_resource` — a node's latest scan.

Each resource requires the standard per-resource REST permission (e.g. `restful post siteimprove_accessibility_alfa_scan_resource`) plus, for cookie auth, a valid `X-CSRF-Token`. Enable resources and grant permissions before the front-end can read/write.

## Permissions
- `run siteimprove_accessibility scan` — run scans, view reports, create scan entities.
- `administer siteimprove_accessibility configuration` — settings form (`restrict access`).
- `delete siteimprove_accessibility scan` — delete scans (`restrict access`).

## Repositories / services
`siteimprove_accessibility.alfa_scan_repository`, `.occurrence_repository`, `.daily_stats_repository`, `.daily_stats_processor`, `.daily_stats_aggregation_cron`, `.alfa_scan_preprocess` — query/aggregate the stored scan data.
