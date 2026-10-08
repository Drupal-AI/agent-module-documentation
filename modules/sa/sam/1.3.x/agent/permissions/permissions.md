# Permissions

Defined in `sam.permissions.yml`. SAM provides a single permission.

| Permission | Gates |
|---|---|
| `administer sam` | Access to the Simple Add More settings form (`sam.admin_settings`, `/admin/config/content/simple-add-more-settings`) — editing the add-more/remove button labels and the singular/plural help text. Marked `restrict access: true` (trusted/administrative). |

Note: the front-end simplification behavior itself is not permission-gated — it applies on any
content form where a supported, limited-cardinality widget is rendered. The per-widget
"skip simplification" opt-out is part of the **Manage form display** UI, gated by the normal
`administer …form display` permissions, not by `administer sam`.

```
drush role:perm:add content_admin 'administer sam'
```
