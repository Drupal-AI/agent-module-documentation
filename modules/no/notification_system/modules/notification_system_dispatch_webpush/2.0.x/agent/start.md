<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Notification System Dispatch Web Push (notification_system_dispatch_webpush) — agent index

The **web-push channel** for `notification_system_dispatch`. Registers a `webpush`
`notification_system_dispatcher` plugin that sends browser Web Push (VAPID, via `web_push_api`) and
Safari/Apple Push (.p12 cert). Depends on `notification_system`, `notification_system_dispatch`,
`web_push_api`. (info.yml `configure` points, mistakenly, at `notification_system_dispatch_mail.settings`.)

## Solution docs
- **The `webpush` dispatcher, clients, templates, VAPID/Apple config** → [plugins/webpush-dispatcher.md](plugins/webpush-dispatcher.md)
- **Routes: service worker + Apple Web Service; apple_registration entity; user tokens** → [routes/apple-webservice.md](routes/apple-webservice.md)

## Provides
- Plugin **`webpush`** (`src/Plugin/NotificationSystemDispatcher/WebpushDispatcher.php`) — renders
  `subject_template`/`body_template` Twig (body via `Html2Text`, truncated to `body_max_length`),
  then `sendWebPush()` (VAPID) + `sendAppleWebPush()` (if apple enabled).
- Services: **`notification_system_dispatch_webpush`** = `WebPushClient` (wraps `web_push_api`
  `WebPush`/`WebPushAuthVapid`; `sendToUser`/`sendToAll`, deletes dead subscriptions);
  **`notification_system_dispatch_webpush.apple`** = `AppleWebPushClient` (user-token table, device
  registrations, APNS send via `JWage\APNS`).
- Entity **`apple_registration`** (`src/Entity/AppleRegistration.php`) — device tokens per user;
  list at `/admin/config/services/apple-registration` (`administer apple registration entities`).
- Table **`notification_system_dispatch_webpush_apple_user_tokens`** (`uid`, `token`) — per-user
  Apple token (a UUID).
- Block **`notification_system_dispatch_webpush_popup`** (`Plugin/Block/PopupBlock`) — opt-in
  prompt; only shown if the user has the `webpush` channel enabled.
- Libraries `lib` / `popup_block` / `usersettings_block` (`.libraries.yml`); vendored JS in `js/`
  (`webpush_lib.js`, `webpush_serviceworker.js`, popup + usersettings blocks).
- `hook_library_info_alter` injects `drupalSettings.notificationSystemDispatchWebpush`
  (VAPID public key, service-worker URL, `web_push_api.subscription` URL, apple flags/URLs).

## Routes (`notification_system_dispatch_webpush.routing.yml`)
- `…serviceworker` — `/notification-system-dispatch-webpush-serviceworker.js` — `access content`.
- `entity.apple_registration.collection` — `/admin/config/services/apple-registration` —
  `administer apple registration entities`.
- Apple Web Service set under `/notification-system-dispatch-webpush/apple*` — most gated by
  `_custom_access: AppleController::access` (which only checks *apple push is enabled*); the `log`
  route is `_access: TRUE`. See routes doc.

## Config
`notification_system_dispatch_webpush.settings` — `subject_template`, `body_template`,
`body_max_length`, `vapid_public_key`, `vapid_private_key`, `icon_path`, `badge_path`,
`apple_enabled`, `apple_cert_path`, `apple_cert_password`, `apple_website_push_id`. Schema in
`config/schema/`. Permission `administer apple registration entities` (`restrict access: true`).
Config-translatable.
