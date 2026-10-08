# Permissions

Static permissions in `masquerade.permissions.yml`; dynamic ones from
`MasqueradePermissions::permissions` (callback).

| Permission | Gates |
|---|---|
| `masquerade as any user except super user` | Impersonate any account except UID 1. Restricted. |
| `masquerade as super user` | Impersonate UID 1 (the super user). Restricted. |
| `masquerade as <role>` | One dynamic permission **per role** (except anonymous), e.g. `masquerade as editor`. Restricted; carries a config dependency on that role. |

- The dynamic per-role permissions let you grant "become an editor" without granting
  "become an admin". Anonymous is intentionally excluded (use private browsing instead).
- Access to the switch form/tab is checked by `_masquerade_switch_access`
  (`SwitchAccessCheck`), which combines these permissions with `hook_masquerade_access()`.
- `masquerade->getPermissions()` returns all permission names this module provides.

Grant via drush:
```
drush role:perm:add support 'masquerade as editor'
```
