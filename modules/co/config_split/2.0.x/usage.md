Config Split splits a site's configuration into separate, independently importable/exportable sets so different environments (dev, staging, prod) or optional features can carry different configuration from the same shared sync directory.

---

Drupal's core configuration management assumes one flat sync directory that must be identical across every environment, which makes it awkward to have, say, developer modules enabled only on local and disabled on production. Config Split solves this by defining **Configuration Split** config entities that each describe a subset of configuration — chosen by module, by theme, or by explicit config-name lists ("complete" or "partial" splits) — and a storage location (a folder or a named storage) to hold it. When a split is active, that subset is filtered out of the main export and written to the split's own directory; on import the split's config is merged back in. Splits can be toggled per environment via the split's `status`, environment-specific `settings.php` overrides, or a runtime status override stored in state. It hooks into the normal `drush config:export`/`config:import` workflow through an event subscriber and also provides its own activate/deactivate/import/export operations. Complete splits remove config entirely from the main sync (ideal for dev-only modules), while partial splits keep a base version in the main sync and store only the per-environment differences as a patch. The module ships a config-entity admin UI, Drush commands, a diff viewer, and a permission to administer splits. It is a cornerstone of professional Drupal deployment workflows.

---

- Enable developer modules (devel, stage_file_proxy, webprofiler) on local/dev only and keep them off production.
- Keep production-only modules (caching, security, mail providers) out of the dev environment.
- Maintain different configuration values (API keys, flags) per environment via separate splits.
- Store all dev-only configuration in a `config/dev` split folder outside the shared sync directory.
- Split out an optional site feature so it can be deployed selectively.
- Deploy the same codebase to multiple sites/environments with per-environment config differences.
- Exclude large or environment-specific config (search indexes, shield settings) from the main export.
- Activate a split conditionally in `settings.php` based on an environment variable.
- Toggle a split on/off at runtime with the status override without editing the entity.
- Use a "complete" split to fully remove config from the main sync (module gets uninstalled on other envs).
- Use a "partial" split to keep base config in sync but override only certain values per environment.
- Layer stackable splits so multiple splits can contribute config together.
- Export a single split's configuration with `drush config-split:export <name>`.
- Import a single split's configuration with `drush config-split:import <name>`.
- Activate a split into active storage with `drush config-split:activate`.
- Deactivate a split, removing its config from active storage, with `drush config-split:deactivate`.
- Review what a split will change before importing using the built-in diff viewer.
- Manage secrets/keys separately per environment without committing them to the main config.
- Split configuration by module so all of a module's config moves together automatically.
- Split configuration by theme to vary theme settings between environments.
- Build a "local overrides" split for individual developers' personal settings.
- Coordinate config across a multisite install where each site needs a slightly different set.
- Gate access to split administration behind the `administer configuration split` permission.
- Integrate splits transparently into an existing `drush config:import`/`config:export` CI pipeline.
- Migrate a legacy Config Split 1.x setup to the 2.x storage/patch model.
- Keep third-party integration credentials in an environment-specific split folder.
