# Node Keep permissions

| Permission | Gates |
|---|---|
| `administer node_keep` | Access to the global settings form (`/admin/config/content/node-keep`). |
| `administer node_keep per node` | The right to **change** the `node_keeper` / `alias_keeper` checkboxes on a node, and to delete a protected node. Users without it are blocked from deleting protected nodes and see the checkboxes disabled. This is the permission that "bypasses" Node Keep protection. |
| `access node_keep widget` | Whether the "Node keep" checkboxes are visible at all on the node form. Without it the elements are `#access = FALSE` (even for those who could otherwise change them). |

Note: `bypass node access` (core) also lets a user delete any node regardless of Node Keep, since
protection is enforced through `hook_node_access()`.
