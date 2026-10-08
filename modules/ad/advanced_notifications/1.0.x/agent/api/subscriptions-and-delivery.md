<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entities, subscribe REST, delivery pipeline & the bell inbox

## Entities

**`web_push_subscription`** (`src/Entity/Subscription.php`) — one browser subscription.
Base fields: `key` (Push `p256dh` public key, ≤191), `token` (`auth` secret, ≤191), `endpoint`
(push service URL, ≤512), `created`, `uid` (owner, entity_reference to user). `admin_permission =
administer web push subscriptions`. Handlers: `SubscriptionStorageSchema` (indexes),
`SubscriptionViewsData`, `SubscriptionListBuilder`, delete form only. Links: collection +
delete-form. Getters/setters: `getPublicKey/getToken/getEndpoint/getUser/getUserId`.

**`web_push_campaign`** (`src/Entity/Campaign.php`, label "Advanced Notification") — one
notification. Fields incl. `title` (label), `body` (string_long), `link` (uri), `icon`/`image`
(uri), `status` (`draft`/`scheduled`/`sent`), `scheduled_send_at`, `sent_at`, `delivery_mode`
(`both`/`browser_only`/`bell_only`), `send_browser_notification` (legacy bool), `target_roles`
(multi string of role IDs; empty = everyone), `target_audience_count`, `delivered_count`, `queued`.
Helpers: `getStatus()`, `getDeliveryMode()`, `shouldSendBrowserNotification()`,
`shouldShowInNotificationBell()`. `admin_permission = administer web push campaigns`; full CRUD via
`AdminHtmlRouteProvider`.

## Subscribing (browser → Drupal)

`Hook\AdvancedNotificationsHooks::pageAttachmentsAlter()` runs only for users with `restful post
web_push_subscription` and only when a VAPID public key exists; it injects
`drupalSettings.webPush` = `{ publicKey, serviceWorkerUrl, subscribeUrl, autoPrompt, manualPrePrompt }`
(**public key only** — never the private key) and, when auto-prompt is enabled and the path is
allowed, attaches the `auto_subscription` library. The subscribe/bell JS registers the service
worker (route `advanced_notifications.service_worker` → `WebPushController::serviceWorker`, which
returns `importScripts('/<module>/js/service_worker_notification.js')` with header
`Service-Worker-Allowed: /`), asks the browser for permission, then POSTs the Push subscription.

**REST resource** `SubscriptionResource` (`@RestResource id="web_push_subscription"`,
`uri_paths.create = /rest/api/post/push_notifications_subscribe`; core route
`rest.web_push_subscription.POST`). `post()`:

- optional flood control (`advanced_notifications.security`): registers `web_push.rest.post` and,
  if over threshold in the window, returns a plain `200 OK` (deliberately does not reveal blocking).
- reads `key`/`token`/`endpoint`, trims, enforces length caps (191/191/512) and
  `isValidPushEndpoint()` (`UrlHelper::isValid` **and** scheme must be `https`).
- de-dupes by `(key, token)`; creates a new subscription attributed to `currentUser->id()`, or
  updates the endpoint/uid of the existing row. Invalid input → `BadRequestHttpException`.

Config `rest.resource.web_push_subscription` enables method `POST`, format `json`, auth `cookie`.

## Sending a campaign

`Service\CampaignManager` (`advanced_notifications.manager`):
- `sendCampaign(Campaign)` — guards against duplicate sends (status `sent`/`sent_at` set), builds a
  payload `{content:{title,body,icon,url}, options:{topic,urgency}, subscriptionIds}`, and, if
  `shouldSendBrowserNotification()`, calls `WebPushSender::sendNotification()`. Writes back
  `status=sent`, `sent_at`, `target_audience_count`, `delivered_count`.
- `getTargetSubscriptionIds()` — `NULL` (all) when no `target_roles`; otherwise loads subscriptions
  and keeps those whose owner user has an intersecting role.
- `scheduleCampaign()` / `enqueueDueCampaigns()` (`hook_cron`) → queue `web_push_campaign_send`
  (`CampaignQueueWorker`) → `processQueuedCampaign()` → `sendCampaign()`.

`Service\WebPushSender` (`advanced_notifications.sender`) — wraps `Minishlink\WebPush\WebPush`
(auth from `AuthenticationHelper::getAuth()`: subject=front URL, public+private VAPID keys; options
TTL/urgency/topic/batchSize; `setReuseVAPIDHeaders(TRUE)`). `buildSubscription()` builds a
`WebPushSubscription` from the stored endpoint/key/token and JSON-encodes the payload;
`sanitizeClickUrl()` forces the click URL to the current host (external hosts → site front,
logged); `manageReport()` deletes subscriptions the push service reports as expired.
`Service\WebPushManager` (`advanced_notifications.push_manager`) resolves the notification icon
(candidate → default config icon → theme logo/favicon fallback, http(s) only) and exposes a
convenience `sendNotification(...)` that pushes onto the `advanced_notifications` queue
(`WebPushQueueWorker`).

## The notification bell (in-site inbox)

**Block** `advanced_notifications_bell_block` (`Plugin\Block\WebPushIntranetBellBlock`) — visible to
authenticated users; renders a bell button + live count badge and data-attributes carrying the four
endpoint URLs, with **CSRF tokens** minted for the dismiss/clear endpoints. Library
`advanced_notifications/notifications` (`js/advanced_notifications.js`) builds the panel purely with
`document.createElement` + `textContent` (item titles/bodies are set as text, links via an `<a>`).

**Endpoints** (`WebPushNotificationController`, all `_user_is_logged_in: TRUE`):
- `…/notifications/unread-count` → `unreadCount()`
- `…/notifications/items` → `items()`
- `…/notifications/dismiss` (POST) → `dismiss()` — validates CSRF token `advanced_notifications_dismiss`
- `…/notifications/clear` (POST) → `clearAll()` — validates CSRF token `advanced_notifications_clear`

All delegate to `Service\WebPushNotificationInbox` (`advanced_notifications.notification_inbox`),
which computes the visible set **for the current account only**: sent campaigns, filtered by the
per-user clear timestamp and dismissed-id list (both stored in `user.data` under
`advanced_notifications`), by the `days`/`count` display window, and by `target_roles` matching the
account's roles. Responses are `private, no-cache`.

## Blocks summary & subscribe UI

- `advanced_notifications` (`WebPushBlock`) — subscribe/unsubscribe UI; renders the
  `web_push_subscription` theme + `manual_subscription` library only when config `displayBlock` is
  on; `blockAccess` requires `restful post web_push_subscription`.
- `advanced_notifications_bell_block` — the bell above.
