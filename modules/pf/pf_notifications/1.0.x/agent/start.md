<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Push framework notifications (pf_notifications) — agent index

**Browser web-push notifications over WebPush/VAPID, bridging Push Framework channels and DANSE content subscriptions.**

- **Version:** 1.0.x (1.0.1-beta2)
- **Core:** ^10.3 || ^11 (PHP 8.1)
- **Configure:** `/admin/config/system/push_framework/pf_notifications` (`pf_notifications.settings`)
- **Dependencies:** drupal:rest, drupal:user, drupal:views, push_framework:push_framework, danse:danse_content

## Routes
- `pf_notifications.settings`, `.reset_keys`, `.remove_subscription` — perm `administer push notifications`
- `.service_worker`, `.service_worker_reset`, `.re_subscribe` (`/pf-notifications/{entity_type}/{entity_id}/{key}/{type}`) — perm `restful post pf_notifications_subscription`
- `.user.notification_settings` — `/user/{user}/danse/pf_notifications` — perm `restful post pf_notifications_subscription` + code check (self or `administer notifications`)

## Permissions
`administer push notifications` (+ REST `restful post pf_notifications_subscription`)

## Services
`pf_notifications.base` / `.subscription` / `.push` (WebPush send), `pf_notifications.keys_manager` (VAPID keys in `pf_notifications` table), `pf_notifications.route_subscriber` (DANSE route override).

**Security:** all subscription/service-worker routes require the REST post permission (cookie auth) and write only to the authenticated `current_user`'s `user.data` — no anonymous or cross-uid write. User tab enforces self-or-admin. Uses the query builder (no raw SQL) and flood control. VAPID delivery via Minishlink WebPush at library-default TLS. Only notable exposure: VAPID private key stored unencrypted in the `pf_notifications` DB table (KeysManager.php).

See [configure/setup.md](configure/setup.md)
