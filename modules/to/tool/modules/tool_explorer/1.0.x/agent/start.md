# Tool Explorer — agent index

Admin UI to browse, inspect, and execute Tool plugins. Depends on `tool`. No permissions/config/Drush
of its own — reuses the parent's `administer tool` permission.

- **Routes, the browse/view/execute pages, and the config-schema helper** →
  [configure/explorer.md](configure/explorer.md)

Key facts:
- Menu link under *Configuration → Development*; base path `/admin/config/tool/explorer`.
- Routes (all `_permission: administer tool`): `tool_explorer.list`, `tool_explorer.view/{plugin_id}`,
  `tool_explorer.execute/{plugin_id}` (`ToolExecuteForm`).
- View page flags whether a `tool.plugin.<id>` config schema exists in the provider module and
  suggests one (built from the Tool typed-data adapters) when missing.
- Execute form runs the tool but intentionally does **not** print raw outputs (field-level access
  precaution, per a source `@todo`).
