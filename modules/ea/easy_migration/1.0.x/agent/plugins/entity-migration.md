<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EntityMigration plugin type + base-class API

## Install / enable

`drush en easy_migration` (no dependencies). Enable `easy_migration_example` too if you want the
sample plugins. Then declare the **legacy source database** as a second connection in
`settings.php` / `settings.local.php` under the key used by your plugins (the base class and all
examples default to `easy_migration`):

```php
$databases['easy_migration']['default'] = [
  'driver' => 'mysql', 'database' => 'legacy_d7', 'username' => '…',
  'password' => '…', 'host' => 'db', 'prefix' => '',
];
```

## Writing a plugin

Create `src/Plugin/EasyMigration/MyThing.php` in *your own* module, extend
`Drupal\easy_migration\EntityMigrationBase`, implement `EntityMigrationPluginInterface`, and add the
`@EntityMigration` annotation. Discovery: subdir `Plugin/EasyMigration`, manager
`EntityMigrationPluginManager` (extends `DefaultPluginManager`; cache key
`easy_migration_entity_migration_plugins`; alter hook `easy_migration_entity_migration_info`).

### Annotation properties (`src/Annotation/EntityMigration.php`)

| Property | Type | Notes |
|---|---|---|
| `id` | string | Plugin id (used by `--id`, map table `plugin_id`). |
| `label` | string | Human name. |
| `entity_type` | string | Main **destination** entity type (e.g. `node`, `user`, `taxonomy_term`). |
| `order` | int (default **1000**) | Run order; low → first. Referenced entities must have a lower `order` than the entities that reference them. |
| `tags` | array (default `[]`) | Used by `--tag` filtering. |
| `source` | string (default `''`) | Logical source name; stored as `source_name`, distinguishes multiple source DBs. |
| `description` | string (default `''`) | Shown in `easy_migration:status`. |

### Methods you must implement (`EntityMigrationPluginInterface`)

- `getIds(): array` — return a flat array of source primary keys (fetch only IDs to keep memory low).
- `getData($entity_id): array` — return the source row(s) for one ID.
- `saveEntity(array $data): ContentEntityBase|NULL` — create or update and `save()` the destination
  entity, return it. `doMigrate()` passes `array_values($data)[0]` cast to array, i.e. the first row.

## Base class API (`EntityMigrationBase`)

`extends PluginBase implements EntityMigrationPluginInterface, ContainerFactoryPluginInterface` and
`use EasyMigrationFileTrait`. `create()` injects `@database` and `@entity_type.manager` (as
`$this->database`, `$this->entityTypeManager`).

- `doMigrate(): void` — loops `getIds()` → `getData()` → `saveEntity()`; on a saved
  `ContentEntityInterface` calls `updateEasyMigrationLogTable()`. Renders a Symfony `ProgressBar`
  when running under Drush (detected via `$GLOBALS['argv'][0]` ending in `drush`).
- `rollback()` — reads the plugin's map rows (`getMigrationLog($pluginId)`), deletes each migrated
  entity, then deletes its `easy_migration` row.
- `getMigrationDatabaseConnection(string $database_name = 'easy_migration'): Connection` —
  `Database::setActiveConnection($name)` then returns that connection. **Note:** it switches the
  process-wide active connection and does not restore the previous one.
- `getMigratedEntityId(int $origin, string $type): int` — parameterized lookup in `easy_migration`
  (matches `eid_origin`, `entity_type`, `source_name`); 0 if none.
- `getMigratedEntity(int $origin, string $type): EntityInterface|null` — loads the destination entity.
- `isAlreadyMigrated(int $origin, string $type): bool` — true if a mapping exists (drives idempotent
  create-vs-update in `saveEntity()`).
- `updateEasyMigrationLogTable($origin, $new, $type, $uuid, $isReferenced = FALSE, array $log = [])`
  — upsert into `easy_migration`; `$log` is `serialize()`d into the `log` blob.
- `getMigrationLog($pluginId = NULL, $type = NULL, $origin = NULL, $new = NULL, $uuid = NULL): array`
  — filtered select of map rows (each row cast to array).
- `setMigratedEntityAsReferenced($origin, $type): void` — sets `is_referenced = 1`.
- `getNodePathAliasFromDrupal7($origin, $database_name = NULL): string|NULL` — reads `url_alias`
  from the source DB for `node/<id>`.
- `countItemsToMigrate(): int` (= `count(getIds())`), `countMigratedItems(): int` (map-row count).
- Definition getters: `getLabel/getEntityType/getOrder/getTags/getSource/getDescription`.

All map-table queries use **named placeholders** (`:eid_origin`, `:entity_type`, `:source`, etc.);
no user input is concatenated into SQL. The `log` blob is written with `serialize()` and is **never
`unserialize()`d** by this module when read back.

## Helper traits

- **`EasyMigrationFileTrait`** (already `use`d by the base class):
  - `copyFileFromUri($file_uri, $destination_folder, $new_filename = NULL, $replace = EXISTS_REPLACE): string`
    — local path (`/…`) → `file_system->copy()`; `http(s)://` → `\Drupal::httpClient()->get()` +
    `file_put_contents()`; anything else throws. `prepareDirectory()` creates the destination.
  - `migrateFileFromDrupal($fid, $file_base_uri, $destination_folder = NULL, $database_name = 'easy_migration'): File`
    — reads the source `file_managed` row, copies the bytes, creates/updates a `file` entity
    (`STATUS_PERMANENT`), and records the map.
- **`EasyMigrationMediaImageTrait`** — `saveMediaImage($origin, File $file, $title = '', $alt = '',
  $media_bundle = 'image', $media_field_image_name = 'field_media_image', $lang_code = 'en'): Media`
  — create/update a media entity wrapping a migrated file.
- **`EasyMigrateTaxonomyTrait`** — `getTaxonomies(string|NULL $tids_csv): array` — maps a
  comma-separated list of source term IDs to migrated `taxonomy_term` entities.

## Known source quirks (not security issues)

- `setMigratedEntityAsReferenced()` filters on a column `origin` that does not exist in the schema
  (the column is `source_name`) and calls `->execute()` on an already-executed `query()` — it will
  error if called; the examples do not call it.
- The generated/example `saveEntity()` bodies call `$this->migrateFileFromDrupal7(...)`, but the
  trait method is named `migrateFileFromDrupal()` — sample code you must adapt before running.
