# Hierarchy API

Two services expose the group hierarchy. Prefer the manager for entity-level work; drop to
the graph storage for raw IDs / paths.

## `ggroup.group_hierarchy_manager` — `GroupHierarchyManager`

Constructed with the graph storage, entity type manager and `group.membership_loader`.
All `$group_id` args are integer group IDs.

| Method | Returns | Notes |
|---|---|---|
| `addSubgroup(GroupRelationshipInterface $r)` | void | records a parent→child edge; throws `\InvalidArgumentException` if the relationship isn't a group→group one or either group is unsaved. Called automatically by `hook_group_relationship_insert`. |
| `removeSubgroup(GroupRelationshipInterface $r)` | void | removes the edge (and implied edges). Called by `hook_group_relationship_delete`. |
| `groupHasSubgroup(GroupInterface $g, GroupInterface $sub)` | bool | true if `$sub` is anywhere in `$g`'s descendants. |
| `getGroupSubgroups($group_id)` | `GroupInterface[]` | all descendant groups, loaded. |
| `getGroupSubgroupIds($group_id)` | `int[]` | descendant IDs (all levels). |
| `getGroupSupergroups($group_id)` | `GroupInterface[]` | all ancestor groups, loaded. |
| `getGroupSupergroupIds($group_id)` | `int[]` | ancestor IDs (all levels). |

```php
$mgr = \Drupal::service('ggroup.group_hierarchy_manager');
$child_ids = $mgr->getGroupSubgroupIds($group->id());   // every descendant, any depth
$parents   = $mgr->getGroupSupergroups($group->id());   // loaded ancestor groups
```

## `ggroup.group_graph_storage` — `SqlGroupGraphStorage`

Raw graph over the `group_graph` table (a materialised transitive closure; `hops` = 0 for a
direct edge). Args are group IDs.

| Method | Returns | Notes |
|---|---|---|
| `addEdge($parent, $child)` | int\|false | inserts the direct edge + all implied edges; `false` if parent==child; throws `CyclicGraphException` if it would create a cycle. |
| `removeEdge($parent, $child)` | void | deletes the edge and every implied edge derived from it. |
| `getDescendants($gid)` / `getAncestors($gid)` | `int[]` | all descendants / ancestors (direct + implied). |
| `getDirectDescendants($gid)` / `getDirectAncestors($gid)` | `int[]` | only immediate children / parents (`hops = 0`). |
| `isDescendant($a,$b)` / `isAncestor($a,$b)` | bool | is `$a` a descendant / ancestor of `$b`. |
| `isDirectDescendant($a,$b)` / `isDirectAncestor($a,$b)` | bool | immediate relationship only. |
| `getPath($ancestor,$descendant)` | `int[][]` | BFS list of all vertex paths ancestor→descendant; `[]` if not related. |
| `getGraph($gid)` | records | raw `start_vertex`/`end_vertex` rows touching `$gid`, ordered by hops. |

Lookups are cached: per-request static caches (`ancestors`/`descendants`/`directAncestors`/
`directDescendants`) plus a persistent `cache.default` entry `ggroup_graph_map:<gid>` tagged
`group:<id>`; edge changes call `invalidate()` on the affected group cache tags. You normally
mutate the graph by saving/deleting `group_relationship` entities (the module keeps the table
in sync via hooks), not by calling `addEdge`/`removeEdge` directly.
