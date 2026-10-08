<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Deletion behavior & the field-manager service

## When deletion happens
`composite_reference_entity_predelete(EntityInterface $entity)` runs on every entity delete. For each
`entity_reference` / `entity_reference_revisions` field definition on the entity it calls
`CompositeReferenceFieldManager::entityDelete($entity, $definition)`. Non-fieldable entities are
skipped.

## Service — `composite_reference.composite_reference_field_manager`
Class `CompositeReferenceFieldManager` (interface `CompositeReferenceFieldManagerInterface`),
constructed with `entity_type.manager`, `entity_field.manager`, `database`.

### `entityDelete(EntityInterface $entity, FieldDefinitionInterface $field_definition): void`
1. Returns early unless the field is composite (`isCompositeField()` — reads the third-party setting
   for `FieldConfig`/`BaseFieldOverride`, or the `composite_reference['composite']` setting for a
   `BaseFieldDefinition`).
2. Gets the referenced entities. If the field is **not** composite-revisions, uses the current
   revision's `referencedEntities()`. If it **is** (`isCompositeRevisionsField()`), queries the
   field's dedicated revision table (e.g. `node_revision__field_name`) — or the entity revision data
   table as fallback — for every value ever referenced, and loads those.
3. For each referenced entity, calls `getReferencingEntities()` and removes the host entity from the
   result; if **no other** entity references it (and it isn't the host itself, by UUID), it is
   `->delete()`d.

### `getReferencingEntities(EntityInterface $entity): array`
Returns all entities that reference `$entity`. Builds an `OR` entity query per entity type over every
`entity_reference` + `entity_reference_revisions` field that targets `$entity`'s type (from
`getFieldMapByFieldType`), including **all revisions** for revisionable types, with
`accessCheck(FALSE)`. Used to decide whether a referenced entity is safe to delete (shared references
are preserved).

## Notes for callers
- The shared-reference guard means a composite entity referenced by more than one host will **not**
  be deleted until the last reference is gone — intended for single-parent ownership.
- `accessCheck(FALSE)` is deliberate: the shared-reference count must be complete regardless of the
  acting user's view access. Deletion of the child still goes through the entity's own delete path.
