<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services, recycle-bin mechanism, cron, block & hooks

## Services

- **`entity_recycle.manager`** → `EntityRecycleManager` (implements `EntityRecycleManagerInterface`).
  Args: `config.factory`, `entity_type.manager`, `entity_field.manager`, `logger.factory`,
  `module_handler`. Constructor holds an editable `entity_recycle.settings`.
- **`entity_recycle.view.manager`** → `EntityRecycleViewManager`. Args: `current_user`,
  `entity_recycle.manager`. Owns the permission constants and the view-access decision.
- **`entity_recycle.route_subscriber`** → `Routing\RouteSubscriber` (see
  [../routes/delete-and-restore.md](../routes/delete-and-restore.md)).

## The recycle-bin flag

`recycle_bin` (const `EntityRecycleManager::RECYCLE_BIN_FIELD`) is a locked boolean field.
`inRecycleBin($entity, $bundle)` = `isEnabled(...)` AND the field's `value` is truthy.

Key `EntityRecycleManager` methods:
- **`addItem($entity)`** — if not already binned: set `recycle_bin = 1`, `$entity->setUnpublished()`,
  invoke `recycle_bin_pre_recycle`, `save()`, invoke `recycle_bin_recycled`. (Binning unpublishes.)
- **`removeItem($entity)`** (restore) — if binned: invoke `recycle_bin_entity_pre_restore`, set
  `recycle_bin = 0`, `save()`. **Does not re-publish** — a restored entity keeps its published
  status as it was while binned.
- **`getItem($entityType, $id)`** — load entity, return it only if it is currently in the bin.
- **`getAllItems()`** — for each enabled type, `loadByProperties(['recycle_bin' => 1])` (bundle-scoped
  when bundles are configured). Used by cron.
- **`getPurgeTime($entity)`** — minutes remaining = `purge_time − ((now − changed) / 60)`, rounded.
  Negative = overdue.
- **`purge($entity)`** — only when enabled and `purge_time` set and `getPurgeTime()` < 0: invoke
  `recycle_bin_entity_pre_delete`, `$entity->delete()`, invoke `recycle_bin_entity_deleted`, log a
  notice.
- `getSetting()/getSettings()`, `isEnabled()`, `hasBundles()/getBundles()/getEnabledBundles()`,
  `fieldExists()`, `createField()/deleteField()/getField()/getFieldStorage()` (field lifecycle,
  covered in [../config/settings.md](../config/settings.md)).

## View access (hide binned items)

`hook_entity_access` (`entity_recycle.module`) delegates the `view` op to
`EntityRecycleViewManager::entityAccess()`: for an entity of an enabled type/bundle that
`inRecycleBin()`, it returns **`AccessResult::forbidden()`** when the account lacks
`view entity recycle bin items` (`checkViewPermission()`), otherwise `neutral()`. Other ops return
`neutral()`. So binned entities are hidden from normal viewers but not force-granted to anyone.

## Cron auto-purge

`hook_cron` (`entity_recycle_cron`): if `purge_time` is set, iterate `getAllItems()` and call
`purge()` on each; items older than `purge_time` minutes (by `getChangedTime()`) are permanently
deleted.

## Operations links

`hook_entity_operation` adds a **Restore** operation (to `entity_recycle.entity.restore`) for binned
entities. `hook_entity_operation_alter` removes the core **delete** operation for binned entities
when the current user lacks `delete entity recycle bin items`
(`EntityRecycleViewManager::checkDeletePermission()`).

## Block: RecycledEntityAlertBlock

`Plugin/Block/RecycledEntityAlertBlock` (id `recycled_entity_alert_block`, `getCacheMaxAge()` = 0).
On a route whose parameter is a binned entity, `build()` renders theme
`block_recycled_entity_alert_default` (`templates/block-recycled-entity-alert-default.html.twig`)
with a "this item is in the recycle bin" message and, when a purge time applies, either "will be
deleted on the next cron run" (overdue) or "will be deleted in @time minutes".

## Extension hooks (`entity_recycle.api.php`)

`invokeAll` hooks other modules can implement: `hook_recycle_bin_pre_recycle`,
`hook_recycle_bin_recycled`, `hook_recycle_bin_entity_pre_restore`,
`hook_recycle_bin_entity_restored`, `hook_recycle_bin_entity_pre_delete`,
`hook_recycle_bin_entity_deleted`. All except the last two receive `&$entity` by reference.
