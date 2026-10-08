# Field type & services

## The `cached_moderation_state` field type

`Plugin/Field/FieldType/CachedModerationStateItem` — id `cached_moderation_state`, `no_ui`,
cardinality 1. Columns/properties:

- `value` (string, `varchar_ascii` 191) — the cached moderation state id (e.g. `draft`).
- `updated` (timestamp) — when the cache value was last written.

Its distinctive behaviour: **it computes its own value**. Every accessor (`get`, `getValue`,
`getString`, `isEmpty`, `__get`, `preSave`, `set`, `setValue`, …) calls `updateItemValue()`, which
writes `value` from `$this->getEntity()->moderation_state?->value` and `updated` from the current
time. You cannot meaningfully set it to an arbitrary value — it always reflects the entity's real
moderation state on save. Read it, don't write it:

```php
$state = $entity->cached_moderation_state->value;
```

The field is hidden from the Field UI via `HiddenFieldConfig` (swapped in by
`hook_entity_bundle_field_info_alter`) and UI access is forbidden by `hook_entity_field_access`.

## Service: `cached_moderation_state.field_config_handler`

`FieldConfigHandler` (interface `FieldConfigHandlerInterface`). Manages the field instances.

| Method | Purpose |
|---|---|
| `sync(): static` | Create the field on all moderated bundles, delete it from unmoderated ones. Runs on install + workflow save; call manually to repair. |
| `getCachedModerationStateFields()` | All `FieldConfig` instances of the field type. |
| `getModeratedEntityTypes()` | Entity types that have at least one moderated bundle. |
| `getModeratedBundlesForEntityType($entity_type)` | Moderated bundles for a type. |
| `shouldModerateEntitiesOfBundle($entity_type, $bundle)` | Whether a bundle is moderated. |

## Service: `cached_moderation_state.batch_update_handler`

`BatchUpdateHandler` (interface `BatchUpdateHandlerInterface`). Back-fills cached values for
existing content.

| Method | Purpose |
|---|---|
| `getEntitiesForEntityType($entity_type_id, $bundles = [], $only_uninitialized = FALSE)` | Collect `"<type>:<id>"` identifiers (all revisions for revisionable types); optionally only those with an empty cached field (`notExists('cached_moderation_state.updated')`). |
| `updateEntities(array &$entity_ids, int $batch_size = 0): int` | Load and re-save a batch, updating the cached value. |
| `updateEntity(EntityInterface $entity)` | Re-save one entity with syncing on / revisions suppressed. |
| `isEntityUpdateInProgress(): bool` | Used by `hook_entity_presave` to suppress new revisions during batch. |

These services back the batch form and the Drush commands (see
[../drush/commands.md](../drush/commands.md)).
