# Permissions

Defined in `openid_connect.permissions.yml` — all flagged `restrict access: TRUE`.

| Permission | Gates |
|---|---|
| `administer openid connect clients` | Full client admin: the client list, add/edit/delete/enable/disable routes, and the global settings form (`openid_connect.admin_settings`). Trusted/administrative. |
| `manage own openid connect accounts` | The per-user **Connected Accounts** form (`/user/{user}/connected-accounts`) — connect the user's own account to a provider. |
| `disconnect openid connected accounts` | Disconnect an external provider from a connected account. |
| `openid connect set own password` | Lets a user who authenticates via an external provider set a local password (needed before they can log in / disconnect locally). Checked by `OpenIDConnect::hasSetPasswordAccess()`. |

```
drush role:perm:add authenticated 'manage own openid connect accounts'
```

The redirect callback (`/openid-connect/{client}`), login (`/user/login/openid_connect`) and
logout routes use `_custom_access` / login-state requirements rather than these permissions.
