# Permissions

## Static (`apigee_edge.permissions.yml`)

| Permission | Grants | Restricted |
|---|---|---|
| `administer apigee edge` | All config forms under `/admin/config/apigee-edge` + developer sync routes. | yes |
| `bypass api product access control` | Skips every API-product visibility/RBAC check — user sees and can assign **all** API products. | yes |

## Generated `developer_app` entity permissions

`developer_app` uses `DeveloperAppPermissionProvider` (extends the `entity` module's
`UncacheableEntityPermissionProvider`), so it produces the standard own/any entity permissions **plus**
app-key-specific ones. `{type}` = `developer_app`:

- Standard: `administer developer_app`, `access developer_app overview`,
  `view own|any developer_app`, `create developer_app`, `update own|any developer_app`,
  `delete own|any developer_app`.
- Added by this module: `analytics own|any developer_app`, `add_api_key own|any developer_app`,
  `revoke_api_key own|any developer_app`, `delete_api_key own|any developer_app`,
  `edit_api_products developer_app`.

Route `apigee_edge.user.apps` (`/user/apps`, "My apps") requires `view own developer_app`.

`api_product` and `developer` do **not** generate entity permissions here — API-product access is
decided by `hook_api_product_access` (see [../hooks/hooks.md](../hooks/hooks.md)); developer access
follows the mapped Drupal user.

The **Teams** submodule adds team-scoped permissions and a per-team role system — see
`apigee_edge_teams` [permissions](../../modules/apigee_edge_teams/4.1.x/agent/permissions/permissions.md).
