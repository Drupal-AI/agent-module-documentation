<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Advanced Notifications sends VAPID-signed browser push notifications and adds an in-site notification-bell inbox, with campaign scheduling, role targeting and delivery reporting.

---

Advanced Notifications turns Drupal into a notification hub built on two content entities. A **Subscription** entity (`web_push_subscription`) stores each browser's Push API endpoint plus its key and auth token; browsers register through a REST resource (`POST /rest/api/post/push_notifications_subscribe`) and a small service worker served at `/js/advanced-notifications/service-worker`. A **Campaign** entity (`web_push_campaign`, labelled "Advanced Notification") holds a notification's title, body, link, icon, image, target roles, delivery mode and schedule. Administrators draft campaigns, send them immediately or schedule them; `hook_cron` enqueues due campaigns and a queue worker hands each one to the `minishlink/web-push` library, which delivers a VAPID-signed push to every matching subscription. Each campaign's `delivery_mode` decides whether it goes out as a browser push, appears in the in-site **notification bell**, or both. The bell is a placeable block for authenticated users that polls JSON endpoints for an unread count and the item list and lets the user dismiss one or clear all — read-state is kept per user in `user.data`, so the bell needs no extra storage. A separate subscription block lets visitors opt in or out of browser notifications, with an optional automatic or manual pre-prompt. Site configuration lives under **Configuration → Web services → Advanced Notifications**: default push options (TTL, urgency, topic, batch size, prompt behaviour, how long/many bell items show), VAPID key generation, and flood control on the subscribe endpoint. A delivery report lists sent campaigns with targeted/delivered counts. The module requires core REST, Serialization and User, PHP 8.1 with the mbstring/curl/openssl extensions, and an HTTPS site (a hard requirement of the browser Push API). It was inspired by and partially derived from the Web Push module, adding campaigns, scheduling, role targeting, reporting and the bell inbox.

---

- Send a browser push notification to everyone who has subscribed.
- Send an internal announcement to staff and show it in an in-site notification bell.
- Draft a notification campaign and schedule it to send at a future date/time.
- Target a notification to specific Drupal roles (empty target = everyone).
- Choose per campaign whether it is a browser push, a bell alert, or both (`delivery_mode`).
- Give logged-in users a bell inbox with an unread badge, item list, dismiss and clear-all.
- Let visitors opt in to browser notifications through a placeable subscription block.
- Prompt visitors to subscribe automatically after a delay, only on allowed paths.
- Show a manual pre-prompt message before the native browser permission dialog.
- Generate and store VAPID keys from the admin UI for Web Push authentication.
- Report on sent notifications: targeted users, delivered count and delivery rate.
- Rate-limit the subscribe endpoint with built-in flood control (threshold + window).
- Run intranet-style member notifications and editorial messages from Drupal.
- Re-engage users with campaign-style push notifications.
- Deliver time-sensitive alerts using push urgency and TTL settings.
- Attach an icon and image to a push notification, with a theme-logo fallback.
- Send users to a chosen link when they click a notification (same-host enforced).
- Batch large sends with a configurable batch size for the Web Push library.
- Automatically drop subscriptions whose endpoint the push service reports as expired.
- Control how many days or how many recent notifications the bell shows.
- Place the notification bell block in a header or toolbar region for authenticated users.
- Grant only trusted roles the REST permission needed to register a subscription.
- Keep VAPID keys and flood settings behind restricted "sensitive settings" permissions.
- Migrate from the Web Push module and gain campaigns, scheduling, targeting and reporting.
