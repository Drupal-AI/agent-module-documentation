<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The update-manager service and applyUpdates()

Source: `src/EntityDefinitionUpdateManager.php`, `src/EntityTypeDefinitionServiceProvider.php`,
`entity_definition_update.services.yml`, `entity_definition_update.info.yml`.

## Install / enable

`drush en entity_definition_update -y` (or via *Extend*). Dependencies: core `system`, `field`.
No configuration screen — enabling only makes the service available.

## The service

`entity_definition_update.services.yml` registers:

- id `entity_definition_update.entity_definition_update_manager`
- class `Drupal\entity_definition_update\EntityDefinitionUpdateManager`
- arguments (in order): `@entity.definition_update_manager`,
  `@entity.last_installed_schema.repository`, `@entity_type.manager`, `@entity_type.listener`,
  `@entity_field.manager`, `@field_storage_definition.listener` — all core services.

`EntityTypeDefinitionServiceProvider::register()` (a `ServiceProviderBase`) additionally scans
every `*.php` file under the module's `src/` with Symfony `Finder` and registers each as an
**autowired** service keyed by its fully-qualified class name, skipping any class the container
already defines. This is a code convenience; consumers use the named service id above.

## applyUpdates() — the mechanism

`EntityDefinitionUpdateManager::applyUpdates()`:

1. Obtains the complete change list by reflection: it calls the **protected** `getChangeList()`
   on core's `entity.definition_update_manager` via `\ReflectionMethod(..., 'getChangeList')`
   with `setAccessible(TRUE)` (works back to Drupal 8.6).
2. If the change list is non-empty, explicitly invalidates caches —
   `entityTypeManager->clearCachedDefinitions()` and
   `entityFieldManager->clearCachedFieldDefinitions()` — because core's `getChangeList()` only
   disables the cache, it does not invalidate it.
3. For each `entity_type_id`: processes the entity-type change first (`doEntityUpdate()`), then
   field storage definition changes (`doFieldUpdate()`). Order matters when making a type
   revisionable while adding revisionable fields in the same pass.

### doEntityUpdate($op, $entity_type_id) (private)

- `DEFINITION_CREATED` → `entityTypeListener->onEntityTypeCreate($entity_type)`.
- `DEFINITION_UPDATED` → loads the last-installed definition; if the storage
  `instanceof EntityStorageSchemaInterface` and `requiresEntityDataMigration($entity_type, $original)`
  is TRUE, it **throws `\InvalidArgumentException`** ("… requires a data migration."). Otherwise
  calls `entityTypeListener->onFieldableEntityTypeUpdate(...)` with the new/original entity type
  and field storage definitions.

### doFieldUpdate($op, $storage_definition, $original_storage_definition) (private)

- `DEFINITION_CREATED` → `fieldStorageDefinitionListener->onFieldStorageDefinitionCreate()`.
- `DEFINITION_UPDATED` → `onFieldStorageDefinitionUpdate()` (only when both new and original
  definitions are present).
- `DEFINITION_DELETED` → `onFieldStorageDefinitionDelete()` (only when the original is present).

The data-migration guard means this service applies **schema-only** reconciliations; anything
requiring row-level migration is refused, and the developer must back up/restore data around the
call themselves.

## How to call it

From your module's `hook_install()` or `hook_update_N()` — code that runs through
`drush updatedb` / `update.php`:

```php
$manager = \Drupal::service('entity_definition_update.entity_definition_update_manager');
$manager->applyUpdates();
```

For data-preserving changes, the project's documented pattern is: copy the source table to a temp
table, truncate the original, call `applyUpdates()`, alter columns as needed, copy data back,
then drop the temp table — all inside your own update hook.

## Permissions / access

None. The module declares no routes and no permissions; `applyUpdates()` is reachable only from
PHP you write in update/deploy context, which is already a privileged maintenance operation.
