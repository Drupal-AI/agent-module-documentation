# Permissions

Defined in `conditional_fields.permissions.yml`; enforced on the routes in
`conditional_fields.routing.yml`.

| Permission | Gates |
|---|---|
| `view conditional fields` | See the Conditional Fields listings, bundle lists, and the "Manage Dependencies" tabs (all list/overview routes). |
| `edit conditional fields` | Create and edit dependencies (`conditional_fields.edit_form` and its tab variant). |
| `delete conditional fields` | Delete dependencies (`conditional_fields.delete_form` and its tab variant). |

All three are administrative; grant only to trusted roles since dependencies affect data-entry
forms site-wide.
