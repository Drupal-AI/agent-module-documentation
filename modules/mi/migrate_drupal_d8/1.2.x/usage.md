Migrate Drupal 8+ to Drupal 8+ provides a generic migrate **source plugin** (`d8_entity`) that reads any content-entity type and its Field API values straight from another Drupal 8/9/10/11 site's database, for use as the source of a Drupal-to-Drupal migration.

---

The module adds a single reusable migrate source plugin, `d8_entity` (class `ContentEntity`, extending core's `SqlBase`), that queries a *source* Drupal 8+ database directly rather than going through the source site's API. You point it at a database connection (the migrate `key`), an `entity_type`, and optionally a `bundle`; it builds a SQL query against that entity's base/data tables, then in `prepareRow()` pulls every non-deleted Field API field for the bundle from the source's dedicated field tables (`entity__field_name`, including the hashed-table-name logic for names over 48 characters) and multi-value base fields, exposing them as source properties. Sub-field columns are addressed with a delta index (e.g. `body/0/value`). It reads field definitions from the source `config` table (`field.field.*`, `field.storage.*`) and skips deleted fields. Four thin convenience plugins — `d8_node`, `d8_user`, `d8_file`, `d8_taxonomy_term` — subclass it with the `entity_type` pre-set, but all four are **deprecated**; use `d8_entity` with an explicit `entity_type` instead. The module ships no configuration, permissions, routes, services, or Drush commands — it is purely a plugin you reference from migration YAML, typically driven by migrate_plus/migrate_tools. The source database connection is declared in `settings.php`/`settings.local.php` under `$databases` and referenced by its key.

---

- Migrate nodes of a specific content type from an old Drupal 8/9/10 site into a new Drupal 11 site.
- Copy users (with their fields) from one Drupal site's database to another.
- Migrate taxonomy terms of a given vocabulary between two Drupal installations.
- Migrate file entities from a source Drupal site as part of a media/file migration.
- Pull any custom content-entity type from a source site by setting `entity_type` on `d8_entity`.
- Read source content directly from the database when the source site's REST/JSON:API is unavailable.
- Migrate a single bundle by adding a `bundle:` key, or all bundles of a type by omitting it.
- Map multi-value/sub-field data using delta indexes (`'body/value': 'body/0/value'`).
- Migrate base fields (title, status, created) alongside configurable fields in one source row.
- Combine with `migrate_plus` migration config entities and `migrate_tools` drush commands to run/rollback.
- Stage a content consolidation, merging content from several Drupal 8+ sites into one.
- Re-platform a Drupal 8 site to Drupal 11 while restructuring content types via the process pipeline.
- Use as the `source` in a migration group, sharing one source database key across many migrations.
- Migrate revisionable entities by exposing the source revision id for the query.
- Transform field values during migration by feeding `d8_entity` output through process plugins.
- Selectively migrate only published nodes by filtering in the process/source configuration.
- Seed a new site's demo content from a production Drupal database snapshot.
- Migrate translated content by iterating langcodes (source exposes the langcode id key).
- Replace ad-hoc SQL import scripts with a maintainable, Field-API-aware migrate source.
- Avoid writing a bespoke source plugin for a straightforward Drupal-8-to-Drupal-8 content copy.
- Keep the source site untouched (read-only queries) while building the destination site.
