# CKEditor Plugin Report — agent index

A single read-only admin report listing every CKEditor 5 plugin (ID, Provider, Class). No
config form, no `configure` route, no config schema, no services/plugins/Drush of its own.
Its only surface is one route + one permission.

- **The report route, the permission that gates it, the columns, and how it enumerates
  plugins** → [permissions/access.md](permissions/access.md)

Key facts:
- Route `ckeditor_plugin_report.plugin_report` → `/admin/reports/ckeditor-plugins`
  (under the Reports menu `system.admin_reports`).
- Permission: `view ckeditor plugin report` (`restrict access: true`).
- Controller `PluginReportController::content` reads `plugin.manager.ckeditor5.plugin`
  (`NULL_ON_INVALID_REFERENCE`) and tabulates `getDefinitions()` → Plugin ID / Provider / Class.
