<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Notifications (advanced_notifications) — agent index

Browser **Web Push** notifications + an in-site **notification-bell inbox**, with campaign
scheduling, role targeting and delivery reporting. Package `Notification`. Core
`^10.3 || ^11 || ^12`, **PHP 8.1** (ext mbstring/curl/openssl). Depends on core **rest**,
**serialization**, **user**; requires the **`minishlink/web-push` ^9.0** Composer library and an
**HTTPS** site. License GPL-2.0-or-later. Version 1.0.1. Inspired by / partially derived from the
Web Push module.

- **Config objects, admin routes, forms, permissions, VAPID + flood** →
  [config/settings.md](config/settings.md)
- **Entities, REST subscribe, delivery pipeline, the bell inbox, blocks** →
  [api/subscriptions-and-delivery.md](api/subscriptions-and-delivery.md)

## What it provides (from source)

- **Entities** (both `ContentEntityType`, admin-permission gated):
  - `web_push_subscription` (`Entity\Subscription`) — a browser subscription: `key`, `token`,
    `endpoint`, `created`, `uid`. Admin perm `administer web push subscriptions`. Collection +
    delete-form only; `SubscriptionStorageSchema`, `SubscriptionViewsData`, `SubscriptionListBuilder`.
  - `web_push_campaign` (`Entity\Campaign`, label "Advanced Notification") — a notification:
    `title`/`body`/`link`/`icon`/`image`/`status`/`scheduled_send_at`/`sent_at`/`delivery_mode`/
    `send_browser_notification`/`target_roles`/`target_audience_count`/`delivered_count`/`queued`.
    Admin perm `administer web push campaigns`. Full CRUD via `AdminHtmlRouteProvider`; `CampaignForm`,
    `CampaignDeleteForm`, `CampaignListBuilder`.
- **REST resource** `web_push_subscription` (`Plugin\rest\resource\SubscriptionResource`) — POST to
  `/rest/api/post/push_notifications_subscribe`, gated by permission `restful post
  web_push_subscription` (cookie auth; config `rest.resource.web_push_subscription`, granted to no
  role by default).
- **Services**: `advanced_notifications.sender` (`WebPushSender`), `.push_manager`
  (`WebPushManager`), `.manager` (`CampaignManager`), `.notification_inbox`
  (`WebPushNotificationInbox`), `.authentication_helper` (`AuthenticationHelper`), `.breadcrumb`,
  and the `AdvancedNotificationsHooks` OOP hook service.
- **Queue workers**: `web_push_campaign_send` (`CampaignQueueWorker`, cron) drains scheduled
  campaigns; `advanced_notifications` (`WebPushQueueWorker`) sends a prepared payload.
- **Blocks**: `advanced_notifications` (subscribe/unsubscribe UI), `advanced_notifications_bell_block`
  (notification bell for authenticated users).
- **Controllers**: `WebPushController::serviceWorker` (service-worker JS, `_access: TRUE`),
  `WebPushNotificationController` (bell JSON endpoints, login-required), `CampaignReportController`
  (report), `AdvancedNotificationsRedirectController` (301s legacy `/web-push` URLs).
- **Config objects**: `advanced_notifications.settings`, `.vapid`, `.security` (schema in
  `config/schema/advanced_notifications.schema.yml`). **Configure route**:
  `advanced_notifications.settings` (`/admin/config/services/advanced-notifications/default-settings`).
- **Permissions** (`advanced_notifications.permissions.yml`): `access list subscriptions`,
  `administer web push subscriptions` (restricted), `administer web push settings`, `administer web
  push sensitive settings` (restricted), `administer web push campaigns` (restricted).
- **Hooks** (`Hook\AdvancedNotificationsHooks`): `theme` (`web_push_subscription`),
  `page_attachments_alter` (injects the public VAPID key + subscribe URL for permitted users),
  `cron` (enqueue due campaigns).
- Ships CSS/JS behaviours and a service worker (`js/service_worker_notification.js`); no Drush.
