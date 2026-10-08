<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `migrate_sandbox.permissions.yml`. One permission gates the whole module.

| Permission | Title | Flags | Grants |
| --- | --- | --- | --- |
| `access migrate_sandbox` | Access and Use Migrate Sandbox | `restrict access: true` | The `migrate_sandbox.settings_form` route (`/admin/config/development/migrate-sandbox`) and every AJAX action on that form. |

- This is the only requirement on the route (`_permission: 'access migrate_sandbox'`).
- `restrict access: true` means Drupal flags it on the People → Permissions page as one to
  grant with care; it is not given to any role by default.
- There are no per-operation or entity-level checks beyond this single permission — anyone
  with it can use the full form (run pipelines, populate from real migrations, etc.).

Grant to a role via drush:

```bash
drush role:perm:add ROLE_NAME 'access migrate_sandbox'
```
