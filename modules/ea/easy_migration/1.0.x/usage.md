<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Easy Migration is a code-first alternative to core Migrate: you write each migration as an annotated `EntityMigration` PHP plugin and run it, roll it back, or check status with Drush.

---

Instead of YAML migration configs and process pipelines, Easy Migration gives you a plugin type (`Plugin/EasyMigration`) whose classes extend `EntityMigrationBase`. Each plugin declares three methods — `getIds()` (list source primary keys), `getData($id)` (fetch one source row), and `saveEntity($data)` (create/update the destination Drupal entity) — while the base class handles a persistent source→destination map table (`easy_migration`), ordering, tagging, progress bars, rollback, and idempotency (skip-if-already-migrated). Helper traits copy/download files (`EasyMigrationFileTrait`), create media image entities (`EasyMigrationMediaImageTrait`), and resolve migrated taxonomy terms (`EasyMigrateTaxonomyTrait`). A Drush code generator scaffolds a starter plugin class, and the bundled `easy_migration_example` submodule ships four working Drupal 7 → Drupal plugins (tags, users, pages, articles). It is a developer/CLI tool with no UI, routes, permissions, or config; the source database is typically a legacy DB registered as a secondary connection in `settings.php`.

---

- Port Drupal 7 content into a fresh Drupal 10/11 site using plain SQL + the Entity API, without learning the Migrate pipeline.
- Write one migration plugin per content type and control execution order with the annotation's `order` property so referenced entities (terms, users, files) migrate before the nodes that reference them.
- Run all migrations at once with `drush easy_migration:migrate` (alias `emi`).
- Migrate only one plugin with `drush emi --id=page`.
- Migrate a subset by tag with `drush emi --tag=node,user` (OR-matches the plugin `tags`).
- See a status table of every migration (order, id, label, description, total items, migrated count) with `drush easy_migration:status` (alias `ems`).
- Roll back everything (delete migrated entities + map rows) with `drush easy_migration:rollback` (alias `emrollback`), after a confirmation prompt.
- Roll back a single migration with `drush emrollback --id=article` or by tag with `drush emrollback --tag=node`.
- Scaffold a new migration plugin class from an interactive template with `drush generate plugin:easy_migration:content_entity` (alias `em-content_entity`).
- Migrate a taxonomy vocabulary from a legacy database, auto-creating the destination vocabulary if it does not exist.
- Migrate users while preserving password hashes, roles (via a role-id dictionary), status, timezone, and created/login timestamps.
- Migrate nodes (pages/articles) while remapping authorship to the already-migrated destination user.
- Copy or download files referenced by legacy content into `public://` or `private://` via `copyFileFromUri()` (local paths, `http://`, or `https://`).
- Migrate a Drupal 7 `file_managed` record into a Drupal `file` entity with `migrateFileFromDrupal()`, keeping the source→destination file map.
- Create `media` image entities that wrap migrated files with `saveMediaImage()`, populating alt/title and the media image field.
- Resolve a comma-separated list of legacy term IDs to the corresponding migrated `taxonomy_term` entities with `getTaxonomies()`.
- Look up the previously migrated destination entity for any source ID with `getMigratedEntity()` / `getMigratedEntityId()` to wire up entity references across plugins.
- Re-run a migration safely: `isAlreadyMigrated()` makes `saveEntity()` update the existing destination entity instead of creating a duplicate.
- Fetch a legacy Drupal 7 path alias for a node with `getNodePathAliasFromDrupal7()` when rebuilding URLs.
- Store arbitrary per-item diagnostic data in the map table's serialized `log` column via `updateEasyMigrationLogTable()`.
- Mark a migrated file/media row as referenced (`setMigratedEntityAsReferenced()`) to track which assets are actually used.
- Point migrations at multiple legacy databases by giving each plugin a distinct `source` and passing the connection name to `getMigrationDatabaseConnection()`.
- Use the `easy_migration_example` submodule as a copy-paste starting point for a real Drupal 7 → Drupal 10/11 migration.
