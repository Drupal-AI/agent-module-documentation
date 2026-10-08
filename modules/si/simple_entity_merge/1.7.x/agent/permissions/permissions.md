<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `simple_entity_merge.permissions.yml`. Both are `restrict access: TRUE`
(flagged as security-sensitive in the permissions UI).

| Permission | Title | Gates |
|------------|-------|-------|
| `administer simple_entity_merge` | Manage simple_entity_merge | The settings form/route `simple_entity_merge.settings` (the `exclude` list). |
| `execute simple_entity_merge` | Execute simple_entity_merge | The per-entity merge route `entity.<type>.simple_entity_merge_execute`, plus whether the "Simple Entity Merge" entity-operation link is shown (`simple_entity_merge_entity_operation()`). |

## Where each is enforced

- `administer simple_entity_merge` — the `_permission` requirement on
  `simple_entity_merge.settings` in `simple_entity_merge.routing.yml`.
- `execute simple_entity_merge` — added as the `_permission` requirement on every generated
  merge route by `Routing\RouteSubscriber::getSimpleEntityMergeExecuteRoute()`, and re-checked in
  `simple_entity_merge_entity_operation()` before adding the operation link.

## Grant via drush

```bash
ddev drush role:perm:add content_editor 'execute simple_entity_merge'
ddev drush role:perm:add administrator 'administer simple_entity_merge'
```

Operational note: `execute simple_entity_merge` is a single site-wide permission — it applies to
**every** non-excluded entity type at once (see [configure/settings.md](../configure/settings.md)
for the `exclude` list). A merge repoints references across the whole site and is not reversible.
