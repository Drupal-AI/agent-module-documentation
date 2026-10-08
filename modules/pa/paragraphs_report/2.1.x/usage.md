<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Paragraphs Report builds a catalog of which Paragraph types are used on which nodes, so you can see where each paragraph component appears across your selected content types and export it to CSV.

---

You pick which content types to scan on the settings tab (`/admin/reports/paragraphs-report/settings`), then run "Update Report Data" (or the Drush command) to walk every node of those types, recursively descend into nested paragraph fields, and record, per paragraph type, which nodes (and which parent paragraph/node) it appears on. The result is stored in the key-value collection `paragraph_report.report_data` (key `data`) — not in config — and rendered as a paginated, filterable table at `/admin/reports/paragraphs-report` (route `paragraphs_report.report`, which is also the module's `configure` route), with a CSV export at `/admin/reports/paragraphs-report/export`. Settings live in the `paragraphs_report.settings` config object: `content_types` (which node types to report on), `hide_paras` (paragraph types to hide from the filter), `import_rows_per_batch` (nodes per batch, default 10), and `watch_content` (a boolean; when on, node insert/update/delete hooks keep the report current automatically). It defines three permissions (`administer paragraphs_report configuration`, `access paragraphs report`, `update report data`), a Drush command `paragraphs_report:update` (alias `pru`), and the `paragraphs_report.report` service that holds all the logic. Requires the Paragraphs module and `path_alias`. Only the latest revision of each node is considered.

---

- Find every page where a specific paragraph type (e.g. "Hero" or "Accordion") is used.
- Audit which of your paragraph components are actually in use versus unused.
- Produce a CSV inventory of paragraph usage for a content audit or migration planning.
- Limit the report to specific content types via the `content_types` setting.
- Keep the report continuously up to date by enabling `watch_content` (updates on node save/delete).
- Refresh the report on demand with the "Update Report Data" button on the report page.
- Refresh the report from the CLI/cron with `drush paragraphs_report:update` (alias `drush pru`).
- Tune batch size for sites with many paragraphs per node via `import_rows_per_batch`.
- Hide noisy or irrelevant paragraph types from the report filter with `hide_paras`.
- Filter the on-screen report by paragraph type or by parent type (node vs paragraph).
- See counts of how many times each paragraph type appears.
- Identify pages that still use a deprecated paragraph type before removing it.
- Plan a redesign by seeing which components are widely used vs rarely used.
- Give editors/QA a link to the paginated report of component usage.
- Export usage data to feed a spreadsheet or external analysis.
- Restrict who can view/export the report with the `access paragraphs report` permission.
- Restrict who can trigger a data rebuild with the `update report data` permission.
- Restrict who can change the report settings with `administer paragraphs_report configuration`.
- Detect nested/sub-paragraph usage since the scan recurses into paragraph-in-paragraph fields.
- Store report settings as exportable config (`paragraphs_report.settings`) for deployment.
- Trace which node a given paragraph instance ultimately belongs to via the report's Path column.
