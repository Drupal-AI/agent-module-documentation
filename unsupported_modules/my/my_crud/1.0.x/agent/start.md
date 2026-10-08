<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# my_crud - agent index

**my_crud** (project `basic_crud_operation_in_drupal_sites`) is an example CRUD module over a custom `my_crud` table. Version **1.0.0** (`1.0.x`). Core `^8 || ^9 || ^10`.

## Key files
- `src/Controller/MycrudController.php` - `/my_crud` listing (`access content`).
- `src/Form/MycrudForm.php` - add/edit; `src/Form/DeleteForm.php` - delete.

## Notes
- DB access uses parameterized `->condition()` (no SQLi observed).
- Add/edit/delete routes use `_permission: 'TRUE'` (not a real permission) - effectively admin/uid1-only; fails closed, not an anon-mutation hole.