# Permissions

Defined in `entity_mesh.permissions.yml`. Both are `restrict access: true`.

| Permission | Gates |
|---|---|
| `administer entity_mesh configuration` | The settings form (`/admin/config/system/entity-mesh`) and cron form (`/admin/config/system/entity-mesh/cron`). |
| `access entity_mesh report` | The Overview report (`/admin/reports/entity-mesh`), the Views report displays, and the "referenced elsewhere" warnings injected into node/media delete forms. |

The delete-form warnings (`hook_form_alter` / `hook_form_node_delete_multiple_confirm_form_alter` in
`EntityMeshHooks`) are only added for users holding `access entity_mesh report`.

Note: link analysis itself does not use the acting user's permissions — it renders content as the configured
**analyzer account** (default: anonymous), so which links count as accessible is a deliberate config choice,
not tied to whoever triggered the save. See [../configure/settings.md](../configure/settings.md).
