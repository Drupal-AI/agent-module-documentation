<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Push framework notifications sends browser web-push notifications to subscribed users, bridging the Push Framework channel API and DANSE content-subscription events over the WebPush (VAPID) protocol.

---

Users subscribe from their DANSE notification settings; the browser's push subscription (endpoint + p256dh/auth keys) is stored per user in `user.data`, and delivery is performed by the Minishlink WebPush library signed with a server VAPID key pair. The VAPID subject/public/private keys are generated from the admin settings form and persisted in a dedicated `pf_notifications` database table via `KeysManager`; the private key is therefore held server-side in that table (standard for WebPush, but note it is not encrypted). Notifications are dispatched through `Service\Push::sendNotification()`, which initialises WebPush with the stored keys and reuses VAPID headers.

The subscription/service-worker routes (`/pf-notifications/service-worker`, `.../service-worker-reset`, `/pf-notifications/{entity_type}/{entity_id}/{key}/{type}`) are all gated by the `restful post pf_notifications_subscription` REST permission with cookie auth, and every write is keyed to the authenticated `current_user` — there is no anonymous or arbitrary-uid subscription write. The per-user notifications tab (`/user/{user}/danse/pf_notifications`) explicitly checks that the viewer is that user or holds `administer notifications`. Admin key-reset and subscription-removal forms require `administer push notifications`. Security notes: no disabled TLS, no raw SQL (query builder used), flood control is injected; the main exposure is the plaintext VAPID private key in the custom table.

Set-up: install Push Framework and DANSE, enable this module, generate VAPID keys and set the subject/options at `/admin/config/system/push_framework/pf_notifications`, then let users subscribe from their DANSE settings.

---

- Generate a VAPID key pair and set the notification subject in the settings form.
- Enable browser web-push delivery for DANSE content subscriptions.
- Let a user subscribe to notifications from their DANSE notification settings.
- Register the push service worker at `/pf-notifications/service-worker`.
- Unregister the service worker (Clear-Site-Data) via the reset route.
- Re-subscribe or toggle a subscription for the current user on a given entity/key.
- Show a per-user notifications tab at `/user/{user}/danse/pf_notifications`.
- Restrict configuration with the `administer push notifications` permission.
- Gate subscription routes behind the `restful post pf_notifications_subscription` REST permission.
- Reset all VAPID keys and clear every subscription from `/admin/pf_notifications/reset-keys`.
- Remove a specific subscription via `/admin/pf_notifications/remove`.
- Deliver payloads through the Minishlink WebPush library with reused VAPID headers.
- Store per-user push subscriptions (endpoint + keys) in `user.data`.
- Prune expired/failed push endpoints automatically from delivery reports.
- Apply flood control to subscription operations.
- Let `administer notifications` holders view another user's notification settings.
- Send test notifications to verify a subscription works.