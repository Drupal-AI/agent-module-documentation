# ECK permissions

## Static permissions (`eck.permissions.yml`)

| Permission | Gates | Restricted |
|---|---|---|
| `administer eck entity types` | Create/edit/delete ECK entity types; the `/admin/structure/eck` UI (configure route) | yes |
| `administer eck entity bundles` | Create/edit/delete bundles; `admin_permission` of bundle entities | yes |
| `administer eck entities` | Create/edit/delete any ECK entity across all types; `admin_permission` of the type | yes |
| `bypass eck entity access` | View/edit/delete **all** ECK entities regardless of per-type grants | yes |
| `view unpublished eck entities` | View entities whose `status` base field is unpublished | no |

## Dynamic per-type permissions (`PermissionsGenerator::entityPermissions`)

For **every** `eck_entity_type` (id `{t}`), ECK generates:

- `create {t} entities`
- `edit any {t} entities`, `delete any {t} entities`, `view any {t} entities`
- `access {t} entity listing`
- If the type has the **author** (`uid`) base field, also the "own" variants:
  `edit own {t} entities`, `delete own {t} entities`, `view own {t} entities`

Example for a type `event`: `create event entities`, `edit any event entities`,
`view any event entities`, `access event entity listing`, and (with author field)
`edit own event entities`, etc.

## Grant via drush

```bash
drush role:perm:add editor 'create event entities'
drush role:perm:add editor 'edit any event entities'
drush role:perm:add authenticated 'view any event entities'
```

Entity access uses `permission_granularity = bundle`, but the generated permissions above
are **per entity type**, not per bundle. `EckEntityAccessControlHandler` checks these plus
`bypass eck entity access` and the `administer eck entities` admin permission.
