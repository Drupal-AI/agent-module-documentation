<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The key_auth service, the api_key field, and the auth provider

## Service: `key_auth` (`Drupal\key_auth\KeyAuth`, interface `KeyAuthInterface`)

Constructor args: `@config.factory`, `@entity_type.manager`.

```php
$key_auth = \Drupal::service('key_auth');
```

| Method | Signature | Behavior |
|---|---|---|
| `getKey(Request $request)` | returns `string\|FALSE` | Extracts the key from the request per `detection_methods`/`param_name` (see `configure/settings.md`). |
| `getUserByKey($key)` | returns `\Drupal\user\Entity\User\|NULL` | Queries the `user` entity for `api_key == $key` **and** `status == 1` (active users only). Returns the first match or `NULL`. |
| `access(UserInterface $user)` | returns `bool` | `$user->hasPermission('use key authentication')`. Gates both authentication and auto-key-generation. |
| `generateKey()` | returns `string` | `substr(bin2hex(random_bytes($length)), 0, $length)` where `$length` = current `key_length` config; loops (querying `api_key`) until the value is unique among all users. |

### Generate/assign a key programmatically

```php
$key_auth = \Drupal::service('key_auth');
$user = \Drupal\user\Entity\User::load($uid);
$user->set('api_key', $key_auth->generateKey())->save();
```

### Delete/revoke a key

```php
$user->set('api_key', NULL)->save();
```

(This is exactly what the "Generate new key" / "Delete current key" buttons on
`/user/{user}/key-auth` do — see `Drupal\key_auth\Form\UserKeyAuthForm`.)

## The `api_key` User base field

`key_auth_entity_base_field_info()` adds a `string` base field `api_key` to the `user` entity
type (max length 255, no text processing, `UniqueField` constraint — no two users can share a
key). It is **not** a configurable/Field UI field; it exists on every user regardless of role.

Read it: `$user->api_key->value` (or `NULL`/`''` if the user has no key).

## Auto-generation on user creation

`key_auth_user_insert()` (`hook_ENTITY_TYPE_insert()` for `user`) runs on every new user save:

```php
if (\Drupal::config('key_auth.settings')->get('auto_generate_keys')) {
  $key_auth = \Drupal::service('key_auth');
  if ($key_auth->access($entity)) {          // user has 'use key authentication'
    $entity->set('api_key', $key_auth->generateKey())->save();
  }
}
```

So a key is assigned automatically only when **both** `auto_generate_keys` is enabled (default
`true`) **and** the new user's role(s) already grant `use key authentication` at creation time.
Users created without that permission, or created while `auto_generate_keys` is off, start with
no key and must have one generated later (via the user key-auth form or programmatically).

## How the authentication provider validates a request

Service `key_auth.authentication.key_auth`
(`Drupal\key_auth\Authentication\Provider\KeyAuth`), tagged `authentication_provider` with
`provider_id: key_auth`, `priority: 200`:

- `applies(Request $request)`: `TRUE` iff `KeyAuth::getKey($request)` finds a key.
- `authenticate(Request $request)`:
  1. Get the key via `getKey()`.
  2. Look up the owning **active** user via `getUserByKey()`.
  3. Check `access($user)` — the user's roles must have `use key authentication`.
  4. If all three succeed, the request authenticates as that user; otherwise `NULL`
     (falls through to other authentication providers / anonymous).

A key alone is not sufficient: a disabled/blocked user, a user with no matching key, or a user
whose roles lack the permission never authenticates via this provider.

## Page cache interaction

Service `key_auth.page_cache_request_policy.disallow_key_auth_requests`
(`Drupal\key_auth\PageCache\DisallowKeyAuthRequests`) denies the internal page cache for any
request where `getKey()` finds a key — regardless of whether authentication ultimately
succeeds — so key-authenticated responses are never cached and served to other visitors.
