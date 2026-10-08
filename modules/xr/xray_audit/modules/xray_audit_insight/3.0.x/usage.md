Xray Audit Insights is a submodule of Xray Audit that turns selected audit results into **warnings on Drupal's Status Report** (`admin/reports/status`), so problems like excessive revisions, oversized database tables or disabled caching surface where admins already look.

---

The submodule defines a third plugin type — `xray_audit_insight` (annotation `@XrayAuditInsightPlugin`, manager `plugin_manager.xray_audit_insight`, discovery dir `Plugin/insights`). Each *insight* plugin references a parent Xray Audit **task plugin + operation**, evaluates its data against a threshold, and via `hook_requirements('runtime')` (`xray_audit_insight_requirements`) emits a Status-Report entry — `REQUIREMENT_WARNING` with a link to the relevant report, or an OK/neutral state. Shipped insights: `nodes_with_excessive_revisions`, `paragraphs_with_excessive_revisions`, `suspicious_database_table_size`, `internal_page_cache` (page cache off), `views` (views not cached), `bundle_not_used` (entity bundles with no content), and `modules_not_enabled`. A settings form (route `xray_audit_insight.settings_form` at `/admin/config/xray_audit_insight/settings`, gated by core `administer site configuration`) lets you exclude individual insights and views and set the revision/table thresholds it reads (`xray_audit_insight.settings`: `excluded_insights`, `excluded_views`, `node_revision_count`, `paragraph_revision_count`, `table_size_threshold`). It adds no permissions or Drush of its own and depends on `xray_audit` + core `node`.

---

- Get a Status-Report warning when nodes exceed a configured revision count.
- Get a Status-Report warning when paragraphs exceed a configured revision count.
- Flag database tables larger than a configured size threshold.
- Warn when Internal Page Cache is disabled.
- Warn when Views are not cached.
- Highlight entity bundles that have no content (unused bundles).
- Surface modules that are present but not enabled.
- Centralize audit findings on `admin/reports/status` instead of browsing each report.
- Exclude specific insights you don't care about from the Status Report.
- Exclude specific views from the "views not cached" check.
- Tune node/paragraph revision thresholds that drive the warnings.
- Tune the maximum table-size threshold (MB).
- Give ops/monitoring a single glance at site-health audit signals.
- Link straight from a warning to the detailed Xray Audit report for the issue.
- Add a custom insight plugin that raises a warning from any Xray Audit task operation.
