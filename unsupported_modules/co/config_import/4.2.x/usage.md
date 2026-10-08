Config Import (project `confi`, module `config_import`) is a developer helper for importing or exporting a named subset of Drupal configuration programmatically, usually from inside an update hook during deployment.

---

Running a full configuration import during ongoing development is inconvenient and dangerous: it can overwrite or delete config (and content-related config) you did not intend to touch. Config Import solves this by letting you import or export only the specific config objects you list. It provides the `config_import.importer` service (`ConfigImporterService`), which dumps the active config to a temporary storage, overlays just your listed objects from a source directory, and then runs core's real `ConfigImporter` (validation, events, dependency handling) against that overlay — so only the changes you asked for are applied. A second service, `config_import.param_updater` (`ConfigParamUpdaterService`), patches a single nested parameter inside one already-active config object. The module ships no UI, routes, permissions, config schema, plugins, or Drush commands of its own; everything is driven from PHP, most naturally from `hook_update_N()`. Note the project machine name on drupal.org is `confi` while the module machine name, namespace, and services are all `config_import` — install with `composer require drupal/confi`, then `drush en config_import`.

---

- Import a single view definition during a deployment update hook without touching the rest of the site config.
- Import a handful of related config objects (e.g. a field storage, field config, form display, and view display) as one atomic set.
- Reset an admin-editable config object back to the version tracked in a module's `config/install` directory.
- Import `user.role.*` objects to add or update permissions for a role as part of a release.
- Re-sync `core.extension` or another specific object from the sync directory without a full `drush cim`.
- Export selected config objects from the active store to the sync directory (`exportConfigs()`) so a subset can be committed.
- Point the importer at a custom directory outside the webroot (`setDirectory('/var/config')`) to import config from a deployment artifact.
- Import config from a module's own directory using `\Drupal::service('extension.list.module')->getPath('mymodule') . '/config/install'` as the source.
- Ship config changes with a module update instead of relying on the site owner running a manual config import.
- Deliberately delete an active config object by listing it while its source `.yml` file is absent (import removes objects with no source file).
- Protect specific config from ever being imported by implementing `hook_config_import_configs_alter()` to add names to the restricted list.
- Prevent volatile config (e.g. `action.settings`, environment-specific settings) from being overwritten during a selective import via the alter hook.
- Update just one nested key inside a live config object (e.g. `dependencies.module` on `views.view.who_s_online`) with `config_import.param_updater`.
- Backfill a newly added config parameter across environments by reading its value from a shipped YAML file and writing it into active config.
- Automate config resets in CI/deployment pipelines by calling the importer from update hooks run by `drush updb`.
- Avoid clobbering unrelated editor changes by importing only named objects rather than the whole config tree.
- Keep a repeatable, code-reviewed record of exactly which config changed in each release, expressed as update-hook calls.
- Perform a targeted config export in a script to capture the current state of a few objects for debugging or migration.
- Use `getDirectory()` / `setDirectory()` to switch source directories between multiple import batches in one update run.
