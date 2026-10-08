<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `trash_ignore` import processor

Source: `src/Plugin/EntityShareClient/Processor/IgnoreTrash.php`
Class: `Drupal\entity_share_trash_ignore\Plugin\EntityShareClient\Processor\IgnoreTrash`

## Install / enable

`drush en entity_share_trash_ignore -y`. Requires `entity_share_client` and `trash` enabled.
No config, no permissions, no settings route — the processor is registered by the
`@ImportProcessor` annotation and works immediately.

## Plugin definition (annotation)

- id: `trash_ignore`
- label: "Ignore trash"
- description: "Ignore entities that are in the trash when doing an import. Ignored entities are never imported"
- stages: `{ "is_entity_importable" = -5 }` — participates only in the importability decision, at weight -5.
- `locked = true` — cannot be disabled/removed per import config; always on while the module is enabled.

Extends `ImportProcessorPluginBase` (from `entity_share_client`) and implements `PluginFormInterface`.
`buildConfigurationForm()` returns the form unchanged (no configurable settings).

## Dependencies injected (`create()`)

`entity_type.manager`, `entity_type.bundle.info`, `jsonapi.resource_type.repository`,
`entity_share_client.state_information`, `logger.factory` (channel **`piipe_entity_share`**),
and `trash.manager` (`Drupal\trash\TrashManagerInterface`).
(`entityBundleInfo`, `resourceTypeRepository`, `stateInformation` are injected but not used in the
current importability logic.)

## Logic — `isEntityImportable(RuntimeImportContext $runtime_import_context, array $entity_json_data)`

Called by Entity Share Client's import pipeline at the `is_entity_importable` stage. Returns TRUE
to allow the import, FALSE to skip the incoming entity.

1. `[$type, $bundle] = explode('--', $entity_json_data['type'], 2);` — parse the JSON:API resource type.
2. `if (!$this->trashManager->isEntityTypeEnabled($type, $bundle)) return TRUE;` — entity types/bundles
   that Trash does not manage are always importable.
3. Load the existing local entity by UUID, inside the Trash "inactive" context so trashed rows are visible:
   `$entity = $this->trashManager->executeInTrashContext('inactive', fn() => $storage->loadByProperties(['uuid' => $entity_json_data['id']]));`
4. `if (empty($entity)) return TRUE;` — nothing exists locally, safe to import (create).
5. `$entity = reset($entity);` then `if ($entity->get('deleted')->isEmpty()) return TRUE;` — the local
   entity exists but is **not** trashed (Trash's `deleted` field is empty), so import normally (update).
6. Otherwise the local entity is in trash. It resolves a human label:
   uses `RuntimeImportContext::getFieldMappings()` + the storage's entity `label` key to find the
   JSON:API public field name, and reads `$entity_json_data['attributes'][$label_public_name]`
   (falls back to the UUID). It then:
   - `messenger()->addError(t('Trying to import a entity that is in trash (@e).', ...))`
   - `logger->warning('Entity that is in trash is not imported: "@e"', ...)`
   - returns **FALSE** → the entity is skipped.

## Why it exists

Without this processor, an entity imported earlier and later soft-deleted into Trash still appears as
"new"/importable in Entity Share. Re-importing it makes Entity Share create a fresh entity, which fails
with a 500 because the trashed entity still occupies that UUID. Returning FALSE here prevents that.

## Operating notes

- Nothing to configure; being `locked` it runs on every import while enabled.
- Skips are surfaced to the operator running the import (error message) and to the log
  (channel `piipe_entity_share`, warning level).
- To actually re-import a trashed entity, purge/restore it in Trash first so it is no longer `deleted`.
- Scope is per entity type + bundle: only types enabled in Trash are checked; everything else imports as usual.
