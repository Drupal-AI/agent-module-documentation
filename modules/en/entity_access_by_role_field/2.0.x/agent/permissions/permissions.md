<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Access by Role Field permissions

One permission (`entity_access_by_role_field.permissions.yml`):

- **`bypass entity_access_by_role_field permissions`** — "Bypass 'Entity Access by Role Field'
  permissions". `restrict access: true` (marked as a security-sensitive permission). A user with
  this permission short-circuits all role-access-field logic and is always allowed
  (`AccessResult::allowed()->cachePerPermissions()`).

Grant with drush:

```bash
drush role:perm:add administrator 'bypass entity_access_by_role_field permissions'
```

This is the only permission the module defines; everything else is controlled per entity through
the field value and the field instance's `operations` / `empty_roles_access_fallback` settings
(see `configure/field.md`).
