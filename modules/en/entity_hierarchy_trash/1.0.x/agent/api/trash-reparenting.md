<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Trash-triggered reparenting

How `entity_hierarchy_trash` keeps an entity_hierarchy tree consistent when a parent is
soft-deleted. All behavior lives in two classes; there is no config to tune.

## Install / enable

`composer require drupal/entity_hierarchy_trash` then enable it with its dependencies
(`entity_hierarchy` 5.x and `trash`). No post-install steps, no configuration. It starts acting
automatically on trash operations.

## Entry point — the hook

`src/Hook/EntityHierarchyTrashHook.php`, service `entity_hierarchy_trash.hooks`.

- `entityHierarchyTrashEntityUpdate(EntityInterface $entity): void` — attribute
  `#[Hook('entity_update')]`. Runs on *every* entity update but returns immediately unless all of:
  1. `$entity instanceof ContentEntityInterface`,
  2. `$entity->hasField('deleted')`,
  3. `!empty($entity->get('deleted')->getValue())`.

  The `deleted` field is added by the Trash module; a non-empty value means the entity has just
  been moved to trash. Only then does it resolve
  `ParentEntityTrashUpdater` via `ClassResolverInterface::getInstanceFromDefinition()` and call
  `moveChildren($entity)`.
- `entity_hierarchy_trash.module` provides `entity_hierarchy_trash_entity_update()`
  (`#[LegacyHook]`) as the procedural bridge; it just forwards to the service. On Drupal that
  supports OOP hooks the attribute wins; the function keeps older invocation paths working.

## Reparenting logic

`src/Storage/ParentEntityTrashUpdater.php` — implements `ContainerInjectionInterface`, injected
with entity_hierarchy's `entity_hierarchy.information.parent_candidate`
(`ParentCandidateInterface`) and `entity_hierarchy.query_builder_factory` (`QueryBuilderFactory`).

`moveChildren(ContentEntityInterface $entity): void`:

1. Returns early if `!$entity->isDefaultRevision()` — pending/non-default revisions are ignored.
2. `parentCandidate->getCandidateFields($entity)` lists the entity_hierarchy parent fields that
   could point at this entity; returns early if there are none.
3. For each such `$field_name`, builds a query with
   `queryBuilderFactory->get($field_name, $entity->getEntityTypeId())`, then:
   - `$queryBuilder->findChildren($entity)` — the descendant records;
   - `$queryBuilder->findParent($entity)` — the trashed entity's own parent (may be null).
4. For each child record: it **skips the record whose id equals the trashed entity's id** (that
   row represents the entity being trashed — its parent value is intentionally left intact so the
   entity can be restored back under the same parent). Every other child has its parent field set
   to `$parent?->id()` (the grandparent, or `null` → root) and is re-saved with
   `$child_node->save()`.

Net effect: children of a trashed parent are pulled up one level (to the grandparent, or to the
tree root), while the trashed entity itself retains its hierarchy position for a clean restore.
This mirrors entity_hierarchy's own hard-delete reparenting (`ParentEntityRevisionUpdater`) but is
driven by the Trash soft-delete update instead of a real delete.

## Operating notes

- Acts only on default-revision trash operations; restoring from trash is handled by the Trash
  module and by the preserved parent reference — this module does not add a restore hook.
- Each affected child is saved individually, so trashing a parent with many descendants triggers
  one entity save per child (plus any downstream save side-effects). This is a maintenance cost,
  not a configurable batch.
- Works for any entity type entity_hierarchy manages, across every configured parent field.
