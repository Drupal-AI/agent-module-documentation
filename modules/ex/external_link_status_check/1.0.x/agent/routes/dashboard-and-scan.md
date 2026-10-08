<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes, report dashboard, scan form & CSV export

## Routes & access (`external_link_status_check.routing.yml`)

| Route id | Path | Handler | Requirement |
|---|---|---|---|
| `external_link_status_check.dashboard` | `/admin/reports/external-links` | `DashboardController::build` | `_permission: access site reports` |
| `external_link_status_check.scan_form` | `/admin/config/system/external-link-scan` | `LinkScanForm` | `_permission: administer site configuration` |
| `external_link_status_check.export_csv` | `/admin/reports/external-links/export` | `DashboardController::exportCsv` | `_permission: access administration pages` |

The module defines no permissions of its own — every route reuses a core permission. Menu link
`scan_form_link` (`external_link_status_check.links.menu.yml`) places the scan form under
**Configuration → System**.

## Report dashboard (`src/Controller/DashboardController.php`)

`build(Request $request)` renders the report:

- Reads `?status_filter=` (`all` | `broken` | `success`).
- Computes three counts over `external_links_registry`: total, broken (`status_code <> 200`),
  success (`status_code = 200`) and renders them as summary cards.
- Renders filter links (All / Only Broken / Only 200 OK), action buttons (**Run Scan** → scan form,
  **Export CSV** → export route), and a paged table (10/page via `PagerSelectExtender`) ordered by
  `last_checked DESC`.
- Each row: thumbnail (`#theme => 'image'` from stored `thumbnail`), title + URL (both run through
  `Html::escape()`), a status badge, response time, the source entity (linked via
  `toLink()` when it has a canonical template, else escaped label; `<em>Deleted</em>` if the source
  entity no longer loads), and the formatted `last_checked` date.

Attaches library `external_link_status_check/dashboard` (`css/dashboard.css`). Constructor deps:
`external_link_status_check.manager`, `database`, `date.formatter`, `entity_type.manager`.

## CSV export (`DashboardController::exportCsv`)

Returns a `StreamedResponse` (`text/csv`, `Content-Disposition: attachment; filename=link_report_<date>.csv`).
Streams a header row then one `fputcsv()` row per registry record: URL, Title, Status Code, Load
Time, Entity Type, Entity ID, Source Label, Last Checked. It exports **all** rows (no filter is
applied to the export query).

## Manual scan form (`src/Form/LinkScanForm.php`)

`FormBase`, form id `link_scan_form`. The build has only help text and a **Start Full Scan** submit
button — there are no configurable scan settings (limits/timeouts/entity-type selection are not
exposed; the timeout and skip-list are hard-coded in `ExternalLinkManager`). `submitForm()` calls
`ExternalLinkManager::getEntitiesToScan()` and builds a **Batch API** run whose operation
`processBatchItem()` loads each entity and calls `ExternalLinkManager::scanEntity()`; `batchFinished()`
reports success/errors via the messenger. This Batch path is the dependable way to populate the
registry (it does not use the queue). Being a Form API POST it carries core's CSRF token.

## Storage (`external_link_status_check.install`, `hook_schema`)

Table `external_links_registry`, primary key `id` (serial). Columns: `url` (text), `url_hash`
(varchar 32, **unique key**), `status_code` (small int, default 0), `response_time` (float),
`title` (varchar 255), `description` (text), `thumbnail` (text), `last_checked` (int),
`entity_id` (big int unsigned), `entity_type` (varchar 64). Indexes on `status_code`,
`last_checked`, and (`entity_type`,`entity_id`). `hook_uninstall()` drops the table.
