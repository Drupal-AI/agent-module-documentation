# Subgroup API — handlers, wrappers, calculator, events

## The `subgroup` entity handler (`SubgroupHandlerInterface`)

Registered by `subgroup_entity_type_alter()` on both `group` and `group_type`
(`GroupSubgroupHandler` / `GroupTypeSubgroupHandler`, extend `SubgroupHandlerBase`). Load with:

```php
$handler = \Drupal::entityTypeManager()->getHandler('group', 'subgroup');       // for groups
$typeHandler = \Drupal::entityTypeManager()->getHandler('group_type', 'subgroup'); // for group types
```

Methods (identical on both):
- `isLeaf($entity)` / `isRoot($entity)` — whether it's in a tree / is the tree root.
- `areVerticallyRelated($a, $b)` — TRUE if one is an ancestor/descendant of the other.
- `initTree($entity)` — make `$entity` the root of a new tree.
- `addLeaf($parent, $child)` / `removeLeaf($entity, $save = TRUE)` — grow/shrink the tree.
- `getParent`, `getAncestors`, `getChildren`, `getDescendants` — navigation (return entities).
- `getDescendantCount`, `hasDescendants` — safety/optimization checks.
- `getTreeCacheTags($entity)` — cache tags to invalidate everything using the tree.
- `wrapLeaf($entity)` — returns a `LeafInterface` wrapper (`GroupLeaf` / `GroupTypeLeaf`).

## Leaf wrappers (`LeafInterface`)

`wrapLeaf()` returns a lightweight object exposing the nested-set bounds without reloading fields:
`getDepth()`, `getLeft()`, `getRight()`, `getTree()`. Used heavily by the permission calculator and the
settings form.

## Permission calculator

`Drupal\subgroup\Access\InheritedGroupPermissionCalculator` implements the `group`/`flexible_permissions`
`PermissionCalculatorBase` for the `individual` scope. You normally don't call it directly — group access
(`hasPermission` in a group, query access) picks up inherited permissions automatically. It adds
inherited role permissions as individual-scope `CalculatedPermissionsItem`s and registers the right cache
tags (`subgroup_role_inheritance_list:tree:<id>`, tree cache tags, membership dependencies).

## Events (`LeafEvents`)

Dispatched when a group or group type enters/leaves a tree — subscribe to react (e.g. sync external ACLs):

| Constant | Event object | Fired when |
|---|---|---|
| `LeafEvents::GROUP_LEAF_ADD` / `GROUP_LEAF_REMOVE` | `GroupLeafEvent` | a **group** becomes / stops being a leaf. |
| `LeafEvents::GROUP_TYPE_LEAF_ADD` / `GROUP_TYPE_LEAF_REMOVE` | `GroupTypeLeafEvent` | a **group type** is added to / removed from a tree. |
| `LeafEvents::GROUP_TYPE_LEAF_IMPORT` | `GroupTypeLeafEvent` | a leaf group type arrives via config import/sync. |

```php
public static function getSubscribedEvents(): array {
  return [LeafEvents::GROUP_LEAF_ADD => 'onLeafAdd'];
}
public function onLeafAdd(GroupLeafEvent $event): void {
  $group = $event->getGroup();
}
```

## Structural guards (hooks in `subgroup.module`)

Enforced automatically, all fail-closed — useful to know when writing code that manipulates groups:
`subgroup_entity_access`/`subgroup_entity_predelete` forbid deleting a leaf with descendants;
`subgroup_group_relationship_access` forbids deleting the `subgroup` relationship directly;
`subgroup_group_relationship_predelete` forbids deleting it while its child group still exists;
`subgroup_group_create_access` forbids globally creating a group of a non-root-leaf type.
