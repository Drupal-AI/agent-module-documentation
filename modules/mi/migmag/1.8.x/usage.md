<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migrate Magician (migmag) is a toolset of utilities, process plugins, and rollback-capable destination plugins that make writing and running Drupal migrations (especially Drupal 7 → modern-core upgrades) more reliable.

---

The base `migmag` module itself has **no configuration, no admin UI, no plugins, and no services** — it is a library of static PHP helpers plus a reusable trait, consumed by the other Migrate Magician submodules and by your own migration code. `MigMagArrayUtility` inserts/moves keys within an array (handy for surgically re-ordering a migration's process pipeline); `MigMagMigrationUtility` normalises a process pipeline to associative form, rewrites `migration_lookup` references across a definition, and strips missing migration dependencies; `MigMagSourceUtility` instantiates a source plugin from a definition; and the `MigMagMigrationConfigurationTrait` gives test/tooling code a migration connection. The real functionality ships in the submodules, each independently enableable: `migmag_process` (extra process plugins + an improved migrate-stub service), `migmag_process_lookup_replace` (force core's `migration_lookup` to use the smarter `migmag_lookup`), `migmag_rollbackable` (rollback-capable versions of core destination plugins that can't otherwise be rolled back, backed by two DB tables), `migmag_rollbackable_replace` (swap the core destinations for the rollbackable ones without editing migration YAML), `migmag_menu_link_migrate` (fix core menu-link migrations to migrate as many links as possible), and `migmag_callback_upgrade` (backport of core 9.2's `callback` process plugin for older cores — a no-op on 9.2+). Because it is a soft companion to core Migrate, you only need migmag if core Migrate is in play.

---

- Provide a shared utility library for a large Drupal 7 → 10/11 upgrade project.
- Surgically insert a new step in front of or after an existing step in a migration's process pipeline (`MigMagArrayUtility::insertAfterKey`).
- Re-order process pipeline keys without rewriting the whole `process:` block (`moveInFrontOfKey` / `moveAfterKey`).
- Normalise a shorthand process pipeline (`plugin: x`) into the associative array form for programmatic manipulation.
- Bulk-rewrite the `migration_lookup` migration references inside a migration definition when renaming or splitting migrations.
- Strip dependencies on migrations that don't exist in the current site from a definition so it still validates.
- Instantiate a migrate source plugin from a definition array in custom tooling or tests.
- Add rollback support to migrations that write config, theme settings, colors, or display components (via `migmag_rollbackable`).
- Roll back a completed content/config migration cleanly instead of leaving orphaned config behind.
- Swap in rollback-capable destination plugins across every migration without touching a single YAML file (`migmag_rollbackable_replace`).
- Create valid migration stubs for entity references that resolve to a translation or a specific revision (`migmag_process` `migmag_lookup`).
- Look up a destination bundle from source/destination entity type during a migration (`migmag_target_bundle`).
- Wrap a fragile process sub-pipeline in try/catch and provide fallbacks (`migmag_try`).
- Log the live value flowing through a process pipeline for debugging (`migmag_logger_log`).
- Read an arbitrary property/field off an existing entity mid-migration (`migmag_get_entity_property`).
- Generate or extract a UUID within a process pipeline (`migmag_uuid_generate`).
- Compare two row values with a chosen operator to drive conditional processing (`migmag_compare`).
- Migrate more of a site's menu links than core's default menu-link migrations manage (`migmag_menu_link_migrate`).
- Backport the modern `callback` process plugin (with `unpack_source`) to a Drupal 8.x/9.0–9.1 site (`migmag_callback_upgrade`).
- Give kernel/functional migration tests a ready-made migration database connection via the configuration trait.
- Keep migration definitions valid on a partially-built site by removing references to not-yet-created migrations.
- Build reusable migration tooling on top of a stable, tested helper API.
- Enable only the pieces you need — every submodule works independently.
