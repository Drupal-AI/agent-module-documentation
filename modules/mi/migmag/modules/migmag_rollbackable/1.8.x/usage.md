<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migrate Magician Rollbackable Destination Plugins (`migmag_rollbackable`) provides rollback-capable versions of Drupal core migration destination plugins that normally cannot be rolled back (config, theme settings, colors, display components, default langcode, shortcut-set users).

---

Several core migrate destination plugins write into shared config or theme data that has no per-migration record, so core's rollback has nothing to undo. This submodule supplies drop-in replacements whose ids are prefixed `migmag_rollbackable_` — `migmag_rollbackable_config`, `migmag_rollbackable_color`, `migmag_rollbackable_theme_settings`, `migmag_rollbackable_default_langcode`, `migmag_rollbackable_component_entity_display`, `migmag_rollbackable_component_entity_form_display`, and `migmag_rollbackable_shortcut_set_users`. Before writing, each plugin records the previous value so a rollback can restore it. That bookkeeping lives in two dedicated database tables created on install: **`migmag_rollbackable_data`** (previous config values, keyed by migration plugin id, target id, langcode, and component) and **`migmag_rollbackable_new_targets`** (tracks targets newly created by a migration so rollback knows what to delete). To use a rollbackable plugin, either reference its `migmag_rollbackable_*` id as the migration's `destination:` `plugin:`, or enable the companion `migmag_rollbackable_replace` submodule to swap the core destinations automatically without editing YAML. Some plugin ids (e.g. `migmag_rollbackable_color`, `migmag_rollbackable_shortcut_set_users`) only appear when their providing modules — `color`, `shortcut` — are installed. The module has no configuration, routes, permissions, or Drush commands, and (per the project README) reliable rollback of core migrations may also require Smart SQL ID Map or a couple of core patches.

---

- Make a `config` destination migration rollbackable so undoing it restores the prior config values.
- Roll back a theme-settings (`d7_theme_settings`) migration cleanly.
- Roll back a color-module migration (`color`) without leaving altered palettes behind.
- Roll back per-component entity display / form-display migrations.
- Roll back a default-langcode migration.
- Roll back a shortcut-set-users migration.
- Reference `migmag_rollbackable_config` directly as a migration's destination plugin id.
- Record the pre-migration value of a config object so it can be restored on rollback.
- Track targets a migration newly created so rollback deletes exactly those.
- Support iterative D7 → 11 migration development where you migrate, inspect, roll back, and retry.
- Undo a botched config migration during development without a full site reinstall.
- Provide rollback safety on migrations that write into shared config.
- Query the `migmag_rollbackable_data` table to see stored previous values for a migration.
- Use with `migmag_rollbackable_replace` to make all core destinations rollbackable at once.
- Keep rollback data isolated in dedicated tables rather than the migrate map tables.
- Enable rollback for display-component migrations that core cannot undo.
- Combine with Smart SQL ID Map to work around core rollback bugs (per README).
- Develop migrations safely in CI where each run must fully undo the previous one.
- Roll back only the config-writing part of a larger migration graph.
- Add rollback capability to a migration set without rewriting its logic.
- Inspect which migration plugin id owns a stored rollback value via the data table columns.
