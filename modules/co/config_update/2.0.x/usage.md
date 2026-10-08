Configuration Update Base is an API-only module that computes differences between a site's active configuration and the default configuration shipped by modules, themes, and install profiles, and can revert or re-import those items. It provides no end-user UI itself — it is the engine used by the Configuration Update Reports submodule and by other projects such as Features.

---

Drupal core can import a full configuration set, but it has no built-in way to compare a single config item against the default version a module or theme originally provided, nor to revert just that item. Configuration Update Base fills that gap with three injectable services: a **config lister** (`config_update.config_list`) that enumerates config types and tells you which extension provides each item, a **config differ** (`config_update.config_diff`) that normalizes and diffs two config arrays, and a **config reverter** (`config_update.config_update`) that reads values from a module/theme/profile's `config/install` and `config/optional` (extension) storage and writes them back into active storage. The reverter distinguishes *import* (bring in a config item that is currently missing) from *revert* (overwrite an existing active item with the shipped default), and it dispatches `pre_import`/`import` and `pre_revert`/`revert` events so other code can react to or alter the operation. Everything works on base configuration only — without `settings.php` overrides or translations. Because it is dependency-light (only core's Configuration Manager) it is safe to depend on from contrib. The companion `config_update_ui` submodule and the Features module build user-facing reports and revert buttons on top of these services.

---

- Compare a single config item's active value against the default the providing module ships.
- Revert a changed config item back to its module/theme/profile default in code.
- Import a config item that a module provides but that is missing from active storage.
- List every configuration type available on the site (`listTypes`).
- Find which extension (module/theme/profile) provides a given config item.
- Detect config items a site has added that no extension provides.
- Detect config items that are "inactive" — provided but not yet installed.
- Build a "what changed after I updated this module" report programmatically.
- Normalize two config arrays and test whether they are effectively identical (`same`).
- Produce a human-readable diff between two configuration versions (`diff`).
- Read a config value directly from a module's `config/install` extension storage.
- Read a config value from `config/optional` extension storage.
- React to config reverts by subscribing to the `config_update.revert` event.
- Alter the value about to be written during a revert via the pre-revert event.
- Power the Features module's "revert to default" and diff functionality.
- Give a custom admin module the ability to reset selected config to defaults.
- Restore an accidentally edited View or Block to its shipped default.
- Re-import new default configuration added by a module update.
- Audit config drift between deployed environments and shipped defaults.
- Provide the backend for a deployment tool that flags customized configuration.
- Enumerate config items grouped by the module that provides them.
- Determine the config type (entity type or `system.simple`) for any config name.
- Look up a config type by its config name prefix.
- Build tooling that exports site-added configuration for version control.
- Roll back configuration changes without a full `config:import` of the whole site.
