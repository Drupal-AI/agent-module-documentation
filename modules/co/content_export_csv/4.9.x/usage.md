<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Content Export CSV adds an admin form that downloads nodes of a chosen content type as a CSV file, with per-field selection, published/unpublished filtering, optional node URLs, and HTML tag stripping.

---

The module is a single-form utility plus one service. The form lives at `/admin/content/content-export` (route `content_export_csv.export`, action link "Export Content" on the content overview, gated by the `access content export` permission). You pick a content type, then AJAX reveals the exportable field list; you select which fields to include, filter by publication status (published/unpublished), optionally append each node's absolute URL as a trailing `url` column, and optionally strip HTML tags from field values. On submit it streams a `content_export<timestamp>.csv` download (written to the private files dir if configured, otherwise public, then deleted after readfile). The heavy lifting is in the `content_export_csv.export` service (class `Drupal\content_export_csv\ContentExport`), whose public methods you can call programmatically: `getContentTypes()`, `getValidFieldList($type)`, `getNodeIds($type, $status)`, `getNodeData($node, …)`, `getNodeDataList($ids, …)`, and `getNodeCsvData($type, $status, $fields, $includeUrls, $stripTags)`. `getValidFieldList()` returns all field machine names for the bundle minus a fixed blocklist of internal fields (`uuid`, `vid`, `revision_*`, `sticky`, `promote`, `comment`, `content_translation_*`). Values are quoted, multi-value fields are joined with `|`, and link/reference fields fall back to `uri`/`target_id`. There is no configuration entity or schema; the info-file `configure` key points at `content_export_csv.data-export`, which does not actually exist — the real form route is `content_export_csv.export`.

---

- Export all Article nodes to a CSV spreadsheet for review in Excel or Google Sheets.
- Download only selected fields (e.g. title + body) of a content type instead of every column.
- Export only published nodes, or only unpublished/draft nodes, of a given type.
- Append each node's absolute URL as a trailing column for link auditing.
- Strip HTML markup from body/text fields so the CSV holds clean plain text.
- Give a content editor role CSV-export access via the `access content export` permission.
- Bulk-extract node data for migration to another system.
- Produce a content inventory of a content type for an audit or SEO review.
- Hand off a spreadsheet of page titles and summaries to a non-Drupal stakeholder.
- Programmatically build CSV rows for a content type with `getNodeCsvData()` in custom code.
- List the exportable field machine names of a bundle with `getValidFieldList()`.
- Retrieve the published (or unpublished) node ids of a type with `getNodeIds()`.
- Convert a single node to a CSV row array with `getNodeData()`.
- Snapshot content before a large edit so you can compare after.
- Export reference/link fields (stored as `target_id`/`uri`) alongside plain-text fields.
- Flatten multi-value fields into a single pipe-delimited cell for reporting.
- Generate a quick data dump of nodes without writing Views or custom export code.
- Feed exported CSV into a data-analysis or reporting pipeline.
- Keep an off-site backup of key content fields in a portable format.
- Compare published vs unpublished counts by exporting each status separately.
- Provide QA with a CSV of all nodes of a type and their URLs to spot-check pages.
- Export content for translation vendors who work from spreadsheets.
- Build a scheduled custom job that calls the export service to write CSV files.
- Restrict who can run exports by only granting the export permission to trusted roles.
