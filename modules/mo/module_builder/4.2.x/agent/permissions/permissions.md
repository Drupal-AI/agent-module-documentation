# Permissions

Defined in `module_builder.permissions.yml`.

| Permission | Machine name | `restrict access` | Gates |
|---|---|---|---|
| Create modules | `create modules` | `true` | Every module_builder route and the whole build workflow |

`create modules` is the only permission the module defines. It is:

- the requirement (`_permission: 'create modules'`) on all four explicit routes —
  `module_builder.settings`, `module_builder.analyse`, `module_builder.autocomplete`,
  `module_builder.adopt_module_form`;
- the `admin_permission` of the `module_builder_module` config entity, which applies it to all of
  its CRUD routes, the section-form tabs (re-applied by `ComponentRouteProvider`), and the
  generate/write and adopt routes.

So a user needs `create modules` to reach the collection page, edit any component, run the code
analysis, change settings, and generate or write files.

Grant via Drush:

```bash
drush role:perm:add <role> 'create modules'
```

Note: the YAML entry has a typo (`decription:` instead of `description:`), so the permission shows no
description text on the permissions admin page. Cosmetic only; the permission itself works normally.
