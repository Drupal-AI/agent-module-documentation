<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

## Static

| Permission | Gates |
|---|---|
| `administer entity comparison` | The `/admin/structure/entity_comparison` UI (add/edit/delete comparison config entities) |

## Generated, one per comparison

`EntityComparisonPermissions::entityComparisonTypePermissions()` (registered via
`permission_callbacks` in `entity_comparison.permissions.yml`) creates:

```
use {comparison_id} entity comparison     — "%label: Use entity comparison"
```

That permission gates three things:

1. The comparison page route `/compare/{id-with-dashes}` (`_permission` on the dynamic route).
2. `#access` on every rendered add/remove link (entity display, block, Views field).
3. `hook_entity_field_access()` for the `entity_comparison_link` field.

```bash
drush role:perm:add anonymous 'use products entity comparison'
drush role:perm:list anonymous | grep 'entity comparison'
```

After creating a new comparison, rebuild caches so its permission and route appear:

```bash
drush cr
```

## The toggle route

The toggle route uses core `access content` rather than the comparison's own permission:

```yaml
entity_comparison.action:
  path: '/entity-comparison/{entity_comparison_id}/{entity_id}'
  requirements:
    _permission: 'access content'      # <- not "use {id} entity comparison"
```
