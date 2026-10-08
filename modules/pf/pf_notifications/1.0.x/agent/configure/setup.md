<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setting up Push framework notifications

## Prerequisites
Install and enable **Push Framework** and **DANSE** (danse_content), plus core rest/user/views. Then `drush en pf_notifications -y`.

## 1. Generate VAPID keys
At `/admin/config/system/push_framework/pf_notifications` (perm `administer push notifications`):
- Generate/enter the **VAPID public + private key** pair and a **subject** (a `mailto:` or site URL).
- Keys are stored in the `pf_notifications` table via `KeysManager` (`vapid_subject`, `vapid_public`, `vapid_private`). `Service\Base::getKeys()` reads them back for the service worker and for signing.
- Reset keys at `/admin/pf_notifications/reset-keys` — this clears keys **and all existing subscriptions** (they become invalid).

## 2. Service worker
The browser registers the worker served by `pf_notifications.service_worker` (`/pf-notifications/service-worker`), which returns the module's `js/pf_notifications.service_worker.js` with `Service-Worker-Allowed: /`. `service-worker-reset` re-serves it with a `Clear-Site-Data: storage` header to unregister.

## 3. Subscribing
Users subscribe from their DANSE notification settings; `re_subscribe` (`/pf-notifications/{entity_type}/{entity_id}/{key}/{type}`) toggles a subscription for the **current user** only. The push subscription (endpoint + keys) is stored in `user.data` under the `danse` module namespace, keyed by the DANSE subscription key.

## 4. Delivery
When a DANSE event fires, Push Framework invokes `Service\Push::sendNotification()`, which builds a Minishlink `WebPush` client from the VAPID keys (`initWebPush()`, `setReuseVAPIDHeaders(TRUE)`), attaches the payload, and flushes to each stored subscription endpoint. Failed/expired endpoints are pruned via `manageReport()`.

## Access model
- Subscription + service-worker routes: `restful post pf_notifications_subscription` (cookie auth), writes scoped to `current_user`.
- `/user/{user}/danse/pf_notifications`: viewer must be that user or hold `administer notifications`.
- Admin forms (reset keys, remove subscription): `administer push notifications`.
