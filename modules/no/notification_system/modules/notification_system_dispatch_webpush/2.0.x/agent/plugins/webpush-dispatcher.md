<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `webpush` dispatcher and its clients

## Plugin (`src/Plugin/NotificationSystemDispatcher/WebpushDispatcher.php`)
`@NotificationSystemDispatcher(id="webpush", label="Push-Notification")`. Injects twig,
date.formatter, `notification_system_dispatch_webpush` (WebPushClient),
`notification_system_dispatch_webpush.apple` (AppleWebPushClient), file_system, library.discovery,
element_info manager, file_url_generator, logger; holds editable
`notification_system_dispatch_webpush.settings`.

- `dispatch($user, $notifications)` → `getVars()` then `sendWebPush()` + `sendAppleWebPush()`.
- `getVars()` — builds a `notifications` Twig variable (title; **body run through `Html2Text`** to
  plain text; timestamp; `link` = literal `http://example.com`; `direct_link` = absolute link).
  Renders `subject_template` (spaceless) and `body_template` via `twig->renderInline`,
  `htmlspecialchars_decode`s them, and truncates body to `body_max_length` (default 200).
- `sendWebPush()` — `WebPushNotification` with subject/body, sets language, open_url data
  (front page for bundles, else the notification link), badge/icon from config paths; calls
  `WebPushClient::sendToUser($uid, $notification)`.
- `sendAppleWebPush()` — no-op unless `apple_enabled`; calls `AppleWebPushClient::sendToUser($uid,
  subject, body, urlencoded link)`.
- `settingsForm()` / `settingsFormSubmit()` — VAPID key pair fields, icon/badge (path or managed
  upload to `public://webpush`), and the Safari section (enable flag, cert path/upload, cert
  password, website push id). Clears library/element caches when VAPID/apple/website-push-id change.

## `WebPushClient` (service `notification_system_dispatch_webpush`)
Wraps `web_push_api`: builds `WebPushAuthVapid(publicKey, privateKey)` from config.
- `send($webpush, $subscriptions, $notification)` — queue + flush in batches of 500; on a failed
  report, logs it and deletes the subscription by endpoint. Mozilla endpoints get padding 0.
- `sendToAll($notification)` — batched over all subscriptions.
- `sendToUser($uid, $notification)` — subscriptions `loadByUserId($uid)`.

## `AppleWebPushClient` (service `notification_system_dispatch_webpush.apple`)
- `isEnabled()` — config `apple_enabled`.
- `getWebsitePushId()` / `getCertificatePath()` (resolves stream wrapper or Drupal-root-relative,
  validates existence) / `getCertificatePassword()` — all throw if missing.
- `getUserToken($uid)` / `generateUserToken($uid)` — per-user token in
  `notification_system_dispatch_webpush_apple_user_tokens`; token is a **UUID** (`\Drupal::service('uuid')`).
- `getUserByToken($token)` — reverse lookup (exact match) → uid, throws if none.
- `sendToUser($uid, title, body, link)` — reads the `.p12` via
  `openssl_pkcs12_read(file_get_contents(cert), …, password)`, builds an APNS `Certificate`, opens a
  `SocketClient` to `gateway.push.apple.com:2195`, and sends to each of the user's
  `apple_registration` device tokens.

## Config object `notification_system_dispatch_webpush.settings`
`subject_template`, `body_template`, `body_max_length`, `vapid_public_key`, `vapid_private_key`,
`icon_path`, `badge_path`, `apple_enabled`, `apple_cert_path`, `apple_cert_password`,
`apple_website_push_id`. (See routes doc for the Apple endpoints and the service worker.)

## Operate
1. Enable + `web_push_api`. 2. Generate a VAPID key pair (the settings form shows the openssl
   commands) and paste both keys. 3. Optionally enable Safari, upload the `.p12` and set its
   password + website push id. 4. Place the popup block to collect opt-ins; the service worker is
   served at `/notification-system-dispatch-webpush-serviceworker.js`. 5. Users toggle the `webpush`
   channel in their dispatch settings. Delivery runs through the dispatch queue on cron.
