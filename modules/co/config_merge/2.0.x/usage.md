<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Config Merge provides a three-way merge for configuration items so that an incoming configuration update (e.g. a new version shipped by a module or distribution) can be applied while keeping any local customizations the site made to the same item.

---

At its core is one stateless helper class, `Drupal\config_merge\ConfigMerger`, whose static `mergeConfigItemStates($previous, $current, $active)` performs a git-style three-way merge of three states of a config item: `previous` (the last snapshot the extension provided), `current` (the new version the extension now provides), and `active` (what is in the site's active storage, possibly customized). For associative arrays it detects additions, removals and changes, recursing into nested arrays; it applies an incoming change only when the active value still equals the previous value (unchanged/uncustomized), otherwise it keeps the active (customized) value. For indexed (non-associative) arrays it can't reliably diff elements, so it substitutes the new value only when the active value is unchanged, else keeps the active value. Every decision is recorded in a static log retrievable via `ConfigMerger::getLogs()`, keyed by operation: `update` (change merged in), `ignore` (customization retained), and `substitute` (indexed array replaced). The module also defines an event, `ConfigMergeEvents::POST_MERGE` with `ConfigMergeEvent` (carrying config name, logs, provider type/name), for consumers to dispatch/subscribe after a merge. The bundled **config_merge_filter** submodule wires this merger into the Config Filter pipeline so imports merge with active config automatically. The parent module has no config, no UI (`configure: null`), no permissions, and no Drush.

---

- Apply a module's updated default configuration while preserving a site's local edits to that config.
- Merge a distribution's new config version into a customized site without clobbering customizations.
- Perform a git-style three-way merge of a config item from `previous`, `current`, and `active` states.
- Accept an upstream change to a setting the site never customized (operation `update`).
- Retain a site's customized value when upstream also changed it (operation `ignore`).
- Substitute an upstream indexed/list value only when the site hasn't altered it (operation `substitute`).
- Merge nested configuration arrays recursively, deciding per leaf whether to take upstream or keep local.
- Add new keys introduced by an upstream update that don't collide with local additions.
- Remove keys an upstream update deleted, but only where the site left them unchanged.
- Log every merge decision (`getLogs()`) for auditing which properties were updated, ignored, or substituted.
- Report merge results to other modules via the `POST_MERGE` event (config name, logs, provider).
- Power the config_merge_filter Config Filter plugin so config import merges with active storage automatically.
- Integrate with Configuration Synchronizer / Config Sync to safely roll out extension config updates.
- Build a custom update workflow that diffs snapshot vs new vs active and applies a safe merge.
- Decide programmatically whether an incoming config change is safe to apply given local state.
- Preserve editor-tuned view or field settings across a module configuration update.
- Keep site-specific tweaks to a shipped view while adopting new columns/filters from upstream.
- Avoid overwriting customized permissions/roles when re-importing default config.
- Provide predictable, auditable merges instead of blunt overwrite-or-skip config imports.
- Use as a library from an update hook to reconcile config during a deployment.
