<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bulk Update User Roles (bulk_update_user_roles) — agent index

A single admin form that **assigns or removes one or more roles across many users at once**,
processed with the Batch API. Depends only on core **`user`**. Package `Other`. Core
`^10.3 || ^11`. License GPL-2.0-or-later. Version 1.0.4.

- **The form, route, options, batch mechanism, and how to operate it** →
  [config/settings.md](config/settings.md)

## What it actually is

- One form: `BulkUpdateUserForm` (form id `bulk_update_user_roles_form`), in
  `src/Form/BulkUpdateUserForm.php`, extending core `FormBase`.
- One route: `bulk_update_user_roles.settings` → path `/admin/config/people/bulk-update`,
  requirement `_permission: 'administer users'` (`bulk_update_user_roles.routing.yml`). This is
  the `configure` route and the admin-menu link (`bulk_update_user_roles.links.menu.yml`, parent
  `user.admin_index`).
- One batch helper class: `BulkUpdateUserRoles` (`src/Batch/BulkUpdateUserRoles.php`) with static
  `addRolesToUser()`, `removeRolesFromUser()`, and `finished()`.
- One hook class: `BulkUpdateUserRolesHooks` (`src/Hook/BulkUpdateUserRolesHooks.php`, registered
  as a service in `bulk_update_user_roles.services.yml`) implementing `hook_help` via the
  `#[Hook]` attribute.
- **No** entities, plugins, permissions of its own, config objects/schema, Drush commands, or
  libraries. `.module` file is empty except the file docblock.

## Mechanism (from source)

- The form lists non-locked roles (all roles except `anonymous`/`authenticated`), an "Assign
  roles"/"Remove roles" selector, a "Select all users" checkbox, and a multi-select of users.
- The user query (`entityTypeManager->getStorage('user')->getQuery()`) is
  `->condition('uid', 1, '>')` — **uid 1 is always excluded** — with `->accessCheck(FALSE)`.
- `submitForm()` builds a `batch_set()` job, one operation per uid, calling
  `BulkUpdateUserRoles::addRolesToUser` or `removeRolesFromUser`, which load the user and call
  `$user->addRole($role)` / `$user->removeRole($role)` then `$user->save()`.
