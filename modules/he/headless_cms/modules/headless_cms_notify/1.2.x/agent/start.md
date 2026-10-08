<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Headless CMS - Notify (headless_cms_notify) — agent index

Sends **entity-operation** and **cache-rebuild** notifications to decoupled frontends through a
pluggable, per-consumer **transport** layer. Version **1.2.x**. Core `^10.3 || ^11`.
Depends on `drupal:field`, `headless_cms:headless_cms`, `consumers:consumers`. Ships **no transport**
— enable `headless_cms_notify_webhook` / `headless_cms_notify_nats` or write a plugin.

## What it provides

- **Config entity** `headless_notify_transport` (`src/Entity/HeadlessNotifyTransport.php`) — a named
  binding of a transport plugin + its configuration. `admin_permission: administer headless_cms
  settings`; `config_prefix: transport`; managed via a list builder + add/edit/delete forms at
  `/admin/config/headless-cms/notify/transports`.
- **Plugin type** `headless_cms_notify_transport` — manager
  `HeadlessNotifyTransportPluginManager` (dir `Plugin/HeadlessNotifyTransport`, interface
  `HeadlessNotifyTransportPluginInterface`, attribute `Attribute\HeadlessNotifyTransport`,
  base `Plugin\HeadlessNotifyTransport\HeadlessNotifyTransportBase`).
- **Consumer base fields** (`headless_cms_notify.basefields.inc`, installed in `.install`):
  `headless_cms_notify_enabled`, `headless_cms_notify_transport` (ref to transport entity),
  `headless_cms_notify_notification_types`, `headless_cms_notify_entity_types`.
- **Services** (`headless_cms_notify.services.yml`): `HeadlessNotifyService` (dispatch),
  `HeadlessNotifyTransportService` (validate + send via plugin), `ConsumerHeadlessNotifyManager`
  (per-consumer applicability, cached), `HeadlessNotifyRebuildAnnouncer` (defers cache-rebuild
  send to shutdown), `NotifyMessage\HeadlessNotifyMessageDiscoveryService` (message-type discovery),
  `EventSubscriber\HeadlessNotifyEventSubscriber` (migration suppression).
- **Message types** (`src/NotifyMessage`): `entity_operation`
  (`HeadlessNotifyEntityOperationMessage`) and `cache_rebuild` (`HeadlessNotifyCacheRebuildMessage`),
  both extending `HeadlessNotifyMessage`.
- **Event** `headless_cms_notify.before_notify` (`Event\BeforeHeadlessNotifyEvent`) — call
  `abort()` to cancel a send.
- **Hooks** (`.module`): `hook_entity_insert/update/delete` → entity-operation notifications;
  `hook_rebuild` → schedules a cache-rebuild announcement; `hook_form_consumer_form_alter`,
  `hook_options_list_alter`, `hook_entity_base_field_info`.
- **Config object** `headless_cms_notify.settings` (empty mapping; schema in `config/schema`).

## Solution docs

- **Transports, consumer fields, routes/permissions, the settings page** →
  [config/settings.md](config/settings.md)
- **Services, message types & discovery, the plugin type, events, hooks** →
  [api/notifications.md](api/notifications.md)
