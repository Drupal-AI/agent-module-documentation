<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Decoupled Entity Notifications (de_notifications) — agent index

Email-based "subscribe to entity changes" for decoupled/headless Drupal. A JSON API drives a
double opt-in flow secured by signed JWT tokens; entity updates queue notifications to confirmed
subscribers. Delivery is pluggable; a Symfony Mailer submodule ships as the default channel.

- **Machine name:** `de_notifications` · **Package:** Decoupled Entity Notifications · **License:** GPL-2.0-or-later
- **Core:** `^10 || ^11` · **Requires:** `drupal/dynamic_entity_reference` (^3.2), `firebase/php-jwt` (^7)
- **Configure route:** `de_notifications.settings` → `/admin/config/system/de_notifications`
- **Submodule:** `de_notifications_symfony_mailer` (DENSM) — see `../../modules/de_notifications_symfony_mailer/2.0.x/agent/start.md`

## Entities (content, base fields only)
- `de_notifications_subscriber` — `email` (unique), `ip_address`, `bounce_count`, timestamps. Class `src/Entity/NotificationsSubscriber.php`.
- `de_notifications_subscription` — `subscriber` (entity ref), `entity` (Dynamic Entity Reference to target), `langcode`, `is_confirmed`, `last_confirmation_sent`, timestamps. Class `src/Entity/NotificationsSubscription.php`.
- Access handlers: `NotificationsSubscriberAccessControlHandler`, `NotificationsSubscriptionAccessControlHandler` (permission-based).

## Field, plugin type, queue, hooks
- Field type `notification_settings` (`src/Plugin/Field/FieldType/NotificationSettingsItem.php`) with widget + formatter — add to a bundle to allow subscribing.
- Plugin type `notification_type` (`@NotificationType` annotation, manager `plugin.manager.notification_type`) — implement to add a delivery channel.
- Queue worker `notify_subscribers` (`src/Plugin/QueueWorker/NotifySubscribers.php`, cron) sends `update`/`archived` notifications.
- Hooks in `de_notifications.module`: `hook_entity_update` (queue notifications), `hook_cron` (prune unconfirmed), `hook_entity_bundle_field_info_alter` (track subscribable bundles in state `target_entity_bundles`).
- Views field plugins: `NotificationStatus`, `NotificationsSubscriberCount`.

## Services
- `de_notifications.subscription_helper` (`NotificationsSubscriptionHelper`) — subscribe/confirm/unsubscribe business logic.
- `de_notifications.token` (`NotificationsTokenService`) — JWT `generateToken`/`validateToken` (HS256, secret from config).
- `de_notifications.context` (`NotificationsContextService`) — builds tokenized front-end URLs + email variables.
- `plugin.manager.notification_type` (`NotificationTypeManager`).

## Routes / API (all POST, JSON)
`/api/v1/de_notifications/subscribe`, `/confirm`, `/unsubscribe`, `/unsubscribe/all`, `/request_subscription_overview`. Controller `NotificationsSubscriptionController`.

## Solution docs
- API endpoints & flow: [agent/api/endpoints.md](api/endpoints.md)
- Configuration & JWT secret: [agent/config/settings.md](config/settings.md)
- Entities & data model: [agent/entities/data-model.md](entities/data-model.md)
- The `notification_settings` field: [agent/fields/notification-settings.md](fields/notification-settings.md)
- The `notification_type` plugin type: [agent/plugins/notification-type.md](plugins/notification-type.md)
