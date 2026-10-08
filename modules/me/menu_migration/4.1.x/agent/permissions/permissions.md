<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `menu_migration.permissions.yml` (five permissions). The first three are
`restrict access: true` (admin-grade).

| Machine name | Gates |
|---|---|
| `administer menu migration` | Everything — **bypasses** every other menu_migration permission; also grants access to Quick Action Settings. |
| `administer menu migration export types` | Add / edit / delete / export Menu Export (`mm_export_type`) entities. Admin permission of that entity type. |
| `administer menu migration import types` | Add / edit / delete / import Menu Import (`mm_import_type`) entities. Admin permission of that entity type. |
| `perform export on menu migrations` | Access the Menu Exports listing and run exports (collection permission of `mm_export_type`), without edit rights. |
| `perform import on menu migrations` | Access the Menu Imports listing and run imports (collection permission of `mm_import_type`), without edit rights. |

The top-level UI at `/admin/config/development/menu-migration` also requires core
`access administration pages` (route requirement is `access administration pages+administer
menu migration`). The Quick Action Settings form requires `administer menu migration`.

Grant example:

```bash
drush role:perm:add editor 'perform export on menu migrations'
```
