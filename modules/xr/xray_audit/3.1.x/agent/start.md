# Xray Audit — agent index

Read-only **site audit reports** (content model, entity architecture, metrics, displays, views,
modules/themes, database, navigation, access) at `/admin/reports/xray-audit`, exportable to
CSV/ZIP. Built on two plugin types (group + task). Depends on core `node` + `views`. Config UI
for thresholds lives at `/admin/config/development/xray_audit/settings` (`configure` in info.yml
is null; the settings route is `xray_audit.settings`).

- **Settings form (revision/table thresholds), the views_report config, cache bin/rebuild** →
  [configure/settings.md](configure/settings.md)
- **The two plugin types (`xray_audit_group`, `xray_audit_task`): add a report / operation** →
  [plugins/plugins.md](plugins/plugins.md)
- **Drush commands (node/paragraph usage counts & placement)** →
  [drush/commands.md](drush/commands.md)
- **Permissions and the routes/access they gate** →
  [permissions/permissions.md](permissions/permissions.md)
- **Key services to call programmatically (PluginRepository, EntityArchitecture, EntityUse*, CSV)** →
  [api/services.md](api/services.md)

Submodule (own docs):
- `xray_audit_insight` → [../../modules/xray_audit_insight/3.1.x/agent/start.md](../../modules/xray_audit_insight/3.1.x/agent/start.md)

Key facts:
- Report pages: `xray_audit.home` (`/admin/reports/xray-audit`), `xray_audit.group`
  (`/admin/reports/xray-audit/{group_id}`); per-operation routes are generated dynamically by
  `Routing/RouteSubscriber` + `hook_local_tasks_alter`.
- Plugin managers: `plugin_manager.xray_audit_group` (dir `Plugin/xray_audit/groups`, attribute
  `#[XrayAuditGroupPlugin]`) and `plugin_manager.xray_audit_task` (dir `Plugin/xray_audit/tasks`,
  attribute `#[XrayAuditTaskPlugin]`). Both also support the legacy `@XrayAudit*Plugin` annotation,
  which the shipped core group/task plugins still use.
- Groups: database, package, site_structure, content_model, content_metric, forms,
  content_display, layout, content_access_control.
- Dedicated cache bin `xray_audit` (service `xray_audit.cache_manager`); results are cached.
- Permissions: `xray_audit access`, `xray_audit administer configuration` (both restrict access).
- Core requirement `^11.3`; Composer constraint `drupal/core:^11`.
