<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How it works (mechanism)

The whole module is a route subscriber plus one form subclass and a small JS/CSS library.
There is no service you call, no config, and no plugin.

## Route swap

`src/Routing/BetterPermissionsPageRouteSubscriber.php` (registered as the
`better_permissions_page.route_subscriber` event subscriber) implements `alterRoutes()`:

```php
if ($route = $collection->get('user.admin_permissions')) {
  $route->setDefault('_form', '\Drupal\better_permissions_page\Form\BetterPermissionsForm');
}
```

So the module does **not** add a route. It hijacks the core route
`user.admin_permissions` (path `/admin/people/permissions`) and points it at its own form.
Access is unchanged (still the core `administer permissions` requirement on that route).

## The form

`src/Form/BetterPermissionsForm.php` extends `Drupal\user\Form\UserPermissionsForm`
(form id `better_permissions_page_user_admin_permissions`).

- `buildForm()` adds a `provider` select. Options come from
  `array_keys($this->permissionsByProvider())` (the protected core method that groups every
  permission by the module that declares it), labelled with the module's human name. The
  first option is `_none` ("- None -").
- The select has an `#ajax` callback `::getPermissions` (event `change`, wrapper
  `permissions-wrapper`) that returns `$form['permissions']` — so switching provider
  re-renders **only** the permissions table, and only for the chosen provider.
- The permissions table is built exactly like core (one row per permission, one checkbox
  column per role) **but only for `permissionsByProvider()[$provider]`** — never the full
  list. Admin roles get disabled, checked checkboxes (`$role->isAdmin()`), same as core.
- The submit button is hidden via `#states` while `provider === _none`.

## Saving

`submitForm()` reshapes `$form_state->getValue('permissions')` into `[role => [perm =>
checked]]` and calls core's **`user_role_change_permissions($role_name, $perms)`** per role.
That is the same API the stock permissions page uses, so grants/revocations are written to
the `user.role.<rid>` config entities identically. It then redirects to
`user.admin_permissions` with `['fragment' => "module-<provider>"]`.

## What to know as an agent

- To grant/revoke a permission programmatically the module adds nothing new — use core:
  `user_role_grant_permissions($rid, [$perm])` / `user_role_revoke_permissions()` or edit
  the `user.role.<rid>` config's `permissions` list. Better permissions page only changes
  the **UI** of the existing page.
- Verifying a change = reading the role config (`user.role.<rid>` → `permissions`), not any
  module setting. There is no `better_permissions_page.*` config object.
- To customize behavior, subclass `BetterPermissionsForm` and re-point the route's `_form`
  (or its `_form` default) in your own route subscriber; the provider grouping lives in
  core's `permissionsByProvider()`.
