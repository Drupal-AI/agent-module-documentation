# Permissions & access model

cacheflush_ui defines **ten** permissions (`cacheflush_ui.permissions.yml`). The base `cacheflush`
module separately defines `cacheflush clear cache` (for the ready-made clear-all / clear-by-id
routes) — that one is not from this submodule.

| Permission | Gates |
|---|---|
| `cacheflush administer` | the collection, add, settings and bulk-delete routes (admin) |
| `cacheflush create new` | creating a new preset (`entity.cacheflush.add_form`) |
| `cacheflush clear own` / `cacheflush clear any` | clearing a preset (own vs any) |
| `cacheflush view own` / `cacheflush view any` | viewing a preset |
| `cacheflush edit own` / `cacheflush edit any` | editing a preset |
| `cacheflush delete own` / `cacheflush delete any` | deleting a preset |

## The own/any handler

`CacheflushEntityAccessControlHandler::checkAccess()` maps the entity operations `clear`, `view`,
`update`, `delete` to the matching `… any` / `… own` pair via `checkSingleToMany()`:

```
allowed if (has "<op> any")  OR  (has "<op> own" AND current user == preset owner uid)
```

`checkCreateAccess()` requires `cacheflush create new`. The preset's owner is its `uid` field
(defaults to the creator). The clear-by-id route only performs this `cacheflush.clear` entity-access
check because `CacheflushRouteSubscriber` adds `_entity_access: cacheflush.clear` to
`cacheflush.presets.clear_id` (on top of the base module's `cacheflush clear cache` permission).

## Practical grants

- A role that should run any preset but not edit: give `cacheflush clear any` (+ base
  `cacheflush clear cache` for the route) and nothing else.
- A role that manages only its own presets: `cacheflush create new`, `cacheflush edit own`,
  `cacheflush view own`, `cacheflush delete own`, `cacheflush clear own`.
- Full admin: `cacheflush administer` (+ the any-level permissions as needed).

```bash
drush role:perm:add editor 'cacheflush clear any'
drush role:perm:add editor 'cacheflush clear cache'   # base-module route permission
```
