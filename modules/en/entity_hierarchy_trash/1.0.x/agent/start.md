<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Hierarchy Trash Support (entity_hierarchy_trash) — agent index

Bridge module that makes **Entity Hierarchy** tree maintenance run when a parent entity is
**soft-deleted by the Trash module**. Package `Entity Hierarchy`. Core `^10.5 || ^11.2`.
License GPL-2.0-or-later. Version **1.0.0-alpha1** (alpha, not security-covered).

Depends on `entity_hierarchy` (Composer `drupal/entity_hierarchy:^5.0`) and `trash`.

## What it actually is

- **No** routes, permissions, config schema, config/install, plugins, Drush commands, libraries
  or settings form. It is one hook plus one storage helper.
- One service: **`entity_hierarchy_trash.hooks`** → `Drupal\entity_hierarchy_trash\Hook\EntityHierarchyTrashHook`
  (`autowire: true`), in `entity_hierarchy_trash.services.yml`.
- One legacy bridge in `entity_hierarchy_trash.module`: `entity_hierarchy_trash_entity_update()`
  (marked `#[LegacyHook]`) delegates to the OOP hook.

## Mechanism (from source)

- `EntityHierarchyTrashHook::entityHierarchyTrashEntityUpdate()` (attribute `#[Hook('entity_update')]`)
  fires on **every** entity update. It acts only when the entity is a `ContentEntityInterface`,
  `hasField('deleted')`, and that `deleted` value is non-empty — i.e. the update is the Trash
  module marking the entity as soft-deleted. It then class-resolves
  `ParentEntityTrashUpdater` and calls `moveChildren($entity)`.
- `ParentEntityTrashUpdater::moveChildren()` reparents the trashed entity's children.

Detail → [api/trash-reparenting.md](api/trash-reparenting.md)
