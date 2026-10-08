# Config Devel — agent index

Developer tool that syncs Drupal config between YAML files and active storage, and exports a
module's owned config into its `config/install` directory (Features-style). Dev-only; do not
deploy to production. Configure route: `config_devel.settings`
(`/admin/config/development/config_devel`). Depends on core `config`. No plugins, no own
permissions (settings form is gated by the core `import configuration` permission).

- **Auto-import / auto-export settings — the `config_devel.settings` object and its keys** →
  [configure/settings.md](configure/settings.md)
- **Drush commands (`cde` / `cdi` / `cdi1`) and the `config_devel:` info.yml section** →
  [drush/commands.md](drush/commands.md)
- **The `ConfigImporterExporter` service + auto import/export event subscribers** →
  [api/service.md](api/service.md)

Key facts:
- Settings live in `config_devel.settings` → `auto_import` (list of `{filename, hash}`) and
  `auto_export` (list of config object names). Baseline: both empty.
- Auto-import paths are **relative to the Drupal root**; auto-export names are config object
  names (e.g. `system.site`). `system.site`, `core.extension`, `simpletest.settings` are
  rejected for auto-import.
- Drush: `config:devel-export` (cde), `config:devel-import` (cdi), `config:devel-import-one`
  (cdi1). Export/import operate on a module's `config_devel:` info section.
