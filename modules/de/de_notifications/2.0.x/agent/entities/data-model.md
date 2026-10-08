<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entities & data model

Two content entity types, both `ContentEntityBase` + `EntityChangedTrait`, admin-managed with list
builders, delete/save actions (`config/install/system.action.*`), HTML route providers, and
`EntityViewsData`.

## de_notifications_subscriber
Class `src/Entity/NotificationsSubscriber.php`. Base table `de_notifications_subscriber`.
`entity_keys`: id, label = `email`, uuid. Admin permission `administer de_notifications_subscriber`.
Base fields:
- `email` (email, required, `UniqueField` constraint) — the subscriber address; entity label.
- `ip_address` (string, required) — captured from the subscribe request `X-Client-Ip` header.
- `bounce_count` (integer, unsigned, default 0) — deliverability counter.
- `created`, `changed` timestamps.

`__toString()` returns the email.

## de_notifications_subscription
Class `src/Entity/NotificationsSubscription.php`. Base table `de_notifications_subscription`.
`entity_keys`: id, label = id, uuid. Admin permission `administer de_notifications_subscription`.
Base fields:
- `subscriber` (entity_reference → `de_notifications_subscriber`, required).
- `entity` (**dynamic_entity_reference**, required) — the subscribed target entity. Allowed
  entity-type/bundle settings are derived from state `target_entity_bundles` (populated by
  `hook_entity_bundle_field_info_alter` as bundles gain/lose the `notification_settings` field).
- `langcode` (language, required) — the subscribed translation.
- `is_confirmed` (boolean, default FALSE) — set TRUE by the confirm endpoint.
- `last_confirmation_sent` (created/timestamp) — used by cron cleanup.
- `created`, `changed` timestamps.

## Access
`src/NotificationsSubscriptionAccessControlHandler.php` and
`src/NotificationsSubscriberAccessControlHandler.php`: admin permission short-circuits to allowed;
otherwise view/update/delete map to `view|edit|delete de_notifications_subscription` (resp.
`_subscriber`) permissions; create requires `create …` OR `administer …`. Permissions are declared in
`de_notifications.permissions.yml` (the three `administer …` perms are `restrict access: true`).

## Lifecycle & cleanup
- `hook_cron` (`de_notifications.module`) deletes unconfirmed subscriptions whose
  `last_confirmation_sent` is older than `ttl_confirm`, then removes orphaned subscribers
  (query uses `accessCheck(FALSE)` for this internal maintenance).
- Unsubscribe/unsubscribe-all and the `archived` queue path delete subscriptions and prune
  subscribers with no remaining subscriptions (`NotificationsSubscriptionHelper::cleanSubscriber`,
  `NotifySubscribers::processItem`).

## Views
Shipped as optional config: `views.view.notification_subscriptions`, `views.view.notification_subscribers`.
Custom Views fields: `Plugin/views/field/NotificationStatus.php`,
`Plugin/views/field/NotificationsSubscriberCount.php` (declared via `de_notifications.views.inc`).
