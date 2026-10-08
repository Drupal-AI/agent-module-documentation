<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Config Import (project confi, machine name config_import) is a programmatic developer tool for importing, exporting, and patching a named subset of Drupal configuration, rather than running core's all-or-nothing `config:import`. It has no UI — you call its services from update hooks and deploy scripts.

---

Core configuration management is deliberately whole-site: `drush config:import` applies the entire sync directory as one transaction, which is safe but blunt. During project development you often want to apply just *this* set of config objects — the roles you changed, one view, a single field — without disturbing everything else and without hand-editing the sync directory. Confi provides that. The `config_import.importer` service imports or exports only the config names you list: `importConfigs()` takes a full snapshot of active config, overlays your named `.yml` files, then uses core's own `StorageComparer` and `ConfigImporter` to apply only the resulting diff, so unrelated divergences neither block the import nor get pulled in. `exportConfigs()` writes named active objects back out to files. A second service, `config_import.param_updater`, copies a single nested property from a YAML file into an existing active config object when you want to patch one value rather than replace the whole object. A `hook_config_import_configs_alter` denylist lets a site protect specific config names from ever being imported.

The intended workflow is inside `hook_update_N()`: point the importer at a config directory with `setDirectory()` (it defaults to the site's `config_sync_directory`), list the config names to bring in, and ship it as part of a deployment. Because config import can change permissions, roles, fields and access rules, treat every import as a deliberate, reviewed deployment step, and remember that naming a config whose file is missing deletes that config from the site. Version 4.2.0 ships no UI, routes, permissions, or Drush commands — despite older README text, this release is API-only.

---

- Import a specific subset of config in a `hook_update_N()`.
- Update one config object without a full sync import.
- Apply a changed view, role, or field during deployment.
- Avoid core's all-or-nothing `config:import`.
- Import config despite an unrelated divergence in the sync directory.
- Export selected active config objects to files.
- Patch a single nested property in a config object from a file.
- Update a view's pager or a filter format field programmatically.
- Ship config changes as part of a module's update path.
- Point imports at a directory outside the webroot with `setDirectory()`.
- Protect certain config objects from import with a denylist hook.
- Smooth a config deployment in CI.
- Remove a config object by importing its (missing) name.
- Reduce config-import friction during active development.
- Reapply a module's default config after editing it.
- Bring in `core.extension` or specific settings selectively.
- Keep unrelated local config untouched during an import.
- Drive granular imports from a deploy script.
- Restore one property to a known value from install config.
- Sync a handful of config objects between environments.
- Treat config imports as deliberate, reviewed steps.
- Avoid hand-editing the sync directory for partial changes.
- Update multiple features' config across an update hook chain.
- Log config-property updates to the `config_update` channel.
- Import config from a custom staging directory.
