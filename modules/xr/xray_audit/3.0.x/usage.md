Xray Audit generates read-only reports about how a Drupal site is built — content model / entity architecture, content metrics, display modes, views, modules/themes, database size, navigation and access — under *Reports → Xray Audit Reports*, exportable to CSV/ZIP. It is a developer/analyst/admin inspection tool, not a runtime feature.

---

The module is organized around two plugin types: **group** plugins (`XrayAuditGroupPlugin`, one per report category — database, package, site_structure, content_model, content_metric, forms, content_display, layout, content_access_control) and **task** plugins (`XrayAuditTaskPlugin`), each task defining one or more *operations* that compute a data table and render it. A `PluginRepository` service discovers, caches (dedicated `xray_audit` cache bin via `CacheManager`) and instantiates them; controllers (`XrayAuditHomeController`, `XrayAuditGroupsController`, `XrayAuditTaskController`) build the report pages at `/admin/reports/xray-audit[/{group}]`, and a `RouteSubscriber` plus `local_tasks_alter` generate per-operation routes/tabs dynamically from the task definitions. Every report can be downloaded as CSV (per operation, via `XrayAuditTaskCsvDownloadTrait` + `CsvDownloadManager`) and there is a batch "Download all reports as CSV" that zips them (`XrayAuditBatchHelper`, streamed by `downloadGeneratedZipFile`). Rich services back the heavier reports: `EntityArchitecture` / `EntityDisplayArchitecture` (fields, bundles, displays), `ParagraphUsageMap` + `EntityUseParagraph`/`EntityUseNode` (where node/paragraph bundles are used), and `NavigationArchitecture` (menu trees). A settings form (`/admin/config/development/xray_audit/settings`) stores revision and table-size thresholds used to flag "excessive" values. Access is gated by two permissions — `xray_audit access` (view reports) and `xray_audit administer configuration` (settings) — both marked `restrict access: true`. Three Drush commands expose node/paragraph usage counts and placement. The optional **xray_audit_insight** submodule turns selected report results into warnings on Drupal's Status Report (`hook_requirements`).

---

- See a full inventory of content entity types and bundles, their fields and field data types (entity architecture report).
- Audit how entities are displayed: view-mode/display configurations with sample renderings.
- Count nodes grouped by content type, and by type + language.
- Find nodes (and paragraphs) with the highest number of revisions to spot revision bloat.
- Map which node/paragraph bundles are used and *where* they are referenced (paragraph usage map).
- List taxonomy vocabularies and term counts.
- Inventory media entities and image styles in use.
- Detect duplicate files taking up storage.
- Review database table sizes and flag tables exceeding a configured threshold.
- List installed modules (enabled/disabled) and themes vs synced config (config-split aware).
- Audit Views: which views exist, and which admin views are exposed to anonymous users.
- Inspect block layout placement across the site.
- Review navigation/menu architecture as a tree.
- List user roles and user reports for a quick access-control overview.
- Audit external resources referenced by content displays.
- Report on Webform configuration/usage (Webform group).
- Export any single report as a CSV file for spreadsheets or hand-off.
- Batch-export *all* CSV reports at once and download them as a single ZIP.
- Use Drush `xray_audit:node_count` / `xray_audit:paragraph_count` to script content metrics.
- Use Drush `xray_audit:usage_place --bundles=… --parents=…` to list where a bundle is used.
- Tune "excessive revisions" and "large table" thresholds via the settings form.
- Surface audit findings as Status Report warnings by enabling the xray_audit_insight submodule.
- Give a new developer a fast, deep overview of an unfamiliar site's structure.
- Produce an architecture snapshot for a site-audit / migration-planning deliverable.
- Extend the tool with a custom task plugin to add a new report (see agent/plugins).
