<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# OAuth 1.0a authentication provider

## Service

`authentication.oauth` (`oauth.services.yml`) → class
`Drupal\oauth\Authentication\Provider\OAuthDrupalProvider`, tagged
`authentication_provider` with `provider_id: oauth`, **priority 100**. Constructor args:
`@database`, `@user.data`, `@logger.channel.oauth`, `@datetime.time`, `@entity_type.manager`.
Implements core `AuthenticationProviderInterface`.

## Request matching

`applies(Request $request)` returns `preg_match('/^OAuth/', $request->headers->get('authorization',
''))` — i.e. it only engages when the `Authorization` header begins with `OAuth`. A route must
opt into this provider (core `_auth` handling) for it to run.

## Authentication flow

`authenticate(Request $request)` uses the **PECL `OAuthProvider`**:

```php
$provider = new \OAuthProvider();
$provider->consumerHandler([$this, 'lookupConsumer']);
$provider->timestampNonceHandler([$this, 'timestampNonceChecker']);
$provider->tokenHandler([$this, 'tokenHandler']);
$provider->is2LeggedEndpoint(TRUE);
$provider->checkOAuthRequest();
```

`checkOAuthRequest()` parses the signed request and calls the three handlers; the actual
cryptographic signature verification (HMAC-SHA1 etc.) is performed inside the PECL extension.
An `\OAuthException` (e.g. bad signature, unknown key) is caught, logged as a warning, and the
method returns `NULL` (unauthenticated). On success the resolved `$this->user` is returned.

### Handlers

- **`lookupConsumer(\OAuthProvider $provider)`** — looks up the presented `consumer_key` in
  `users_data` (`userData->get('oauth', NULL, $provider->consumer_key)`). If found, sets
  `$provider->consumer_secret` from the stored secret (so the extension can recompute the
  signature) and loads the owning user via `userStorage->load(key($userData))`; returns
  `OAUTH_OK`, else `OAUTH_CONSUMER_KEY_UNKNOWN`.
- **`timestampNonceChecker($provider)`** — queries `oauth_nonce` for `$provider->nonce`; if
  present returns `OAUTH_BAD_NONCE` (replay), otherwise inserts the nonce with the current
  server request time and returns `OAUTH_OK`.
- **`tokenHandler($provider)`** — stub, always `OAUTH_OK` (token flow unused in two-legged mode;
  marked `@todo`).

## Nonce lifecycle

`oauth_nonce` (`nonce` PK, `timestamp`) is the replay store. `oauth_cron()` (`oauth.module`)
deletes rows with `timestamp < now - 86400`, i.e. nonces are retained for 24 hours.

## Page-cache protection

`oauth.page_cache_request_policy.disallow_oauth_requests` → `DisallowOauthRequests`
(`RequestPolicyInterface`, tagged `page_cache_request_policy`, non-public). `check()` returns
`self::DENY` when the `Authorization` header starts with `OAuth`, preventing an
OAuth-authenticated response from being stored in the anonymous page cache and served to others.

## Consumer routes & access

Consumer management routes (`oauth.user_consumer*`) are gated by the `_oauth_access_check`
requirement → `oauth.access_checker` (`CustomAccessCheck`): `administer consumers`, or own
account plus `access own consumers`. Details in
[../config/settings.md](../config/settings.md).

## Using it on a custom route

Attach the provider to a route so signed requests authenticate:

```yaml
my_module.api:
  path: '/api/thing'
  defaults: { _controller: '\Drupal\my_module\Controller\Api::thing' }
  requirements: { _permission: 'access content' }
  options:
    _auth: ['oauth']
```

The client signs each call with its consumer key/secret and sends the `Authorization: OAuth`
header; a valid signature resolves `$account` to the consumer's owning user.
