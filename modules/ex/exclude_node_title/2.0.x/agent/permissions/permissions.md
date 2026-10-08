# Permissions

Defined in `exclude_node_title.permissions.yml`.

| Permission | Gates |
|---|---|
| `administer exclude node title` | Access to the settings form (`exclude_node_title.settings`) where per-content-type / view-mode exclusion and render type are configured. `restrict access: TRUE` (administrative/trusted). |
| `exclude any node title` | On content types set to **User defined** mode, lets the user toggle the "Exclude title from display" checkbox on the node edit form for **any** node. |
| `exclude own node title` | Same node-edit checkbox, but only for nodes the current user owns (`$account->id() == $node->getOwnerId()`). |

The node-edit checkbox (`exclude_node_title`) only appears when the node's content type is in
`user` exclude mode **and** the current user has `exclude any node title`, or `exclude own node title`
for their own node (see `ExcludeNodeTitleHooks::checkPerm()` / `formNodeFormAlter()`). Checking it adds
the node id to the State-stored exclude list on save (`node_insert` / `node_update`); deleting the node
removes it.

```
drush role:perm:add editor 'exclude own node title'
```

