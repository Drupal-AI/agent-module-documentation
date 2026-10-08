# The `group_node` relation plugin

`Drupal\gnode\Plugin\Group\Relation\GroupNode` is a `GroupRelationType` plugin (see the parent
module's [plugins doc](../../../../3.3.x/agent/plugins/group.md)) that makes nodes groupable.

Attribute:

```php
#[GroupRelationType(
  id: 'group_node',
  entity_type_id: 'node',
  label: new TranslatableMarkup('Group node'),
  description: new TranslatableMarkup('Adds nodes to groups both publicly and privately.'),
  reference_label: new TranslatableMarkup('Title'),
  reference_description: new TranslatableMarkup('The title of the node to add to the group'),
  entity_access: TRUE,
  deriver: 'Drupal\gnode\Plugin\Group\Relation\GroupNodeDeriver',
)]
```

- **Deriver** (`GroupNodeDeriver`) loops over every `NodeType` and produces a derivative
  `group_node:{node_type}` with per-bundle label/description and `entity_bundle` set to the
  node type. So you install `group_node:article`, `group_node:page`, etc. — one per type.
- **`entity_access: TRUE`** means node access is routed through the group's per-group
  permissions once a node is grouped.
- Entity cardinality is forced to **1** (a node belongs to at most one group), and the
  cardinality field is disabled in the plugin's configuration form.
- `calculateDependencies()` adds a config dependency on the `node.type.{bundle}`.

## Relate a node in code

```php
$group->addRelationship($node, 'group_node:article');       // relate an existing node
$nodes = $group->getRelatedEntities('group_node:article');  // all article nodes in the group
```

## Installing it

Install the plugin on a group type via the parent Group **content** page
(`/admin/group/types/manage/{group_type}/content`), which creates a
`group_relationship_type`. `gnode_node_type_insert()` clears the relation-type manager cache
whenever a new node type is created so its derivative appears.
