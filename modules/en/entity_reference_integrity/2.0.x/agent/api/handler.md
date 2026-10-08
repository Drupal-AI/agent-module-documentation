# Entity Reference Integrity — handler & field-map API

## Getting the handler

Every entity type gets an `entity_reference_integrity` handler (added in
`entity_reference_integrity_entity_type_alter()` unless one already exists):

```php
$handler = \Drupal::entityTypeManager()
  ->getHandler($entity->getEntityTypeId(), 'entity_reference_integrity');
```

`EntityReferenceIntegrityEntityHandler` implements
`EntityReferenceIntegrityEntityHandlerInterface`:

| Method | Returns | Notes |
|---|---|---|
| `hasDependents(EntityInterface $entity)` | `bool` | TRUE as soon as any referencing entity is found (counts, short-circuits). |
| `getDependentEntityIds(EntityInterface $entity)` | `array` | `[source_entity_type_id => [id, id, …]]`. |
| `getDependentEntities(EntityInterface $entity)` | `array` | Same shape but loaded entities. |
| `EntityReferenceIntegrityEntityHandler::getAccessDeniedReason($entity, $translate = TRUE)` | `string` (static) | "Can not delete the … as it is being referenced by another entity." |

Internally `referentialEntityQuery()` builds one entity query per source entity type with
`accessCheck(FALSE)` and an OR condition group over each referencing field
(`condition($field, $target_id, '=')`).

## The field-map service

`entity_reference_integrity.field_map` → `DependencyFieldMapGenerator`, constructed with the
field type `entity_reference` and the target-type settings key `target_type`
(see `entity_reference_integrity.services.yml`).

```php
$map = \Drupal::service('entity_reference_integrity.field_map');
$fields = $map->getReferencingFields('taxonomy_term');   // [source_type => [field, …]]
$full   = $map->getReferentialFieldMap();                // target => source => [fields]
```

`getReferentialFieldMap()` walks `EntityFieldManager::getFieldMapByFieldType('entity_reference')`
and, for each field, records `map[target_type][source_type][] = field_name`. It skips:
- fields with no storage definition (e.g. computed fields),
- fields with custom storage (`hasCustomStorage()`, e.g. term parents),
- revision-metadata-key fields.

## What it does NOT do

The base module only *answers questions*. It does not alter delete forms, deny access, or
throw on delete — enable `entity_reference_integrity_enforce` for that (it consumes this same
handler). To build custom enforcement, decorate/reuse the handler and act on `hasDependents()`.
