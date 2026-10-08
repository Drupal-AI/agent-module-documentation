<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Service worker route, Apple Web Service endpoints, and the apple_registration entity

Controllers: `src/Controller/WebpushController.php`, `src/Controller/AppleController.php`.

## Service worker
`notification_system_dispatch_webpush.serviceworker` — `/notification-system-dispatch-webpush-serviceworker.js`,
`access content`. `WebpushController::serviceWorker()` returns `js/webpush_serviceworker.js` with
`Service-Worker-Allowed: /` and `Content-Type: application/javascript` (cache max-age 1). Its URL is
injected into `drupalSettings` by `hook_library_info_alter`.

## Apple Web Service (implements Apple's Safari push protocol)
All under `/notification-system-dispatch-webpush/apple…`. `AppleController::access()` returns
allowed **iff `AppleWebPushClient::isEnabled()`** (i.e. gated only by *whether Safari push is turned
on*, not by any user permission), except `log` which is `_access: TRUE`.

| Route | Path | Method | Access | Controller |
|---|---|---|---|---|
| `…apple_redirect` | `/apple-redirect` | GET | custom `access()` | `redirectNotification` |
| `…apple_usertoken` | `/apple-usertoken` | GET | `access()` + logged-in | `userToken` |
| `…apple` | `/apple` | any | `access()` | (title only) |
| `…apple.pushpackage` | `/apple/{version}/pushPackages/{websitePushId}` | POST | `access()`, json | `pushpackage` |
| `…apple.registration` | `/apple/{version}/devices/{deviceToken}/registrations/{websitePushId}` | POST | `access()` | `registration` |
| `…apple.delete` | (same path) | DELETE | `access()` | `delete` |
| `…apple.log` | `/apple/{version}/log` | POST | `_access: TRUE` | `log` |

- `userToken()` — returns the **current** user's Apple token (`getUserToken($uid)`), cached per user.
- `pushpackage()` — validates the website push id, loads the `.p12`, requires HTTPS, reads
  `user_token` from the JSON body, validates it via `getUserByToken()`, and returns a generated push
  package zip (`MyPackageGenerator` / `JWage\APNS`).
- `registration()` / `delete()` — read the Apple `Authorization: ApplePushNotifications <userToken>`
  header, resolve the user via `getUserByToken()`, and create/delete an `apple_registration` for the
  `{deviceToken}`. (These are Apple's device-callback endpoints; auth is the bearer user-token, not a
  Drupal session.)
- `log()` — anonymous; decodes JSON body and logs `body->logs` as a warning (Apple error callback).

## `apple_registration` entity
`src/Entity/AppleRegistration.php` — content entity holding a `uid` + `device_token`. Admin list at
`/admin/config/services/apple-registration` (`administer apple registration entities`,
`restrict access: true`). `hook_ENTITY_TYPE_delete(user)` removes a deleted user's token rows and
registrations.

## User-token table
`notification_system_dispatch_webpush_apple_user_tokens` (`uid`, `token`; PK both). Token is a
random UUID minted on first `getUserToken()`; it is the bearer credential the Safari JS presents to
the registration/pushpackage endpoints.
