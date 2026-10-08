# Permissions

Defined in `o365.permissions.yml` (parent module only; submodules add their own).

| Permission | Title | Guards |
|---|---|---|
| `access o365 settings page` | Access Microsoft 365 Connector settings page | `o365.settings_form`, `o365.auth_scopes`, `o365.role_settings` |
| `access o365 debugger page` | Access Microsoft 365 Connector debugger page | `o365.debugger` (runs arbitrary GET Graph queries) |
| `administer o365 connectors` | Administer Microsoft 365 connectors | Entity admin permission — OR'd into every connector operation |
| `access o365 connectors` | Access Microsoft 365 connectors | `entity.o365_connector.collection` + entity `view` |
| `create o365 connector` | Create Microsoft 365 connector | `entity.o365_connector.add_form` + entity `create` |
| `edit o365 connector` | Edit Microsoft 365 connector | `entity.o365_connector.edit_form` + entity `update` |
| `delete o365 connector` | Delete Microsoft 365 connector | `entity.o365_connector.delete_form` + entity `delete` |

`administer o365 connectors` is flagged **`restrict access: true`** (core warns before granting it,
as it confers full control over every connector). `O365ConnectorAccessControlHandler` grants each
connector operation to the matching per-op permission OR the admin permission.

Grant via drush:

```bash
drush role:perm:add site_admin 'access o365 settings page'
drush role:perm:add site_admin 'access o365 connectors'
drush role:perm:add site_admin 'create o365 connector'
drush role:perm:add site_admin 'edit o365 connector'
drush role:perm:add site_admin 'delete o365 connector'
```
