<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Easy Migration (easy_migration) — agent index

Code-first content-migration framework and alternative to core Migrate. You write each migration
as an annotated **`EntityMigration`** PHP plugin (extend `EntityMigrationBase`, implement three
methods) and run/rollback/inspect it via Drush. No UI, no routes, no permissions, no config
objects, no config schema. Package **Migration**. Core `^10 | ^11`. License GPL-2.0-or-later.
Version 1.0.1. **No dependencies** beyond Drupal core (base module).

- **Plugin type, base-class API, annotation, traits, map table** →
  [plugins/entity-migration.md](plugins/entity-migration.md)
- **Drush commands (migrate / rollback / status) and the code generator** →
  [drush/commands.md](drush/commands.md)
- **Bundled examples (submodule)** → `../modules/easy_migration_example/1.0.x/agent/start.md`
  (four Drupal 7 → Drupal plugins: tags, users, pages, articles).

## What it provides (from source)

- **Plugin type `EntityMigration`** — manager `EntityMigrationPluginManager`
  (service id `plugin.manager.easy_migration.entity_migration_plugin_manager`, parent
  `default_plugin_manager`), plugin subdir `Plugin/EasyMigration`, annotation
  `Drupal\easy_migration\Annotation\EntityMigration`, interface `EntityMigrationPluginInterface`,
  abstract base `EntityMigrationBase`. Alter hook: `easy_migration_entity_migration_info`.
- **Drush commandfile** `EasyMigrationCommands` (`drush.services.yml`): `easy_migration:status`
  (`ems`), `easy_migration:migrate` (`emi`), `easy_migration:rollback` (`emrollback`).
- **Drush generator** `ContentEntityGenerator` — `plugin:easy_migration:content_entity`
  (alias `em-content_entity`), template `templates/generator/content-entity.twig`.
- **Traits**: `EasyMigrationFileTrait` (file copy/download; used by the base class),
  `EasyMigrationMediaImageTrait` (create media images), `EasyMigrateTaxonomyTrait` (resolve terms).
- **Map table** `easy_migration` (`hook_schema` in `easy_migration.install`): columns
  `plugin_id, eid_origin, eid_new, uuid, entity_type, source_name, is_referenced, log` (log is a
  serialized blob); primary key `(plugin_id, eid_origin, eid_new, entity_type)`.
- **Submodule** `easy_migration_example` (depends on `easy_migration`).

## Mental model

A plugin's annotation sets `id`, `label`, `entity_type`, `order` (default 1000; controls run
sequence), `tags`, `source`, `description`. `EntityMigrationBase::doMigrate()` loops
`getIds()` → `getData($id)` → `saveEntity($data)`, then records the source→destination mapping in
the `easy_migration` table (so re-runs update rather than duplicate). `rollback()` deletes the
migrated entities and their map rows in reverse `order`. The legacy source database is a **separate
DB connection** (default key `easy_migration`) declared in `settings.php`, read via
`getMigrationDatabaseConnection()`. This is a **CLI/developer tool** run by a trusted operator.
