<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Config Merge Filter is a thin bridge that exposes Config Merge's three-way merge as a Config Filter plugin, so that during a configuration import the incoming data is merged with the site's active configuration instead of overwriting local customizations.

---

The submodule ships one plugin, `MergeFilter` (`@ConfigFilter` id `config_merge`, weight 1000, label "Config Merge"), extending `config_filter`'s `ConfigFilterBase`. It is constructed with the active storage (`config.storage`) and the config snapshot storage (`config.storage.snapshot`). On `filterRead()` it treats the snapshot value as `previous`, the active value as `active`, and the incoming data as `current`, and returns `ConfigMerger::mergeConfigItemStates($previous, $current, $active)` — but only when all three exist; otherwise it returns the incoming data unchanged. It also overrides `filterExists()`, `filterReadMultiple()`, `filterListAll()`, `filterCreateCollection()` and `filterGetAllCollectionNames()` so the merge participates across collections and so config that exists only in the active storage is still surfaced. Because it runs at weight 1000 (late), it merges after other filters. It has no configuration of its own, no schema, no UI, no permissions and no Drush; it depends on both `config_merge` (for the merge algorithm) and `config_filter` (for the plugin type). Enabling it makes any Config Filter-driven import (for example via Config Filter's storage factory, or tools built on it) merge-aware.

---

- Make a configuration import merge with active config rather than overwrite local customizations.
- Add three-way merge behavior to any Config Filter-based storage pipeline.
- Preserve site-specific edits to shipped config when re-importing default/updated configuration.
- Merge an extension's updated config into a customized site through the standard config import flow.
- Surface config that exists only in active storage during a filtered read (`filterExists`/`filterListAll`).
- Apply the merge late in the filter chain (weight 1000) so it runs after other transformations.
- Reuse `config_merge`'s update/ignore/substitute rules automatically during import, no custom code.
- Keep customized view, field, or block settings across a config deployment that re-imports defaults.
- Provide merge-aware config sync when combined with Config Filter storage factory consumers.
- Instantiate the `config_merge` filter plugin programmatically and call `filterRead()` to merge one item.
- Handle merges across non-default config collections via `filterCreateCollection()`.
- Avoid blunt overwrite-on-import by inserting a merge step into the pipeline.
- Retain local permission/role tweaks when default config is re-imported.
- Let distributions push config updates that respect downstream customizations.
- Combine with other Config Filter plugins (e.g. ignore/split) in a single import pipeline.
- Test merge behavior by driving the filter plugin against known snapshot and active states.
- Ensure a config item present in active but absent from the import source is not dropped.
- Roll out upstream config changes safely on sites that diverged from the shipped defaults.
