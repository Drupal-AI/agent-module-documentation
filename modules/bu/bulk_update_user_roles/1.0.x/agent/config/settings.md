<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bulk Update User Roles — the form, route, and batch

## Install / enable

`drush en bulk_update_user_roles -y`. Depends only on core `user`. There is nothing to configure
in `settings.php` and no config object is created — the module is stateless (no
`config/install`, no `config/schema`).

## Route & access

`bulk_update_user_roles.routing.yml`:

- `bulk_update_user_roles.settings` → path `/admin/config/people/bulk-update`,
  `_form: '\Drupal\bulk_update_user_roles\Form\BulkUpdateUserForm'`,
  `_title: 'Bulk Update User Roles'`, requirement `_permission: 'administer users'`.

This is also the module's `configure` route (info.yml) and the admin-menu link
(`bulk_update_user_roles.links.menu.yml`, parent `user.admin_index`, i.e. under
Administration → Configuration → People).

## The form (`src/Form/BulkUpdateUserForm.php`)

`BulkUpdateUserForm extends FormBase`; form id `bulk_update_user_roles_form`. Injected via
`create()`: `entity_type.manager` and the `user_role` storage (`RoleStorageInterface`).

`buildForm()` elements:

- `note` / `available_users` — markup: a notice that uid 1 is excluded, and the count of eligible
  users.
- `select_all_users` — checkbox. When checked, the `selected_users` element is hidden (via
  `#states`) and the submit targets all eligible users.
- `selected_users` — multi `select` (`#size` 10) of eligible users; options come from
  `getUserOptions()` which loads the users and maps uid → `getDisplayName()`.
- `buur_update_option` — required `select`: `add` → "Assign roles", `remove` → "Remove roles".
- `buur_user_roles` — required multi `select` of roles. Options are built from
  `roleStorage->loadMultiple()` with only `anonymous` and `authenticated` filtered out.
- `actions.submit` — primary submit button.

Eligible-user query (both in `buildForm` and `submitForm`):
`entityTypeManager->getStorage('user')->getQuery()->condition('uid', 1, '>')->accessCheck(FALSE)`
— **uid 1 is always excluded**; the query runs without entity access checking.

## Submit → Batch (`submitForm()` + `src/Batch/BulkUpdateUserRoles.php`)

`submitForm()`:

- Reads `buur_user_roles` (selected role ids) and `select_all_users`.
- Target uids = `selected_users` when "select all" is off, else the full `uid > 1` query result.
- If there are targets, it builds a batch with one operation per uid, callback
  `BulkUpdateUserRoles::addRolesToUser` (when option is `add`) or `removeRolesFromUser`
  (otherwise), passing `[$uid, $roles_selected]`; `finished` callback is
  `BulkUpdateUserRoles::finished`. Title/init/progress/error messages are set, then `batch_set()`.
- If there are no targets it shows "No users to update the roles."

Batch class (static methods):

- `addRolesToUser(int|string $uid, array $roles_list, array &$context)` — loads the user, loops
  `$user->addRole($role)`, then `$user->save()`; increments `$context['results']['count']`.
- `removeRolesFromUser(...)` — same shape with `$user->removeRole($role)`.
- `finished(bool $success, array $results, array $operations)` — on success shows a pluralized
  "Assigned/Removed role to N users." message; otherwise an error message.

## Hook (`src/Hook/BulkUpdateUserRolesHooks.php`)

`BulkUpdateUserRolesHooks` is registered as a service (`bulk_update_user_roles.services.yml`,
arg `@current_route_match`) and implements `hook_help` via `#[Hook('help')]`, returning a one-line
description on `help.page.bulk_update_user_roles`.

## Operating notes

- The apply action is a standard POST `FormBase` submission, so Drupal's form-token CSRF
  protection applies automatically.
- There is no confirmation step and no dry-run — submitting applies the change immediately across
  the whole target set. On large sites prefer selecting a subset first to verify behavior.
- Because uid 1 is filtered by the `uid > 1` condition, the superuser account can never be
  modified through this form.
