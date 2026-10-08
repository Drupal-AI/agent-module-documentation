<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permission: `create users`

Defined in `create_user_permission.permissions.yml`:

```yaml
create users:
  title: 'Create users'
  description: 'Allows users to create users, without necessarily being able to edit and delete'
```

This is the module's entire configurable surface. It is **not** marked `restrict access: true`,
but it grants a genuine capability (creating accounts), so give it only to trusted roles.

## What it gates

- Access to the core *Add user* form, route `user.admin_create` at `/admin/people/create`
  (the module rewrites that route's requirement from `administer users` to `create users`).
- Create access for the `user` entity type (`hook_entity_create_access()`), so programmatic
  `User::create()->save()` / REST user creation by that account also passes the create check.
- On the register form, visibility of the **"Notify user of new account"** email checkbox.

It does **not** grant editing, blocking, cancelling, or role-assigning existing users — that
still requires `administer users`. That separation is the whole point of the module.

## Grant it

UI: *People → Permissions* (`/admin/people/permissions`), find the **Create User Permission**
section, tick **Create users** for the desired role, Save.

Drush:

```bash
drush role:perm:add my_role 'create users'
drush role:perm:remove my_role 'create users'
```

Config (`user.role.<role_id>.yml`) lists it under `permissions:`:

```yaml
permissions:
  - 'create users'
```

Read back which roles have it:

```bash
drush php:eval 'foreach (\Drupal\user\Entity\Role::loadMultiple() as $r) { if (in_array("create users", $r->getPermissions(), TRUE)) print $r->id()."\n"; }'
```
