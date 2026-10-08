<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The key repository (`users_jwt.key_repository`)

Service `users_jwt.key_repository`, class `Drupal\users_jwt\UsersJwtKeyRepository`,
implementing `Drupal\users_jwt\UsersJwtKeyRepositoryInterface` (which extends
`\ArrayAccess` so the repository itself can be passed as the `$key` argument to
`Firebase\JWT\JWT::decode()`).

## Storage

Keys are stored in the core **`user.data`** key-value store, module name `users_jwt`,
**keyed by key ID (`kid`)**, not by uid:

```php
$this->userData->set('users_jwt', $uid, $id, $key);   // save
$this->userData->get('users_jwt', NULL, $id);          // lookup by kid (any uid)
$this->userData->get('users_jwt', $uid);                // all keys for a uid
```

A key ID must be globally unique across all users — `saveKey()` throws
`\InvalidArgumentException` if the ID is already used by a *different* uid. A small
in-request memory cache (`users_jwt.memory_cache`) fronts `getKey()`; cache tags
`users_jwt:<uid>` are invalidated on save/delete.

## The `UsersKey` value object

`Drupal\users_jwt\UsersKey` — plain public properties, no methods:

| Property | Type | Meaning |
|---|---|---|
| `uid` | `int` | Owning user ID |
| `id` | `string` | The key ID (`kid`) — must be unique site-wide |
| `alg` | `string` | JWT algorithm, e.g. `RS256` (only RSA is offered in the UI today) |
| `pubkey` | `string` | PEM-encoded public key |

## Repository methods

```php
$repo = \Drupal::service('users_jwt.key_repository');

$repo->saveKey($uid, $id, $alg, $pubkey): UsersKey;   // create/overwrite; throws if $id
                                                        // empty or owned by another uid
$repo->getKey($id): ?UsersKey;                         // lookup by kid, any user
$repo->deleteKey($id);                                 // delete one key by kid
$repo->getUsersKeys($uid): array;                      // all of one user's keys, keyed by kid
$repo->deleteUsersKeys($uid);                           // delete ALL of a user's keys — careful
$repo->algorithmOptions(): array;                       // e.g. ['RS256' => 'RSA (2048 bits or more)']
```

`ArrayAccess::offsetGet($kid)` returns a `Firebase\JWT\Key` (pubkey + alg) built from
`getKey()`, for direct use as the `firebase/php-jwt` key/keyset argument.

## Example: register a key for uid 1 by script

```php
$repo = \Drupal::service('users_jwt.key_repository');
$pem = file_get_contents(DRUPAL_ROOT . '/modules/contrib/jwt/modules/users_jwt/tests/fixtures/users_jwt_rsa1-public.pem');
$repo->saveKey(1, 'my_service_key', 'RS256', $pem);
```

```bash
drush php:eval "print_r(\Drupal::service('users_jwt.key_repository')->getUsersKeys(1));"
```

## Notes

- `saveKey()` does **not** validate that `$pubkey` is well-formed PEM or a real RSA key —
  that validation (`openssl_pkey_get_public()`, minimum 2048 bits) happens in
  `UsersKeyForm::validateForm()`, one layer up. Calling the repository directly from code
  bypasses it.
- Only `RS256` is offered by `algorithmOptions()`, though `UsersKey::alg` and
  `UsersJwtAuth` are alg-agnostic (the `@todo` in source notes planned Ed25519 support).
