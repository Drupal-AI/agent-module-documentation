<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Microsoft Entra User Sync (entrasync) — agent index

Imports users from a **Microsoft Entra ID (Azure AD)** tenant into Drupal (users or nodes) via the
**MS Graph API**. Each import is a config entity (`entrasync`) that fetches selected Entra user
properties, optionally filters them, queues them, and creates/updates a Drupal entity through a
**storage plugin**. Package `Custom`. Version **3.0.0-beta2** (pre-release). Core `^10 || ^11`.
License GPL-2.0-or-later.

- **Config entity, admin form, routes, permission, config keys/schema** →
  [config/settings.md](config/settings.md)
- **Sync service, Graph fetch + delta, queue worker, managed-entities table, cron, events, plugin type** →
  [api/sync-service.md](api/sync-service.md)

## Dependencies

- `drupal/key` (`^1.20`) and `drupal/ms_graph_api` (`^2.0`) — required.
- Authentication is delegated to **ms_graph_api**: the config entity stores only a **Key entity id**
  (`graph_key`); the Graph client is built by `GraphApiGraphFactory::buildGraphFromKeyId()`.
- Suggested: `queue_ui` (on-demand queue processing), `openid_connect` (let imported users log in).
- Ships two submodules that provide the storage plugins:
  - **entrasync_user** — `user` plugin (see `../modules/entrasync_user/3.0.x/`).
  - **entrasync_node** — `node` plugin (see `../modules/entrasync_node/3.0.x/`).

## What it provides

- **Config entity type** `entrasync` (`SyncEntity`, `ConfigEntityBase`, config prefix
  `entrasync.entity`), `admin_permission = "administer entra sync settings"`. Handlers: list builder
  + add/edit (`SyncEntityForm`), delete (`SyncEntityDeleteForm`), sync (`SyncEntityPerformSyncForm`).
- **Service** `entrasync.entra_sync` (`Services\EntraSync`) — fetch, filter, queue, managed-entity
  bookkeeping, full sync.
- **Plugin type** `EntraSyncStorage` — manager `plugin.manager.entrasync_storage`
  (`StoragePluginManager`), interface `StorageInterface`, base `StorageBase`, attribute + annotation
  `EntraSyncStoragePlugin`, subdir `Plugin/EntraSyncStorage`.
- **Queue worker** `entrasync_user_processor` (`EntraUserProcessor`, cron time 60s).
- **Events** `entrasync.distilled_users_alter` (`EntraDistilledUsersAlter`) and
  `entrasync.entity_pre_save` (`EntraEntityPreSave`) — see `entrasync.api.php`.
- **Database table** `entrasync_managed_entities` (Entra GUID ↔ Drupal entity id per sync).
- **Permission** `administer entra sync settings` (`restrict access: true`).
- **Hooks**: `hook_cron` (runs each sync with `retrieve_on_cron`), `hook_requirements`,
  `hook_uninstall`, `hook_schema`.

## Routes (all require `administer entra sync settings`)

- `entrasync.collection` — `/admin/config/services/entrasync` (list; `configure` route).
- `entity.entrasync.add_form` / `edit_form` / `delete_form` — add/edit/delete a sync.
- `entity.entrasync.sync` — `/admin/config/services/entrasync/{entrasync}/sync` (confirm + run).
