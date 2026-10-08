# Permissions

Defined in `encrypt.permissions.yml`.

| Permission | Title | Gates |
|---|---|---|
| `administer encrypt` | Administer encryption settings | Create/edit/delete/test encryption profiles, change `encrypt.settings`, and access the profile collection. `restrict access: true` — trusted only. |

This is also the `admin_permission` of the `encryption_profile` config entity, so it governs
all the profile routes under `/admin/config/system/encryption/profiles` (including the
settings form at `.../profiles/settings`).

**Security note (from the permission's own description):** granting `administer encrypt` also
lets a user **decrypt arbitrary text with any encryption profile via the profile Test form**
(`.../profiles/manage/{id}/test`). Treat it as equivalent to read access to every profile's
plaintext capability, not merely a configuration permission — grant it only to fully trusted
roles.

Grant via drush:
```
drush role:perm:add administrator 'administer encrypt'
```
