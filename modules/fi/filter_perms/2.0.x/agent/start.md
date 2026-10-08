<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Filter Permissions — agent index

Adds role & module filters to Drupal's permissions page by overriding the form on the core
permissions routes. Requires `user`. No settings form, no `configure` route, no config schema, no
Drush, and it defines **no permissions of its own** (it reuses core's `administer permissions`).

- **How the override works, the filters, per-user storage, and the max_input_vars guard** →
  [configure/filtering.md](configure/filtering.md)

Key facts: a `RouteSubscriber` swaps the `_form` on `user.admin_permissions`
→ `Drupal\filter_perms\Form\PermissionsForm` and on `entity.user_role.edit_permissions_form`
→ `PermissionsRoleSpecificForm`. Filter selections persist per user in the expirable key/value
collection **`filter_perms_list`** (key = user id, 1-hour expiry). `ALL_OPTIONS = '-1'` means all
roles / all modules.
