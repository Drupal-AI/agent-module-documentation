# Permissions

The module defines exactly one permission (`better_passwords.permissions.yml`):

| Permission | Machine key | Gates |
|---|---|---|
| Administer Better Passwords | `administer better passwords` | Access to the settings form at `/admin/config/people/passwords` (route `better_passwords.admin_settings`). |

- It is the `_permission` requirement on the only route the module adds.
- It is **not** a "restricted" permission but controls policy that affects every account, so
  grant it only to trusted admin roles.
- On update, `better_passwords_update_10001()` auto-grants it to roles that already hold
  `administer site configuration`.
- The password **rules themselves** are enforced for *all* users regardless of permission —
  this permission only controls who can change the policy.
