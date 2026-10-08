# webform_node permissions

Defined in `webform_node.permissions.yml`. These layer on top of core Webform access and
gate submission actions on the **node** that references a webform (`any` = all nodes,
`own` = nodes the user authored).

| Permission | Gates |
|---|---|
| `view webform submissions any node` | View submissions on any webform node |
| `view webform submissions own node` | View submissions only on own nodes |
| `edit webform submissions any node` | Edit submissions on any webform node |
| `edit webform submissions own node` | Edit submissions only on own nodes |
| `delete webform submissions any node` | Delete submissions on any webform node |
| `delete webform submissions own node` | Delete submissions only on own nodes |

Access is enforced by `Drupal\webform_node\Access\WebformNodeAccess`. Standard node
permissions (create/edit/delete Webform content) still apply to the node itself.
