# Node Weight permissions

Source: `node_weight.permissions.yml`, enforced in `node_weight.routing.yml`.

| Permission | Grants |
|---|---|
| `administer node weight` | The global settings form and per-type enable/disable (the "Node weight settings" group on node-type forms). Sensitive — creates/deletes fields. |
| `assign node weight` | Using the drag-and-drop "Manage order" screen for enabled types. Give this to editor/marketing roles that should reorder content without full admin. |

## Route → permission map

| Route | Path | Requirement |
|---|---|---|
| `node_weight.form` | `/admin/config/node-weight` | `administer node weight` |
| `node_weight.list` | `/admin/structure/node-weight` | `administer node weight` **+** `assign node weight` (both required) |
| `node_weight.order` | `/admin/structure/types/manage/{node_type}/order` | `administer node weight` **+** `assign node weight` |

Note the `+` in the routing requirements is an **AND** (Drupal joins multiple permissions in one
`_permission` string with `+` as logical AND), so `node_weight.list` and `node_weight.order` require a
user to hold **both** permissions.

## Menu/operation gating

- `hook_entity_operation_alter()` adds a "Manage order" operation on the content-types list only for
  users with `assign node weight`.
- The "Node weight settings" group injected into node-type add/edit forms is `#access`-gated by
  `administer node weight`.
- A menu-link derivative (`src/Plugin/Derivative/NodeWeightMenuLink.php`) creates a "Node weights"
  child link per enabled type under Structure, and (if `admin_toolbar_tools` is enabled) extra
  "Manage order" links under each content type's admin-toolbar entry.
