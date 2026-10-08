# Permissions

Defined in `vault.permissions.yml`.

| Permission | Title | Gates |
|------------|-------|-------|
| `administer vault` | Administer Vault | The settings form/route `vault.admin` (`/admin/config/system/vault`) — Vault server URL, auth strategy + its config, lease TTL/renewal, lease-storage backend, and the read-cache TTL / clear-cache action. |

This is the module's only permission; the route requires it via `_permission: 'administer vault'`.

Grant to a role:

```bash
drush role:perm:add administrator 'administer vault'
```
