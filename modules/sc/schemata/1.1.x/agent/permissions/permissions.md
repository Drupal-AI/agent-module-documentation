<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Schemata defines exactly one permission (`schemata.permissions.yml`):

| Machine name | Title | Gates |
|---|---|---|
| `access schemata data models` | Access the different data models | Every dynamically generated `/schemata/{entity_type}/{bundle?}` route (set as `_permission` in `Drupal\schemata\Routing\Routes::createRoute()`). |

- It is **not** granted to any role by default; grant it explicitly to the roles that need to
  read schema resources (e.g. an API-consumer role, or authenticated users).
- The same permission covers every entity type and bundle route — there is no per-type
  granularity.
- Grant via the UI at `/admin/people/permissions`, or:

```
drush role:perm:add <role> 'access schemata data models'
```

The submodule `schemata_json_schema` adds no permissions of its own; it works through these
routes.
