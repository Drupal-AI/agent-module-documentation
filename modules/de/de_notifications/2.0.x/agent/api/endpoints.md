<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON API & subscription flow

Controller `src/Controller/NotificationsSubscriptionController.php`; logic in
`src/NotificationsSubscriptionHelper.php`. All routes are `POST`, `_format: json`, defined in
`de_notifications.routing.yml`. Each is permission-gated; confirm/unsubscribe/overview additionally
require a valid signed JWT token (see config/settings.md).

## Endpoints

| Route id | Path | Permissions (requirements) | Body params |
|---|---|---|---|
| `de_notifications.subscribe` | `/api/v1/de_notifications/subscribe` | `create de_notifications_subscription` AND `create de_notifications_subscriber` | `email`, `entity_type`, `eid` + header `X-Client-Ip` |
| `de_notifications.confirm` | `/api/v1/de_notifications/confirm` | `edit de_notifications_subscription` | `token` |
| `de_notifications.unsubscribe` | `/api/v1/de_notifications/unsubscribe` | `delete de_notifications_subscription` AND `delete de_notifications_subscriber` | `token` |
| `de_notifications.unsubscribe_all` | `/api/v1/de_notifications/unsubscribe/all` | `delete de_notifications_subscription` AND `delete de_notifications_subscriber` | `token` |
| `de_notifications.request_subscription_overview` | `/api/v1/de_notifications/request_subscription_overview` | `view de_notifications_subscription` AND `view de_notifications_subscriber` | `token` |

For a public headless front-end, grant the relevant permissions to the anonymous role; the token
requirement is what actually authorizes confirm/unsubscribe/overview (the token encodes the
subscription/subscriber UUID).

## Responses

JSON `{ "status": "success"|"error", "message": ..., "data"?: ... }`. `NotificationsException`
carries an HTTP code used as the response status (e.g. 400 missing/invalid input, 401 invalid token,
403 subscribing not enabled on entity, 404 entity/subscription not found, 409 no notification type
configured, 410 token expired). Any other throwable yields a generic 500.

## subscribe() flow (`NotificationsSubscriptionHelper::subscribe`)
1. Load `entity_type`/`eid`; resolve the requested `langcode` translation (current content language).
2. `subscriptionEnabled($entity)` — true only if the bundle has a `notification_settings` field with
   `subscription_enabled` set; otherwise 403.
3. Find/create a `de_notifications_subscriber` by `email` (stores `ip_address` from `X-Client-Ip`).
4. If an existing subscription is confirmed → send "already subscribed"; if unconfirmed → resend
   confirmation (updates `last_confirmation_sent`); else create the subscription and send confirmation.
5. `getEntityData()` returns `entityLabel` only when `$entity->access('view')` passes.

## confirm / unsubscribe / unsubscribeAll / requestSubscriptionOverview
- Each calls `NotificationsTokenService::validateToken($token)` to recover the UUID, then loads the
  subscription (confirm/unsubscribe) or subscriber (unsubscribe-all/overview) by `uuid`.
- `confirm`: sets `is_confirmed = TRUE`, sends "subscription confirmed" (idempotent — reports
  `alreadyConfirmed`).
- `unsubscribe`: deletes the one subscription, then `cleanSubscriber()` deletes the subscriber if no
  subscriptions remain.
- `unsubscribeAll`: deletes all subscriptions and the subscriber.
- `requestSubscriptionOverview`: sends the subscriber an overview email of confirmed subscriptions.

## Sending
Notifications are produced by the configured `notification_type` plugin (config
`de_notifications.settings:notification_type`); if none is set the helper throws (409). Entity-update
notifications are queued (not sent inline) — see plugins/notification-type.md and the module's
`hook_entity_update` / `notify_subscribers` queue worker.
