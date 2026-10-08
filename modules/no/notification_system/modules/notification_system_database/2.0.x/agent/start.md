<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Notification System Database Storage (notification_system_database) — agent index

Storage submodule of **notification_system**. Provides a stored `notification` content entity, a
per-user read-tracking table, cron expiry/purge, and the `database` NotificationProvider. Depends
on `notification_system`, `link`, `options`, `datetime`. `configure: entity.notification.settings`.

## Solution docs
- **The `notification` entity, fields, read-tracking, cron, the `database` provider** → [api/entity-and-provider.md](api/entity-and-provider.md)
- **Routes, permissions, settings, config, optional REST** → [config/admin-and-config.md](config/admin-and-config.md)

## Provides
- Content entity **`notification`** (`src/Entity/Notification.php`): translatable, base table
  `notification` / data table `notification_field_data`, `admin_permission = "administer notification"`.
  Fields: `user_id` (multi user ref, required audience), `provider_id`, `notification_type`,
  `created`, `title`, `body` (string_long), `link`, `sticky`, `priority` (list_integer 1–5),
  `forced`, `expires` (datetime). `label = title`, `uid = user_id`.
- Provider **`database`** (`src/Plugin/NotificationProvider/DatabaseNotificationProvider.php`):
  `getNotifications()` queries `notification` where `user_id == $user` (`accessCheck(TRUE)`);
  `markAsRead()` verifies audience + non-sticky before inserting a read row; `getTypes()` aggregates
  the nested `db_notification_provider` plugins.
- Nested plugin type **`db_notification_provider`** (`Plugin/DbNotificationProvider`, manager
  `plugin.manager.db_notification_provider`, interface `DbNotificationProviderInterface`, base
  `DbNotificationProviderPluginBase`, annotation `@DbNotificationProvider`) — only `getTypes()`.
- Model **`model/DatabaseNotification`** extends parent `model/Notification` + implements
  `ReadableNotificationInterface`; `isReadBy()` counts `notification_system_database_read`.
- Table **`notification_system_database_read`** (`id, uid, entity_id, timestamp`, index
  `uid__entity_id`) — see `.install`.
- `hook_cron`: delete expired (`expires < now`); purge read rows older than `read_purge_days`
  (removing the user from the audience, then deleting audience-less notifications); delete
  notifications with no `user_id`.
- `hook_ENTITY_TYPE_delete` (user): remove the user's audience rows and read rows.
- On entity insert, `postSave()` dispatches `NewNotificationEvent` and invalidates
  `notification_system:read:{uid}` for each audience user.

## Routes / permissions
- `entity.notification.settings` — `/admin/structure/notification` — `administer notification`
  (`restrict access: true`). Entity CRUD routes under `/admin/content/notification` +
  `/notification/{notification}` (AdminHtmlRouteProvider, `admin_permission` = `administer notification`).
- Permissions: `administer notification` (restricted), `access notification overview`.

## Config
- `notification_system_database.settings` — `read_purge_days` (int; 0 = never). Schema in
  `config/schema/`.
- Optional REST: `config/optional/rest.resource.entity.notification.yml` (GET/POST/PATCH/DELETE,
  cookie auth) — installed only if `rest` is enabled; off by default.
