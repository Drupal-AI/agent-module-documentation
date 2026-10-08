<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Recycle (entity_recycle) — agent index

Recycle bin / soft delete for content entities. Deleting an enabled entity moves it to a bin
(sets a locked boolean field `recycle_bin = 1` and unpublishes it) instead of permanently
removing it; it can then be restored, or permanently deleted, or auto-purged by cron. Depends
only on core `node`. Package `Other`. Core `^10.1 || ^11`. Version 3.0.0-alpha1 (this dir 3.0.x).
License GPL-2.0-or-later.

## What it provides (from source)

- **Field flag:** a locked boolean field `recycle_bin` (const `EntityRecycleManager::RECYCLE_BIN_FIELD`),
  created/deleted per enabled entity-type+bundle. `value = 1` means "in the bin".
- **Services** (`entity_recycle.services.yml`): `entity_recycle.manager`
  (`EntityRecycleManager`), `entity_recycle.view.manager` (`EntityRecycleViewManager`),
  `entity_recycle.route_subscriber` (`Routing\RouteSubscriber`).
- **Routes** (`entity_recycle.routing.yml`): `entity_recycle.settings`
  (`/admin/config/content/entity_recycle`, perm `administer entity recycle bin`) and
  `entity_recycle.entity.restore` (`/entity_recycle/restore/{entity_type}/{id}`, perm
  `restore entity recycle bin items`). The delete-form route of each enabled entity type is
  rewritten to `Form\EntityRecycleDeleteForm` by `RouteSubscriber`.
- **View:** `views.view.content_recycle_bin` (page at `admin/content/node/recycle-bin`) listing
  binned nodes.
- **Block:** `RecycledEntityAlertBlock` (id `recycled_entity_alert_block`) — banner shown on a
  binned entity's page.
- **Permissions** (`entity_recycle.permissions.yml`): `view` / `add` / `restore` /
  `delete entity recycle bin items` and `administer entity recycle bin`.
- **Hooks:** `hook_cron` (purge), `hook_entity_presave` (default field value), `hook_entity_access`
  (hide binned items on view), `hook_entity_operation` + `_alter` (Restore op / gate Delete op);
  plus invoke-all extension hooks in `entity_recycle.api.php`.

## Solution docs

- **Install, settings form, config object & schema, field lifecycle** →
  [config/settings.md](config/settings.md)
- **Services, the recycle_bin field mechanism, add/remove/restore/purge, cron, block, hooks** →
  [api/manager.md](api/manager.md)
- **Delete interception, restore route/form, the recycle-bin view, permissions** →
  [routes/delete-and-restore.md](routes/delete-and-restore.md)
