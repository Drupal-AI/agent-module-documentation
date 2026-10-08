# Permissions

Defined in `vapn.permissions.yml`:

| Permission | Machine name | Gates |
|---|---|---|
| Administer VAPN | `administer vapn` | Access the settings form (`/admin/config/people/vapn`, route `vapn.settings`) to choose which content types use VAPN. Also grants edit access to the `vapn` field. `restrict access: true`. |
| Use VAPN | `use vapn` | Edit access to the per-node `vapn` role field on the node form (`hook_entity_field_access`). A user with either `use vapn` or `administer vapn` may set the roles; without either, the field is forbidden (hidden). |
| Bypass VAPN | `bypass vapn` | Always allowed to **view** any VAPN-restricted node, ignoring the selected roles (`hook_node_access` returns allowed early). Give this to admin/superuser-style roles. |

## Interaction with view access

`vapn_node_access()` (op `view`):
1. `bypass vapn` → allowed.
2. else compare the node's selected roles with the user's roles → allowed if they intersect,
   forbidden if not (when at least one role is selected), neutral if none selected.

`vapn_entity_field_access()` restricts editing the `vapn` field itself to users with
`administer vapn` or `use vapn`.

Note: core's *bypass node access* permission also lets a user view everything (and such roles
are excluded from the VAPN role checkboxes).
