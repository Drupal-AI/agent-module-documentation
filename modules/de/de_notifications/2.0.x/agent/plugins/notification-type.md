<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `notification_type` plugin type

Delivery-channel plugin type. Implement one to send DEN notifications over a channel of your choice;
select the active plugin at `de_notifications.settings:notification_type`.

- Annotation: `src/Annotation/NotificationType.php` (`@NotificationType` with `id`, `label`).
- Interface: `src/Plugin/NotificationTypeInterface.php`.
- Base class: `src/Plugin/NotificationTypeBase.php` (implements `label()`).
- Manager: `src/Plugin/NotificationTypeManager.php`, service `plugin.manager.notification_type`
  (namespace `Plugin/NotificationType`, alter hook `de_notifications_notification_type_info`,
  cache key `de_notifications_notification_type_plugins`).

Discovery uses the classic annotation directory `Plugin/NotificationType/` inside any module.

## Methods to implement
Each sends one notification kind:
- `sendConfirmation($subscription)` — double opt-in confirm link.
- `sendSubscriptionConfirmed($subscription)` — after confirmation.
- `sendAlreadySubscribed($subscription)` — resubscribe attempt on a confirmed subscription.
- `sendSubscriptionOverview($subscriber, $langcode)` — list of the subscriber's subscriptions.
- `sendEntityNotification($subscription, $entity_title, $changes)` — an entity update.
- `sendArchived($subscription)` — a subscribed entity was unpublished.

## Who calls them
- `NotificationsSubscriptionHelper` resolves the active plugin via
  `NotificationTypeManagerInterface::hasDefinition()/createInstance()` (throws 409 if none configured
  or unknown) and calls the confirm/confirmed/already/overview methods inline during API requests.
- The `notify_subscribers` queue worker (`src/Plugin/QueueWorker/NotifySubscribers.php`, cron time
  600s) calls `sendEntityNotification` (`update`) or `sendArchived` (`archived`) from queued items
  produced by `hook_entity_update`; for `archived` it then deletes the subscription and prunes an
  orphaned subscriber.

## Building URLs & variables
Use `de_notifications.context` (`NotificationsContextService`) to obtain the tokenized front-end URLs
and the subscriber email / entity title / entity URL for your channel's payload (see
`../config/settings.md`).

## Bundled implementation
`de_notifications_symfony_mailer` provides the `symfony_mail` plugin (email). See
`../../../modules/de_notifications_symfony_mailer/2.0.x/agent/start.md`.
