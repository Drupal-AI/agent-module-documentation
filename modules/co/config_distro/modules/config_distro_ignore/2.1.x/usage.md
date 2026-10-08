<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Config Distro Ignore lets you protect specific configuration from being changed by a distribution update: listed config items keep their active (site) value instead of being overwritten when Config Distro imports the distribution's configuration.

---

The submodule ships a Config Filter plugin, `DistroIgnoreFilter` (`@ConfigFilter` id `config_distro_ignore`, `storages = {"config_distro.storage.distro"}`, weight 10000), which runs (via the config_distro_filter bridge) when the distribution storage is built. For any config name matched by the ignore lists, its `filterRead()`/`filterReadMultiple()` return the value from the **active** storage rather than the distribution's, so the site's version is retained; `filterListAll()`/`filterExists()` keep ignored items visible. The lists live in the `config_distro_ignore.settings` config object with three sequences: `all_collections` (config permanently ignored in every collection), `default_collection` (ignored in the default collection), and `custom_collections` (ignored per non-default collection). Entries support shell-style wildcards (`*`, `?`) and an optional `::<hash>` suffix so an item is ignored only while its data matches a specific md5 hash (used to ignore a config only until it changes). A settings form (`config_distro_ignore.settings` at `/admin/config/development/configuration/distro/ignore`) manages the lists, and a "Retain configuration" operation link is added to each row of Config Distro's import form (route `config_distro_ignore.add_item`) so site builders can ignore an item straight from the update screen; both are gated by the parent's `synchronize distro configuration` permission. It depends on `config_distro` and `config_distro_filter` (the bridge that makes the filter run), ships config schema, and has no Drush or permissions of its own.

---

- Keep a site's customized configuration item from being overwritten by a distribution update.
- Permanently ignore a config object across all collections via the `all_collections` list.
- Ignore a config only in the default collection (`default_collection`).
- Ignore a config in specific non-default collections (`custom_collections`), e.g. a language override.
- Use shell wildcards (e.g. `views.view.*`) to ignore a whole group of config during distro imports.
- Ignore a config only until it changes, by pinning it to a data hash with the `::<hash>` suffix.
- Add a config to the ignore list directly from the Config Distro import screen's "Retain configuration" link.
- Manage the ignore lists from the settings form at `/admin/config/development/configuration/distro/ignore`.
- Protect site-specific tweaks to a shipped view while still accepting other distribution updates.
- Retain locally edited block, menu, or field settings across distribution config imports.
- Prevent a distribution from resetting `system.site` name/slogan on downstream sites.
- Keep custom permissions/roles intact when importing distribution configuration.
- Export the ignore configuration (`config_distro_ignore.settings`) so all environments ignore the same items.
- Combine ignore rules with Config Distro's transform pipeline (via the config_distro_filter bridge).
- Ignore configuration matched by a pattern for a specific config collection only.
- Retain a customized text format or filter configuration during distribution updates.
- Let a distribution ship defaults while sites opt specific items out of future updates.
- Temporarily ignore a config until the distribution's next intended change (hash-pinned ignore).
- Give site builders a self-service way to protect their customizations from distro imports.
- Audit which configuration is currently protected by reading `config_distro_ignore.settings`.
