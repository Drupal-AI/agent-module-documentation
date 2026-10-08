<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permission

`entity_type_clone.permissions.yml` defines exactly one permission:

| Permission | Title | Notes |
|---|---|---|
| `access entity type clone` | Access Entity Type Clone | "Perform administration tasks for Entity Type clone." Not marked `restrict access`, but it is effectively an admin permission — it lets a user create arbitrary bundles and roles. |

## What it gates

1. Route `entity_type_clone.type` — `/admin/config/entity-type-clone` (the bundle clone form).
2. Route `entity_type_clone.role` — `/admin/config/role-clone` (the role clone form).
3. The **"Clone *label*"** entity operation added by `entity_type_clone_entity_operation_alter()`
   to bundle list builders whose `getBundleOf()` is one of `node`, `paragraph`, `taxonomy_term`,
   `profile` (weight 30). The link points at
   `entity_type_clone.type` with route parameters `entity` = the bundle-of entity type and
   `bundle` = the bundle id.

Because the role clone form calls `user_role_grant_permissions()` with the source role's
permissions, **anyone with this permission can effectively mint a role holding any permission an
existing role holds** — including `administer permissions`. Treat it as administrative.

## Grant it

```bash
drush role:perm:add editor 'access entity type clone'
drush role:perm:list editor | grep 'entity type clone'
```

```php
$role = \Drupal::entityTypeManager()->getStorage('user_role')->load('editor');
$role->grantPermission('access entity type clone')->save();
```

Find which roles have it:

```bash
drush php:eval 'foreach (\Drupal::entityTypeManager()->getStorage("user_role")->loadMultiple() as $r) {
  if (in_array("access entity type clone", $r->getPermissions(), TRUE)) { print $r->id() . "\n"; }
}'
```

Note the *bundle* forms themselves are not further access-checked per bundle: a user with the
permission can clone any clonable bundle on the site.
