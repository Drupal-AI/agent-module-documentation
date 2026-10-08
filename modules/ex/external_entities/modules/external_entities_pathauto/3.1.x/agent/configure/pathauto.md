# Configure: Pathauto aliases for external entities

Enable the module, then edit an external entity type at
`/admin/structure/external-entity-types/{id}` and tick **Automatically generate aliases**. Create a
Pathauto pattern for the derived entity type as you would for any entity, and aliases will be produced.

## How it works

All hooks are implemented as methods on the OO hook class
`Drupal\external_entities_pathauto\Hook\ExternalEntitiesPathautoHooks` (declared as an autowired
service in `external_entities_pathauto.services.yml`, each method tagged with a `#[Hook('…')]`
attribute). There is no procedural `.module` file.

- `hook_form_alter` (`formAlter`) adds the `generate_aliases` checkbox to the external entity type
  add/edit form (only when the form object is an `ExternalEntityTypeForm`); it is stored as a
  **third-party setting** on the config entity
  (`getThirdPartySetting('external_entities_pathauto', 'generate_aliases')`), saved via the entity
  builder `external_entities_pathauto_xntt_form_builder` registered in `$form['#entity_builders']`.
- `hook_config_schema_info_alter` (`configSchemaInfoAlter`) adds the nullable boolean
  `generate_aliases` key to `external_entities.external_entity_type.*`.
- `hook_pathauto_alias_types_alter` (`pathautoAliasTypesAlter`) swaps the class of pathauto alias types
  provided by `external_entities` to `ExternalEntityAliasTypeBase`.
- `hook_entity_storage_load` (`entityStorageLoad`) generates the alias on load for types with
  `generate_aliases` on, when no alias exists yet
  (`pathauto.generator`→`updateEntityAlias($entity, 'insert')`) — external entities have no local
  insert/update to hook, so generation happens at load time.

## Alias type plugin

`Plugin/pathauto/AliasType/ExternalEntityAliasTypeBase` extends core pathauto's `EntityAliasTypeBase`
and implements batch update/delete (`batchUpdate()`/`batchDelete()`, 25 items/update, 100/delete),
so Pathauto's bulk "generate/delete aliases" operations work for external entity types.

## Set it programmatically

```php
$type = \Drupal::entityTypeManager()->getStorage('external_entity_type')->load('my_type');
$type->setThirdPartySetting('external_entities_pathauto', 'generate_aliases', TRUE)->save();
```

Note: when the module is uninstalled, the parent's `external_entities_update_93019` removes stray
`generate_aliases` settings.
