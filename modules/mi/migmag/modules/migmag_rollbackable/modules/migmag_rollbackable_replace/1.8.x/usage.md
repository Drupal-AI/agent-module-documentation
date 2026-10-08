<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migrate Magician Forced Rollbackable Destination Plugins (`migmag_rollbackable_replace`) globally swaps non-rollbackable core migration destination plugins for the rollback-capable versions from `migmag_rollbackable`, without editing any migration YAML.

---

This glue submodule implements `hook_migrate_destination_info_alter()` and, for a fixed map of core destination plugin ids, rewrites each definition's `class` to the matching `Rollbackable*` class: `color` → `RollbackableColor`, `config` → `RollbackableConfig`, `default_langcode` → `RollbackableDefaultLangcode`, `component_entity_display` → `RollbackablePerComponentEntityDisplay`, `component_entity_form_display` → `RollbackablePerComponentEntityFormDisplay`, `shortcut_set_users` → `RollbackableShortcutSetUsers`, and `d7_theme_settings` → `RollbackableThemeSettings`. The plugin **ids stay the same** (still `config`, `color`, …) — only the implementing class changes — so existing migrations that use `plugin: config` become rollback-capable transparently. Enable this instead of rewriting migration definitions to use the `migmag_rollbackable_*` ids. It has no configuration, routes, permissions, or Drush commands, and depends on `migmag_rollbackable` (which provides the classes and the rollback DB tables). Verify the override by reading a core destination definition's `class` from the destination plugin manager.

---

- Make every `config` destination migration rollback-capable with a single module enable.
- Make core `color`, `default_langcode`, and `d7_theme_settings` migrations rollbackable site-wide.
- Make per-component entity display / form-display migrations rollbackable without YAML edits.
- Avoid rewriting migration definitions to the `migmag_rollbackable_*` destination ids.
- Add rollback safety to contrib/core migrations you don't want to fork.
- Keep migration plugin ids unchanged while upgrading their implementing class.
- Turn rollback capability on for a migration run and off again by enabling/uninstalling.
- Confirm the override is active by inspecting the `config` destination definition class.
- Combine with `migmag_process_lookup_replace` for a fully drop-in Migrate Magician setup.
- Support iterative migrate → rollback → retry development across a whole project.
- Undo a botched core-config migration during development cleanly.
- Roll out rollback capability consistently to a team's migration set.
- Apply rollbackable destinations to derived/generated migrations you can't easily edit.
- Enable rollback for shortcut-set-users migrations (when `shortcut` is installed).
- Adopt Migrate Magician rollback incrementally by toggling this one module.
- Ensure the rollback DB tables are populated by routing all writes through rollbackable classes.
