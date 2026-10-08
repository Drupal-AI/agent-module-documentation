Configuration Selector lets a module or install profile ship several alternative versions of the *same* optional configuration (e.g. four variants of a View) and automatically enable the right one based on which other modules are installed, choosing between competing variants by a priority number.

---

A configuration entity opts in by adding `third_party_settings.config_selector.feature` (a shared feature name) and `.priority` (an integer) plus `config_selector` in its module dependencies. All variants that share a feature name compete; whenever a module is installed or uninstalled the module recalculates, keeps the single highest-priority variant that is currently enabled, and disables the rest. Because it only ever *disables* configuration (never deletes), no user customizations are lost and the operation is reversible. It works through `hook_module_preinstall`/`modules_installed` and the uninstall equivalents (reordered via `hook_module_implements_alter` so its bookkeeping runs first/last), with the heavy lifting in the `config_selector` service (`ConfigSelector`). Config schema for the third-party settings ships for core Views (`views.view.*`) and Blocks (`block.block.*`) out of the box; other config entity types need their own `config_selector_third_party` schema addition and must be *disable-able* (many config entities cannot be disabled and are unsupported). A `config_selector_feature` config entity and an admin list at `/admin/structure/config_selector` exist (gated by `administer site configuration`), but the add/edit/delete/switch forms are largely stubbed — the module is intended for developers editing YAML, not a click-driven UI. There are no Drush commands and no module-defined permissions.

---

- Ship four variants of a listing View that integrate with search_api, content_lock, both, or neither, and auto-select based on which are installed.
- Provide a "basic" and an "enhanced" version of a block and let the enhanced one win when its supporting module is present.
- Bundle alternative default configuration in a distribution/install profile and pick the correct one at install time.
- Enable a richer configuration automatically when an optional dependency is installed later.
- Fall back to a simpler configuration automatically when an optional module is uninstalled.
- Keep customized-but-disabled configuration around instead of deleting it, so re-enabling a dependency restores the tuned variant.
- Group any number of competing config variants under one feature name so exactly one stays active.
- Order competing variants deterministically with an explicit integer `priority`.
- Add `config_selector` third-party schema to a custom config entity type so it too can participate.
- Coordinate config selection across multiple modules installed in a single operation.
- Provide "with X integration" vs "without X integration" views without shipping conflicting always-on config.
- Avoid manual post-install enable/disable steps in setup documentation.
- Let site builders review which variant is active for a feature at `/admin/structure/config_selector`.
- Guarantee non-destructive switching between configuration sets (nothing is ever deleted).
- Model feature flags where a "feature" is represented by a set of alternative config entities.
- Use the `config_selector` service programmatically to react to install/uninstall config changes.
- Support Views and Blocks feature variants with zero extra schema work.
- Give an install profile a way to seed environment-appropriate default config.
- Log/notify site admins (status messages) when a variant is enabled or disabled in favor of another.
- Prevent two competing optional configs from both being active at once.
- Migrate a site from one config variant to another simply by installing/uninstalling the driving module.
