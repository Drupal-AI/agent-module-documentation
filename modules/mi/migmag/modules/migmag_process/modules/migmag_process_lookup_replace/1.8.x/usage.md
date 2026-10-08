<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migrate Magician Forced Lookup Process Plugin (`migmag_process_lookup_replace`) globally forces core's `migration_lookup` process plugin to use the smarter `MigMagLookup` class, so every existing migration benefits without editing any YAML.

---

This is a tiny glue submodule. Its only job is an implementation of `hook_migrate_process_info_alter()` that, when the core `migration_lookup` process plugin is defined, rewrites that definition's `class` to `Drupal\migmag_process\Plugin\migrate\process\MigMagLookup`. The effect: any migration that already uses `plugin: migration_lookup` transparently gets Migrate Magician's improved lookup behaviour (valid stubs only, correct migration identification, partial-ID stubbing, `stub_default_values`) with **no changes to migration definitions**. Enable it instead of hunting through every migration to swap the plugin id from `migration_lookup` to `migmag_lookup`. It has no configuration, routes, permissions, or Drush commands, and depends on `migmag_process` (which provides the `MigMagLookup` class). Verify the override at runtime by reading the `migration_lookup` definition's `class` from the process plugin manager.

---

- Force every migration's `migration_lookup` to use `MigMagLookup` site-wide with one module enable.
- Avoid editing dozens of migration YAML files just to change a plugin id.
- Fix invalid/never-updatable stubs across an existing Drupal 7 → 11 migration set at once.
- Enable correct partial-ID stubbing (translations, revisions) for all lookups.
- Apply `MigMagLookup`'s valid-stub behaviour to contrib migrations you don't want to fork.
- Keep third-party migration definitions untouched while still upgrading lookup behaviour.
- Roll out improved lookup behaviour to a whole upgrade project consistently.
- Turn the override on for a migration run and off again by enabling/uninstalling the module.
- Confirm the override is active by inspecting the `migration_lookup` plugin definition class.
- Combine with `migmag_rollbackable_replace` for a fully drop-in Migrate Magician upgrade.
- Use when you can't rename `migration_lookup` in generated/derived migration definitions.
- Ensure stub creation only happens in migrations that truly contain the source row.
- Provide `stub_default_values` support to lookups that were written for core's plugin.
- Standardise lookup behaviour across a team's many migration modules.
- Debug lookup/stub problems by toggling the improved implementation on and off.
- Adopt Migrate Magician's lookup incrementally without touching pipelines.
