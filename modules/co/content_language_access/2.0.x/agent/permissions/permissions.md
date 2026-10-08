# content_language_access — permissions

Two permissions (`content_language_access.permissions.yml`):

| Permission | Gates |
|---|---|
| `administer content_language_access settings` | Access to the config form at `/admin/config/regional/content_language_access` (the language allow-matrix, `access_bypass`, and `route_list`). Grant only to trusted admins. |
| `bypass content_language_access` | Exempts the user entirely from the language check. In `hook_node_access()` this is the **first** test: if held, the hook returns `neutral()` before any language comparison, so the user can view published nodes in any language regardless of the negotiated language or the matrix. |

Notes:

- Neither permission is marked `restrict access: true`, but both are effectively administrative —
  `bypass content_language_access` removes the entire feature for that role, so treat it like an
  access-control bypass and grant it narrowly.
- Anonymous users typically hold neither, so the mismatch-denial applies to them as intended.
