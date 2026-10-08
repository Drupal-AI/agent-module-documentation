<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions & access

Entity Update ships **no `entity_update.permissions.yml`** — it defines no permissions of its own.

Every route in `entity_update.routing.yml` is gated by core's existing permission:

```yaml
requirements:
  _permission: 'administer software updates'
```

That covers `entity_update`, `entity_update.settings`, `entity_update.exec`,
`entity_update.list`, `entity_update.types` and `entity_update.status`.

`administer software updates` is a **restricted-access** core permission (it is flagged
`restrict access: TRUE` in `update.permissions.yml`) — granting it is equivalent to granting the
ability to change the site's code/schema. In practice only user 1 or a trusted administrator role
should have it.

```bash
drush role:perm:add administrator 'administer software updates'
```

The Drush commands (`upe`, `upec`) run as the Drush user and do **not** perform a permission
check — CLI access is the access control.
