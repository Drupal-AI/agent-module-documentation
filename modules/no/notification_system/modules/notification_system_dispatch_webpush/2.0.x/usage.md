<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Notification System Dispatch Web Push delivers a user's notifications as browser and Safari push notifications.

---

This is the web-push channel for the dispatch framework. It registers a `webpush` dispatcher that renders a user's pending notifications through admin Twig templates and pushes them out two ways: to standard browser Web Push subscriptions using a VAPID key pair (through the web_push_api contrib module), and to Safari/macOS using Apple's push service and a .p12 certificate. The submodule provides the pieces a push setup needs: a service-worker route, a client-side library, an opt-in popup block that asks visitors to enable notifications, and an integration into the per-user dispatch settings so each user can toggle push. For Apple it adds an `apple_registration` entity to hold device tokens, a per-user token table, and an Apple Web Service endpoint set (push package download, device registration and deletion, user token, and a log callback). VAPID keys, icons/badges and the Apple certificate are configured on the dispatcher settings form. Standard Web Push requires the web_push_api module.

---

- Send browser push notifications to subscribed users.
- Send Safari/macOS push notifications via Apple Push.
- Ask visitors to opt in with a configurable popup block.
- Serve a service worker to receive and display push messages.
- Render push title and body from admin Twig templates.
- Bundle multiple notifications into one push with a summary.
- Show an app icon and badge on push notifications.
- Deep-link a push to the notification's target URL.
- Let each user enable or disable the push channel.
- Route only chosen notification groups to push per user.
- Register and remove Safari device tokens per user.
- Issue and look up a per-user Apple push token.
- Generate a Safari push package for a signed-in user.
- Limit body length for push payload size.
- Combine push with email so notifications reach users both ways.
- Force critical notifications to push regardless of user opt-out.
- Clean up a user's tokens and registrations when their account is deleted.
