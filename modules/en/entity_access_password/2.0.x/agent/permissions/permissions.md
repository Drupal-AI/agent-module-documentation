# Permissions

Both are `restrict access: TRUE` (grant only to trusted roles).

| Permission | Gates |
|---|---|
| `administer_entity_access_password` | The settings form (`/admin/config/content/entity_access_password/settings`) and the module's admin config landing page. |
| `bypass_password_protection` | Holder always has access to protected entities — the password form is never shown (checked first, via `BypassPermissionAccessChecker`). |

There is no permission for "may unlock" — any user who can reach a protected view mode may submit the
password form (subject to `user.flood` rate limits). The user-data-backend submodule adds its own
`restrict access: TRUE` permissions for the manual access-grant admin forms.
