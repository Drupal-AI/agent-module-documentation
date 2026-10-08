# Xray Audit Insights — agent index

Submodule of **xray_audit**. Turns selected Xray Audit report results into **warnings on the
Drupal Status Report** (`admin/reports/status`) via `hook_requirements('runtime')`. Adds a third
plugin type (`xray_audit_insight`) and a settings form. Depends on `xray_audit` + core `node`.
No permissions or Drush of its own.

- **Settings form (exclude insights/views, thresholds) + the config keys** →
  [configure/settings.md](configure/settings.md)
- **The `xray_audit_insight` plugin type: add a Status-Report insight from a task operation** →
  [plugins/plugins.md](plugins/plugins.md)

Key facts:
- `xray_audit_insight_requirements()` iterates all insight plugins; for each `isActive()` one it
  merges `getInsightsForDrupalReport()` into the Status Report.
- Manager `plugin_manager.xray_audit_insight`, dir `Plugin/insights`, annotation
  `@XrayAuditInsightPlugin`, base `XrayAuditInsightPluginBase`.
- Shipped insight ids: `nodes_with_excessive_revisions`, `paragraphs_with_excessive_revisions`,
  `suspicious_database_table_size`, `internal_page_cache`, `views`, `bundle_not_used`,
  `modules_not_enabled`.
- Config `xray_audit_insight.settings`; settings route `xray_audit_insight.settings_form`
  (`/admin/config/xray_audit_insight/settings`, permission `administer site configuration`).
- Parent module docs: [../../../../3.0.x/agent/start.md](../../../../3.0.x/agent/start.md).
