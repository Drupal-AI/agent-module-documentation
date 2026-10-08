<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `pathauto_entity_parent` base field

## Definition

Declared in `EntityBaseFieldInfoHooks::entityBaseFieldInfo()` via `hook_entity_base_field_info`,
only for `$entity_type->id() === 'node'`:

- **Type:** `entity_reference`
- **Target:** `target_type: node`, `handler: default`
- **Label:** *Parent* / description mentions `/parent-node/child-node`
- **Cardinality:** single (default)
- **Form widget:** `entity_reference_autocomplete` (weight 31, `match_operator: CONTAINS`,
  size 60), `setDisplayConfigurable('form', TRUE)`
- No view display is configured — the field carries the relationship, it is not meant to be printed.

Because it is a base field returned for the `node` entity type unconditionally, it lives on **every
node bundle** in storage. Bundle *selection* (config `pathauto_entity_parent.settings:bundles`)
only governs whether the widget is shown and whether the alias prepend runs — see `configure/`.

## Reading / setting it programmatically

It behaves like any single-value entity-reference field on a node:

```php
// Read the parent node id / entity.
$pid = $node->get('pathauto_entity_parent')->getString(); // '' when unset
$parent = $node->get('pathauto_entity_parent')->entity;   // NodeInterface|null

// Set a parent, then (re)generate the alias so the prepend takes effect.
$node->set('pathauto_entity_parent', $parent_nid);
$node->save();
\Drupal::service('pathauto.generator')->updateEntityAlias($node, 'update');
```

`PathautoPatternAlterHooks` reads exactly this: `getString()` for the id, then `Node::load()` and
`AliasRepository::lookupBySystemPath('/node/<pid>', <langcode>)`. Setting a parent whose target node
has no stored alias yields no prepend (the lookup returns empty and the pattern is left unchanged).

## Storage / lifecycle

- Installed and removed by `hook_install` / `hook_uninstall` through
  `EntityDefinitionUpdateManager::updateEntityType('node')`.
- Stored on `node_field_data` (column `pathauto_entity_parent`). `StorageHelper` writes it directly
  with a parameterized `UPDATE ... SET pathauto_entity_parent = NULL WHERE type IN (:bundles)` when
  a bundle is de-selected.
- There is **no referential cleanup**: deleting a node that is used as a parent leaves the child's
  reference dangling. On the next alias generation the parent `Node::load()` returns null and the
  child simply gets its un-prepended pattern.
