<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Persistent Login services & token lifecycle

## Services (`persistent_login.services.yml`)

| Service | Class | Purpose |
|---|---|---|
| `persistent_login.token_manager` | `Drupal\persistent_login\TokenManager` | all database work on the `persistent_login` table |
| `persistent_login.token_handler` | `Drupal\persistent_login\EventSubscriber\TokenHandler` | `authentication_provider` (provider id `persistent_login`, **priority 1**, `global: TRUE`) **and** an event subscriber on `KernelEvents::RESPONSE` |
| `persistent_login.cookie_helper` | `Drupal\persistent_login\CookieHelper` | builds the cookie name, reads its value |
| `persistent_login.page_cache_request_policy.pending_persistent_login` | `…\PageCache\RequestPolicy\PendingPersistentLogin` | denies internal page-cache hits for a sessionless request that carries the cookie |
| `logger.channel.persistent_login` | logger channel | |

## The table

`persistent_login`: `uid`, `series` (varchar 43, **primary key**), `instance` (varchar 43),
`created`, `refreshed`, `expires`. Indexes on `expires` and `(uid, expires)`.
`series` and `instance` are stored as `Crypt::hashBase64()` digests (update 8106);
`PersistentToken` / `RawPersistentToken` / `HashedPersistentToken` model the raw vs hashed
forms, with `STATUS_NOT_VALIDATED = 0`, `STATUS_VALID = 1`, `STATUS_INVALID = -1`.

## `TokenManager` API

```php
$tm = \Drupal::service('persistent_login.token_manager');

$tm->createNewTokenForUser(int $uid): PersistentToken;   // inserts a row, enforces max_tokens
$tm->validateToken(PersistentToken $token): PersistentToken;
$tm->updateToken(PersistentToken $token): PersistentToken;  // rotates the instance
$tm->deleteToken(PersistentToken $token): PersistentToken;
$tm->getTokensForUser(UserInterface $user): PersistentToken[]; // non-expired only
$tm->clearUsersTokens(UserInterface $user): void;
$tm->cleanupExpiredTokens(): void;                        // called from hook_cron()
```

`createNewTokenForUser()` sets the expiry to `now + lifetime day`, or to the epoch max
`2147483647` when `lifetime` is 0, and then — if `max_tokens !== 0` — deletes the user's
oldest tokens beyond that count.

`TokenHandler` adds the request-scoped helpers:

```php
$th = \Drupal::service('persistent_login.token_handler');
$th->setNewSessionToken(int $uid);          // used by the login form submit handler
$th->getTokenFromCookie(Request $request);
$th->clearSessionToken(?Request $request);  // used by hook_user_logout()
```

Issue a remembered login from code:

```php
\Drupal::service('persistent_login.token_handler')->setNewSessionToken($user->id());
```

## Authentication flow

1. `TokenHandler::applies()` returns FALSE if a valid authenticated **session** already exists
   (so core cookie auth wins); otherwise TRUE when the persistent cookie is present.
2. `authenticate()` validates the token; on `STATUS_VALID` it loads the user, refuses blocked
   accounts, then `$session->migrate()` + `$session->set('uid', …)` (mirroring
   `user_login_finalize()`), and logs *"Session opened for %name via Persistent Login token."*
   to the `user` channel.
3. `setTokenOnResponseEvent()` (on `KernelEvents::RESPONSE`, main request only) rotates the
   instance via `updateToken()`, optionally extends the expiry when `extend_lifetime` is on
   and `lifetime > 0`, and re-sets the cookie with the session's `cookie_path`/`cookie_domain`.
   An invalid token clears the cookie instead.

Because the *instance* is single-use and rotated on every request that authenticates from the
cookie, replaying an old cookie marks the series invalid — the classic theft-detection
property of the series/instance scheme.

## Module hooks (`persistent_login.module`)

| Hook | Effect |
|---|---|
| `hook_form_user_login_form_alter()` | adds the `persistent_login` checkbox (label from config, cache tag `config:persistent_login.settings`) and appends the submit handler |
| submit handler | when ticked → `setNewSessionToken(currentUser()->id())` |
| `hook_form_user_form_alter()` | inserts a "Logout all other devices."/"Logout all devices." checkbox after the password fields, visible only when a new password is entered |
| user edit submit | deletes all `persistent_login` rows for that uid, then re-issues a token for the current user if they still hold one |
| `hook_user_logout()` | `clearSessionToken()` |
| `hook_user_cancel()` / `hook_ENTITY_TYPE_delete()` for user | `clearUsersTokens()` |
| `hook_cron()` | `cleanupExpiredTokens()` |

## Page cache

`PendingPersistentLogin::check()` returns `DENY` when the request has **no session** but
**does** carry the persistent cookie, so the internal page cache cannot serve an anonymous
cached page to someone who is about to be logged back in. Reverse proxies (Varnish) must be
configured to do the same — that is step 3 of the module's README.
