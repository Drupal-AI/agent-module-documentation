<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How it works (mechanism)

The module is `create_user_permission.module` (two hooks) plus one route subscriber and one
permission. No settings, schema, service beyond the subscriber, or plugin.

## 1. Route requirement rewrite

`src/Routing/RouteSubscriber.php` (`create_user_permission.route_subscriber`, tagged
`event_subscriber`) overrides the core add-user route:

```php
if ($route = $collection->get('user.admin_create')) {
  $route->setRequirement('_permission', 'create users');
}
```

So `/admin/people/create` becomes reachable with `create users` instead of `administer users`.

## 2. Entity create access

`hook_entity_create_access()` returns neutral for every entity type except `user`, and for
`user` returns `AccessResult::allowedIfHasPermission($account, 'create users')`. This makes the
permission authoritative for *any* user-entity creation path, not just the admin form.

## 3. Register-form alter

`hook_form_user_register_form_alter()` only acts if the current user has `create users`:

- If `user.settings` `register` is **not** `visitors` (i.e. admins-create-accounts mode), it
  sets `$form['administer_users']['#value'] = TRUE` and `status` default to `1`, so the
  delegated creator saves an **active** account without needing `administer users`.
- It sets `$form['account']['notify']['#access']` to the `create users` check, re-exposing the
  "Notify user of new account" email checkbox for delegated creators.

## Consequences an agent should know

- The only persistent state is which roles hold `create users` (in `user.role.<id>` config).
- A holder of `create users` can create accounts but cannot edit/delete/block existing ones.
- Because access is enforced via `hook_entity_create_access()`, the permission also governs
  programmatic and REST user creation, not merely the UI route.
