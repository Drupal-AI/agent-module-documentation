# Programmatic API (services)

Entity Hierarchy defines no plugin types; it exposes services for reading/writing the tree.

## `entity_hierarchy.nested_set_storage_factory` (`NestedSetStorageFactory`)

Returns the nested-set storage for a given field + entity type.

```php
$factory = \Drupal::service('entity_hierarchy.nested_set_storage_factory');
$storage = $factory->get('field_parent', 'node');   // NestedSetStorage
$table   = $factory->getTableName('field_parent', 'node');       // nested_set_field_parent_node
```

`NestedSetStorage` proxies (via `__call`) the `previousnext/nested-set` `DbalNestedSet`,
so you get the library's read methods against a `NodeKey`:

- `getNode(NodeKey)`, `getAncestors(NodeKey)`, `getDescendants(NodeKey, $depth, $start)`,
  `getChildren(NodeKey)`, `getSiblings(NodeKey)`, `getRoot(NodeKey)`, `getTree()`.

## `entity_hierarchy.nested_set_node_factory` (`NestedSetNodeKeyFactory`)

Builds the `NodeKey` (entity id + revision id) a tree lookup needs:

```php
$key = \Drupal::service('entity_hierarchy.nested_set_node_factory')->fromEntity($node);
$ancestors = $storage->getAncestors($key);   // array of PNX\NestedSet\Node
```

## `entity_hierarchy.entity_tree_node_mapper` (`EntityTreeNodeMapper`)

Turns tree `Node` objects back into Drupal entities:

- `loadEntitiesForTreeNodesWithoutAccessChecks($entity_type_id, array $nodes, ?$cache)`
- `loadAndAccessCheckEntitysForTreeNodes($entity_type_id, array $nodes, ?$cache)` — respects
  view access; returns an `SplObjectStorage` mapping tree node → entity.

## `entity_hierarchy.information.parent_candidate` (`ParentCandidate`)

Answers "can this entity be a parent, and via which field":

- `getCandidateFields(EntityInterface $entity)` → hierarchy field names that could reference it.
- `getCandidateBundles(EntityInterface $entity)` → per-field bundles that may reference it.

## `entity_hierarchy.tree_rebuilder` (`TreeRebuilder`)

- `getRebuildTasks($field_name, $entity_type_id)` → Batch API task set that rebuilds a
  field's nested-set table from scratch (used by the Drush command).

## Field item list

`EntityReferenceHierarchyFieldItemList::postSave()` performs the tree write on entity save;
`getConstraints()` attaches `ValidHierarchyReferenceConstraint` (prevents choosing a parent
that would create a loop). You normally do not call these directly — just save the entity
with the field set and the tree updates itself (unless writes are disabled, see
[../drush/commands.md](../drush/commands.md)).
