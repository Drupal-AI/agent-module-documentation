<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON:API User Resources — endpoint reference

Grounded in `src/Routing/Routes.php`, `src/Resource/{Registration,PasswordReset,PasswordUpdate}.php`,
and the module's own functional tests under `tests/src/Functional/`.

All paths below assume the default JSON:API base path `/jsonapi`. Every route is built by
`Routes::routes()`, which appends `_user_is_logged_in: 'FALSE'` to all three — **send them as an
anonymous client (no session cookie / no auth); an authenticated request returns 403.**

Use JSON:API headers on every call:

```
Content-Type: application/vnd.api+json
Accept: application/vnd.api+json
```

## 1. Register — `POST /jsonapi/user/register`

Maps the document to a new `user--user` entity (`Registration`, built on
`jsonapi_resources` `EntityCreationTrait`).

```bash
curl -X POST 'https://example.com/jsonapi/user/register' \
  -H 'Content-Type: application/vnd.api+json' \
  -H 'Accept: application/vnd.api+json' \
  -d '{
    "data": {
      "type": "user--user",
      "attributes": {
        "name": "jane",
        "mail": "jane@example.com",
        "pass": "s3cret-passphrase"
      }
    }
  }'
```

Server-side rules (`ensureAccountCanRegister()` + `modifyCreatedEntity()`):

- The caller must be anonymous; a set entity ID is rejected (`BadRequestHttpException`).
- If `user.settings.register` is `admin_only` → 403 `AccessDeniedHttpException`.
- If `verify_mail` is **off**: a `pass` is **required** (422 if missing); the account is
  **activated** only when `register == visitors`, otherwise created **blocked**.
- If `verify_mail` is **on**: a `pass` must **not** be supplied (422 if present) — it is set later at
  first login; the account is created **blocked**.
- On success: **201 Created** with the new `user--user` resource and a `Location` header.
- Events: `REGISTRATION_VALIDATE` fires before save, `REGISTRATION_COMPLETE` after;
  `UserRegistrationSubscriber` then calls `_user_mail_notify()` (`register_no_approval_required` or
  `register_pending_approval`) per `register`/`verify_mail`.

## 2. Request a password reset — `POST /jsonapi/user/password/reset`

Uses an inline `user--password-reset` resource type (attributes `name`, `mail`) — **not** the
`user--user` type.

```bash
curl -X POST 'https://example.com/jsonapi/user/password/reset' \
  -H 'Content-Type: application/vnd.api+json' \
  -H 'Accept: application/vnd.api+json' \
  -d '{
    "data": {
      "type": "user--password-reset",
      "attributes": { "mail": "jane@example.com" }
    }
  }'
```

- Supply `name` or `mail` (name is tried first). Missing both → 422 `Missing name or mail`.
- Loads the account with `loadByProperties()`. Dispatches `PASSWORD_RESET`; `PasswordResetSubscriber`
  sends the core `password_reset` email in the account's preferred language.
- On success: **202 Accepted** with a `meta.message`.

## 3. Complete the reset — `PATCH /jsonapi/user/{user}/password/update`

`{user}` is the target user's **entity ID** (upcast `entity:user`). The `timestamp` and `hash` come
from the one-time-login link in the reset email.

```bash
curl -X PATCH 'https://example.com/jsonapi/user/42/password/update' \
  -H 'Content-Type: application/vnd.api+json' \
  -H 'Accept: application/vnd.api+json' \
  -d '{
    "data": {
      "type": "user--user",
      "attributes": {
        "timestamp": 1728900576,
        "hash": "<hash-from-reset-link>",
        "pass": "new-passphrase"
      }
    }
  }'
```

- All three of `timestamp`, `hash`, `pass` are required (422 naming the missing one otherwise).
- Validated exactly as core one-time-login: `timestamp <= now`, within
  `user.settings.password_reset_timeout`, `timestamp >= user last-login`, and
  `hash_equals($hash, user_pass_rehash($user, $timestamp))`. A failure → 422
  `The password reset information is no longer valid.`
- On success: sets the new password, activates a blocked never-logged-in account when `verify_mail`
  is on, saves, and returns the updated `user--user` resource.

## Reacting to these operations from another module

```php
// mymodule.services.yml → tagged { name: event_subscriber }
use Drupal\jsonapi_user_resources\Events\UserResourcesEvents;
use Drupal\jsonapi_user_resources\Events\RegistrationEvent;

public static function getSubscribedEvents(): array {
  return [UserResourcesEvents::REGISTRATION_COMPLETE => 'onRegistered'];
}

public function onRegistered(RegistrationEvent $event): void {
  $account = $event->getUser();       // \Drupal\user\UserInterface
  $document = $event->getDocument();  // JsonApiDocumentTopLevel (raw request)
  // ...custom onboarding, extra field handling, etc.
}
```

`PASSWORD_RESET` carries a `PasswordResetEvent` with the same `getUser()` / `getDocument()` API.

## Verify the routes exist

```bash
drush php:eval '$rp=\Drupal::service("router.route_provider");
foreach(["jsonapi_user_resources.registration","jsonapi_user_resources.password_reset","jsonapi_user_resources.password_update"] as $n){
  $r=$rp->getRouteByName($n);
  print $n." ".$r->getPath()." [".implode(",",$r->getMethods())."] logged_in=".$r->getRequirement("_user_is_logged_in")."\n";}'
# /jsonapi/user/register [POST], /jsonapi/user/password/reset [POST],
# /jsonapi/user/{user}/password/update [PATCH] — all logged_in=FALSE
```
