# devel_entity_updates — API

The module exposes one class, `Drupal\devel_entity_updates\DevelEntityDefinitionUpdateManager`
(`src/DevelEntityDefinitionUpdateManager.php`), a development-only wrapper around core's
`entity.definition_update_manager`. **Do not use in production** — released schema changes must go
through `hook_update_N()` / `hook_post_update_NAME()`.

## Obtaining an instance

It implements `ContainerInjectionInterface` (has a `create()` factory) but is not registered as a
named service. The Drush command resolves it through the class resolver:

```php
$manager = \Drupal::service('class_resolver')
  ->getInstanceFromDefinition(\Drupal\devel_entity_updates\DevelEntityDefinitionUpdateManager::class);
$manager->applyUpdates();
```

Its `create()` injects six core services: `entity.definition_update_manager`,
`entity.last_installed_schema.repository`, `entity_type.manager`, `entity_type.listener`,
`entity_field.manager`, and `field_storage_definition.listener`.

## `applyUpdates()`

The only public method. It:

1. Reads the complete change list from core's update manager via `getChangeList()` (invoked by
   reflection, since that method is protected).
2. If there are changes, invalidates cached entity type and field definitions.
3. For each entity type, applies entity-type definition changes **before** field storage definition
   changes (needed when e.g. converting to revisionable while adding revisionable fields).
4. Drives `entity_type.listener` for entity type create/update, and
   `field_storage_definition.listener` for field storage create/update/delete, based on the change
   op (`DEFINITION_CREATED` / `DEFINITION_UPDATED` / `DEFINITION_DELETED`).

## Guardrail

For an updated entity type whose storage `requiresEntityDataMigration()`, `applyUpdates()` throws
`\InvalidArgumentException` ("...requires a data migration.") rather than proceeding — it only
handles schema changes that need no data migration.
