<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Update applies pending entity-type and field-storage schema changes to a Drupal site — including entity types that already contain data — from Drush, a web UI, or PHP.

---

Drupal core removed `drush entity-updates` because changing an entity type's schema while it holds data is unsafe. Entity Update brings that capability back with a data-preserving strategy. `EntityUpdate::basicUpdate()` walks `\Drupal::entityDefinitionUpdateManager()->getChangeSummary()` and applies plain definition/field-storage updates (the "basic" path, which fails when the affected entity type has rows unless `--force` is used). `EntityUpdate::safeUpdateMain()` is the "all" path: for each entity type needing a structural change it serialises existing entities into the module's own `entity_update` database table (`hook_schema()` in `entity_update.install`: `entity_type`, `entity_id`, `entity_class`, `status`, blob `data`), deletes them, lets `CustomEntityDefinitionUpdateManager` (service `entity_update.definition_update_manager`, wrapping core's `entity.definition_update_manager`, last-installed schema repository, entity type listener and field storage definition listener) install the new schema, then recreates the entities from the backup — with `--rescue` to retry the recreate step and `--clean` to empty the backup table. Configuration is a single object, `entity_update.settings`, whose `excludes` mapping lists entity type ids that must never be deleted and recreated (shipped default: `user` and `user_role`); it is edited at `/admin/config/development/entity-update/settings`. The web UI lives under `/admin/config/development/entity-update` (`exec`, `types`, `status`, `list`, `settings` routes, all gated by core's `administer software updates` permission) and the `configure` route is `entity_update.exec`. Two Drush commands are provided: `entity:update` (alias `upe`) to inspect and run updates, and `entity:check` (alias `upec`) to list entity types, show an entity type summary and page through entity records. The module is explicitly a developer tool — the README warns to back up the database and to prefer Drush over the browser on production.

---

- Apply a pending entity schema change after adding a base field to a custom entity type.
- Update an entity type that already has content, without truncating its tables by hand.
- See what schema changes are pending with `drush upe --show` before touching anything.
- Convert a non-translatable custom entity type into a translatable one, step by step.
- Convert a translatable entity type back to non-translatable.
- Add or remove an entity key (e.g. `langcode`) and push the schema change through.
- Update only one entity type: `drush upe my_entity_type --nobackup`.
- Run the safe, data-preserving update across every changed entity type: `drush upe --all`.
- Run the fast path on empty entity types: `drush upe --basic`.
- Force a basic update even though rows exist (`drush upe --basic --force`) on a throwaway site.
- Back up and delete an entity type's data before a multi-step refactor: `drush upe <type> --bkpdel`.
- Recreate entities from the module's backup table after a failed update: `drush upe --rescue`.
- Empty the backup table once a migration is confirmed good: `drush upe --clean`.
- Take an automatic `sql-dump` before the update by omitting `--nobackup`.
- Inspect an entity type's summary from the CLI: `drush upec node`.
- List all entity types whose id contains a string: `drush upec block --types`.
- Page through entity records for debugging: `drush upec node --list --start=2 --length=3`.
- Protect critical entity types (`user`, `user_role`) from the delete/recreate cycle via `excludes`.
- Add extra entity types to the exclusion list before running `--all` on a shared environment.
- Review entity update status in the browser at `/admin/config/development/entity-update/status`.
- Browse the entity types list at `/admin/config/development/entity-update/types`.
- Give a site builder read-only visibility of schema drift via `administer software updates`.
- Replace Devel Entity Updates on sites where the entity types to update contain data.
- Recover a site stuck with "Mismatched entity and/or field definitions" on the status report.
- Call `EntityUpdate::safeUpdateMain()` from an `hook_update_N()` in your own module.
- Script schema updates in CI after a code deploy that changes entity definitions.
