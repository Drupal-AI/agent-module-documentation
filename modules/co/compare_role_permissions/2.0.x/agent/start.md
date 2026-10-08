<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Compare role permissions — agent index

Provides one admin form that compares the permissions of **two roles side by side** and lists only
the permissions that **differ** between them. Read-only diagnostic/audit aid — it never grants or
revokes anything. Version **2.0.1**, core `^10 || ^11`. Depends on core `user`. No config schema, no
services, no Drush, no plugins, no menu link (reached via URL or the Extend-page **Configure** link).

Single small module — no subdocs. Everything is in the one form class.

Key facts:
- Route `compare_role_permissions.compare_form` → path `/admin/people/permissions/compare`,
  `_form: \Drupal\compare_role_permissions\Form\CompareRolePermissionsForm`, `_admin_route: TRUE`.
  Gated by `_permission: 'compare role permissions'`.
- Permission `compare role permissions` (`restrict access: true`), declared in
  `compare_role_permissions.permissions.yml`. It is the module's own dedicated permission — separate
  from core `administer permissions`.
- `info.yml` sets `configure: compare_role_permissions.compare_form` (adds a Configure link on
  `/admin/modules`). No `.links.menu.yml` / `.links.task.yml` — no menu tab is registered.
- Form (`src/Form/CompareRolePermissionsForm.php`, extends `FormBase`): two required `select`
  elements `role1`/`role2` (defaults `anonymous` / `authenticated`), options from
  `Role::loadMultiple()` labels, and a **Compare** submit button.
- `validateForm()` rejects picking the same role twice ("Roles should be different from each other.").
- `submitForm()` reads each role's permissions via `Role::load($id)->getPermissions()`, diffs them
  with `array_diff_key` (symmetric difference), and builds a render-array `#type: table` of the
  differing permissions: columns Module (link to `user.admin_permissions` `#module-<provider>`),
  Permission (title from the `user.permissions` service), and Yes/No per role. Result is stored in
  form state and shown in an open `details` element on rebuild. If no differences: "Both the selected
  roles have similar permissions."
- Constructor injects `entity_type.manager` and `renderer`; `getPermissionInfo()` additionally calls
  the `user.permissions` service statically. Attaches library `compare_role_permissions/compare_role_permissions`
  (`css/compare-role-permissions.css` only). `hook_help()` for the help page and the form route.
- Ships PHPUnit Functional + Unit tests under `tests/`.
