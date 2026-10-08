# Permissions

Defined in `acquia_connector.permissions.yml`.

| Permission | Gates |
|---|---|
| `view acquia connector toolbar` | Whether the user sees the Acquia Connector item in the admin toolbar (`hook_toolbar()`). |

There is no dedicated permission for connecting/configuring the subscription. All setup and
settings routes (`acquia_connector.settings`, `setup_oauth`, `setup_manual`,
`setup_configure`, `refresh_status`, `auth.begin`, `auth.return`) are gated by the core
**`administer site configuration`** permission instead.

The JSON status endpoint (`acquia_connector.status`) uses a custom access check (nonce + hash),
not a permission.

```
drush role:perm:add administrator 'view acquia connector toolbar'
```
