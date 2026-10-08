<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Programmatic API

Everything is static methods on plain classes plus four procedural helpers — there is no
public service interface other than the definition update manager.

## Procedural helpers (`entity_update.module`)

```php
entity_update_get_entity_changes();                 // \Drupal::entityDefinitionUpdateManager()->getChangeSummary()
entity_update_get_entity_type($entity_type_id);     // EntityTypeInterface (via storage handler)
entity_update_get_entity_definitions();             // all EntityTypeInterface definitions
entity_update_get_entity_definition_update_manager(); // the service below
```

## `Drupal\entity_update\EntityUpdate` (static)

| Method | Purpose |
|---|---|
| `basicUpdate($force = FALSE)` | Apply the pending definition / field-storage updates directly. Aborts when an affected entity type has data unless `$force`. Returns bool. |
| `safeUpdateMain(?EntityTypeInterface $entity_type = NULL)` | The data-preserving path: backup → delete → apply schema change → recreate. `NULL` = every changed entity type. Returns bool. |
| `getEntityTypesToUpdate($type_id = NULL)` | The change summary, optionally narrowed to one entity type. |
| `entityUpdateDataBackupDel($entity_change_summaries, $force_type = NULL)` | Serialise matching entities into the `entity_update` table and delete them. |
| `entityUpdateDataRestore()` | Recreate entities from the backup table (the `--rescue` path). |
| `cleanupEntityBackup()` | Truncate the backup table. |

```php
// in a hook_update_N() of your own module, after changing an entity type definition:
if (!\Drupal\entity_update\EntityUpdate::safeUpdateMain(entity_update_get_entity_type('my_entity'))) {
  throw new \Drupal\Core\Utility\UpdateException('Entity schema update failed for my_entity.');
}
```

## `Drupal\entity_update\EntityCheck` / `EntityUpdatePrint`

Reporting helpers used by the Drush commands and controllers:

```php
EntityCheck::showEntityStatusCli();               // pending changes, CLI table
EntityCheck::getEntityTypesList($filter = '');    // entity types, optionally substring-filtered
EntityCheck::getEntityList($type, $start, $len);  // entity records
EntityUpdatePrint::displaySummary($type);         // one entity type's summary
```

## Service `entity_update.definition_update_manager`

```yaml
class: Drupal\entity_update\CustomEntityDefinitionUpdateManager
arguments:
  - '@entity.definition_update_manager'
  - '@entity.last_installed_schema.repository'
  - '@entity_type.manager'
  - '@entity_type.listener'
  - '@entity_field.manager'
  - '@field_storage_definition.listener'
```

It wraps core's `EntityDefinitionUpdateManager` so the module can drive the entity type listener
and field storage definition listener itself (install / update / delete a definition) rather than
relying on core's refusal to change a schema that holds data.

```php
$manager = \Drupal::service('entity_update.definition_update_manager');
// or: entity_update_get_entity_definition_update_manager();
```

## Caveats

- These calls **delete and recreate content**. Always `cleanupEntityBackup()` before a new run so
  the backup table only contains the current attempt, and take a database dump first.
- Entity types listed in `entity_update.settings.excludes` (default `user`, `user_role`) are
  skipped by the delete/recreate path — see [../configure/settings.md](../configure/settings.md).
- The module has no hooks of its own (`*.api.php` does not exist) and defines no plugin types.
