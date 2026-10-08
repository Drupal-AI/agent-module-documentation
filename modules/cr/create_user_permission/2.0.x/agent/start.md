<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Create User Permission — agent index

Adds one permission, **`create users`**, so a role can create new accounts without
`administer users`. No configure route (`configure: null`), no settings, no config schema,
no Drush, no plugins. Everything is enforcement wiring around that single permission.

- **The permission, what it gates, and how to grant it** →
  [permissions/create-users.md](permissions/create-users.md)
- **How it is enforced (route subscriber, entity_create_access, register-form alter)** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- Route `user.admin_create` (`/admin/people/create`) requirement is rewritten to
  `_permission: 'create users'` by `RouteSubscriber::alterRoutes()`.
- `hook_entity_create_access()` allows creating a `user` entity for anyone holding
  `create users`.
- Persistent state is only *which roles hold the permission* — stored in `user.role.<id>`
  config under `permissions`.
