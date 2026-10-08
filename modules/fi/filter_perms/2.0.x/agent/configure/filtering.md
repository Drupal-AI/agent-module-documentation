<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How Filter Permissions works

No configuration UI — install it and the permissions page gains filters.

## Route override

`Drupal\filter_perms\Routing\RouteSubscriber::alterRoutes()`:

- `user.admin_permissions` → `_form` = `\Drupal\filter_perms\Form\PermissionsForm`
- `entity.user_role.edit_permissions_form` → `_form` = `\Drupal\filter_perms\Form\PermissionsRoleSpecificForm`

`PermissionsForm` extends core `UserPermissionsForm`. `PermissionsRoleSpecificForm` extends it and,
for the per-role page, pre-sets the filter to that single role + all modules, then redirects to the
main permissions page.

## The filters

The form adds a **Permission Filters** fieldset (`$form['filters']`) with two multi-selects:

- **Roles to display** (`roles`) — options are `-1 => '--All Roles'` plus every role.
- **Modules to display** (`modules`) — options are `-1 => '--All Modules'` plus every module that
  defines a permission (`$permission['provider']`).

A **Filter Permissions** button (`::submitFormFilter`) saves the selection; only the chosen roles
(as columns) and chosen modules (as permission groups) are rendered. Until at least one role **and**
one module are selected, the permissions table is empty with a prompt.

`ALL_OPTIONS = '-1'` — selecting it means "all roles" / "all modules".

## Per-user persistence

Selections are stored per user in an **expirable key/value** store:

```php
// collection: 'filter_perms_list', key: current user id, TTL 3600s
\Drupal::keyValueExpirable('filter_perms_list')
  ->setWithExpire((string) $uid, ['roles' => [...], 'modules' => [...]], 3600);
$filter = \Drupal::keyValueExpirable('filter_perms_list')->get((string) $uid, ['roles' => [], 'modules' => []]);
```

So the grid stays filtered for an hour as you work, and each admin has their own filter.

## max_input_vars guard

The form counts the checkboxes it would render plus the filter options. If that exceeds PHP's
`max_input_vars`, it **disables the Save button** and shows an error ("There are too many
permissions to be saved safely… Please filter the permissions."). Filtering to fewer
roles/modules brings the count back under the limit — the module's main practical purpose on large
sites.

## Notes

- Admin roles (`$role->isAdmin()`) show all permissions checked and disabled, as in core.
- Access to the page is still gated by core's `administer permissions` permission.
