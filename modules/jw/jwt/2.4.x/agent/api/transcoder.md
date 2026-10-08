<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Encoding & decoding tokens in code

## Service: `jwt.transcoder`

`Drupal\jwt\Transcoder\JwtTranscoder` (interface `JwtTranscoderInterface`). It is constructed
with the `Firebase\JWT\JWT` class and, via `applyConfiguration()`, loads the key referenced by
`jwt.config` `key_id` from the Key repository. Leeway for `iat`/`exp` is 300 seconds.

Methods (interface):

| Method | Purpose |
|---|---|
| `decode(string $raw_jwt): JsonWebTokenInterface` | Verify signature + claims; throws `JwtDecodeException` on failure. |
| `encode(JsonWebTokenInterface $jwt): ?string` | Sign a token; returns `NULL` if no key is set. |
| `setKey(KeyInterface $key): void` | Use a specific Key entity. |
| `setSecret(string)` / `setPrivateKey(string)` / `setPublicKey(string)` | Set raw key material. |
| `setAlgorithm(string): ?string` | Set algorithm; returns type `jwt_hs`/`jwt_rs`/`NULL`. |
| `static getAlgorithmOptions(): array` | `HS256`,`HS384`,`HS512`,`RS256` => labels. |
| `static getAlgorithmType(string): ?string` | Maps an algorithm to `jwt_hs` / `jwt_rs`. |

HS keys sign+verify with the same secret; RS keys sign with the private key (encode) and verify
with the public key (decode).

```php
/** @var \Drupal\jwt\Authentication\Provider\JwtAuth $auth */
$auth = \Drupal::service('jwt.authentication.jwt');
$raw = $auth->generateToken();               // dispatches the GENERATE event, then encodes

$transcoder = \Drupal::service('jwt.transcoder');
try {
  $jwt = $transcoder->decode($raw);          // \Drupal\jwt\JsonWebToken\JsonWebToken
  $uid = $jwt->getClaim(['drupal', 'uid']);
}
catch (\Drupal\jwt\Transcoder\JwtDecodeException $e) {
  // invalid / expired / tampered
}
```

## Value object: `JsonWebToken`

`Drupal\jwt\JsonWebToken\JsonWebToken` (interface `JsonWebTokenInterface`) manages payload and
header claims:

- `getPayload(): array`, `getHeaders(): array`
- `getClaim($claim)` / `setClaim($claim, $value)` / `unsetClaim($claim)` — `$claim` is a string
  or an indexed array for a **nested** claim, e.g. `['drupal', 'uid']` => `{"drupal":{"uid":...}}`.
- `getHeader($claim)` / `setHeader($claim, $value)` / `unsetHeader($claim)`.

The standard `iat` and `exp` claims should always be set on a token you issue. The nested
`drupal.uid` (or `drupal.uuid` / `drupal.name`) claim is what `jwt_auth_consumer` reads to pick
the account.

## Provider: `jwt.authentication.jwt`

`JwtAuth` is tagged `authentication_provider` (`provider_id: jwt_auth`, global, priority 200).
`applies()` is true when a Bearer token is present; `authenticate()` decodes, dispatches the
`VALIDATE` then `VALID` events, and returns the account resolved by a subscriber (or `NULL`).
`generateToken()` builds an empty `JsonWebToken`, dispatches `GENERATE`, and encodes it.
