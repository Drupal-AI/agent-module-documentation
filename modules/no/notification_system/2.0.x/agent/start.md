<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Notification System (notification_system) — agent index

Pluggable base framework for notifications. Core module defines the **`notification_provider`**
plugin type, the `NotificationSystem` service, `notification_group` config entities, a type→group
mapping, and a per-user notifications **block** (`simple`/`bundled`, AJAX or inline). Storage and
delivery are optional submodules. Version **2.0.0-rc1**. Core `^10 || ^11`. Depends on `user`.
Composer: `html2text/html2text ^4.0.1`, `ext-json`, `ext-openssl`. Core module has **no
permissions of its own**.

## Solution docs
- **Provider plugin type + how to write one** → [plugins/notification-provider.md](plugins/notification-provider.md)
- **NotificationSystem service + Notification model + event** → [api/notification-service.md](api/notification-service.md)
- **Groups, type→group mapping, block, notification_reference field, config/schema** → [config/groups-block-field.md](config/groups-block-field.md)
- **Routes, controller, permissions** → [routes/routes.md](routes/routes.md)

## Submodules (each documented in its own tree)
- **notification_system_database** — stored `notification` content entity + admin UI + read-tracking + cron purge; provides the `database` provider and a nested `db_notification_provider` plugin type. → `modules/notification_system_database/2.0.x/`
- **notification_system_dispatch** — outbound delivery framework: `notification_system_dispatcher` plugin type, queue, event subscriber, per-user settings, `notification_dispatch_bundle` entity. → `modules/notification_system_dispatch/2.0.x/`
- **notification_system_dispatch_mail** — `mail` dispatcher plugin (Twig-templated email). → `modules/notification_system_dispatch_mail/2.0.x/`
- **notification_system_dispatch_webpush** — `webpush` dispatcher plugin + Safari/Apple push (needs `web_push_api`). → `modules/notification_system_dispatch_webpush/2.0.x/`

## Core building blocks (from source)
- Plugin type: `Plugin/NotificationProvider`, interface `NotificationProviderInterface`, base
  `NotificationProviderPluginBase`, annotation `@NotificationProvider`, manager service
  `plugin.manager.notification_provider`. Alter hook `notification_provider_info`.
- Service `notification_system` (`Service/NotificationSystem`): `getProviders()`,
  `getNotifications($user, $bundled, $includeRead)`, `getTypes()`, `markAsRead($user, $providerId, $notificationId)`,
  `loadNotification($providerId, $notificationId)`, `bundleNotifications()`.
- Model `model/Notification` (immutable-ish value object) implementing `model/NotificationInterface`;
  optional `model/ReadableNotificationInterface` (`isReadBy($uid)`) for dismissable items. Priority
  constants `PRIORITY_LOWEST..PRIORITY_HIGHEST` (1–5).
- Config entity `notification_group` (`Entity/NotificationGroup`, config prefix
  `notification_system.notification_group`), admin at `/admin/structure/notification-group`.
- Config object `notification_system.settings` holds `group_mappings` (type→group).
- Block `notification_system_notifications` (`Plugin/Block/NotificationsBlock`), library
  `notification_system/notifications_block`.
- Field type/widget/formatter `notification_reference` (references a notification by
  provider + id).
- Event `Event/NewNotificationEvent` (`EVENT_NAME = notification_system_new_notification`).

## Routes (core module)
`/notification-system/example` (debug table), `/notification-system/get-notifications/{display_mode}`,
`/notification-system/read/{providerId}/{notificationId}` — all `_permission: 'access content'`;
`/admin/structure/notification-group/mapping` — `administer site configuration`. Entity routes for
`notification_group` under `/admin/structure/notification-group`.

## Theme
`notification_block`, `notification_group`, `notification_item` (templates in `templates/`).
