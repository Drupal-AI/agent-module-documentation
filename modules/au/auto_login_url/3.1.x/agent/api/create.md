<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — creating URLs, converting text, token model

## Procedural functions (in `auto_login_url.module`)

```php
// Mint an auto-login URL. Throws \Drupal\auto_login_url\Exception\AutoLoginUrlException on failure.
auto_login_url_create(
  int $uid,
  string $destination,            // internal path ('user/123/edit', '<front>') or absolute URL
  bool $absolute = FALSE,         // absolute vs relative URL string
  ?int $custom_expiration = NULL, // seconds; NULL = global 'expiration'
  ?bool $one_time_use = NULL      // NULL = global 'delete'
): string;

// Rewrite every site URL found in $text into a per-user auto-login URL.
auto_login_url_convert_text(int $uid, string $text): string;

// TRUE if the user exists and is under their hourly creation rate limit.
auto_login_url_user_can_create(int $uid): bool;

// ['active_urls','total_urls_created','remaining_attempts','total_usage_count'].
auto_login_url_get_user_stats(int $uid): array;
```

Prefer the services directly in OO code: `\Drupal::service('auto_login_url.create')->create(...)`
and `->convertText(...)`.

## Services

| Service id | Class | Role |
|---|---|---|
| `auto_login_url.create` | `AutoLoginUrlCreate` | mint URLs, convert text |
| `auto_login_url.login` | `AutoLoginUrlLogin` | validate a hash + finalize login; `cleanupExpiredTokens()` |
| `auto_login_url.general` | `AutoLoginUrlGeneral` | secret, per-user key material, flood, hash-format + destination validation |
| `auto_login_url.rate_limit` | `AutoLoginUrlRateLimit` | per-user creation limits (State-backed) |

`create`, `general`, `rate_limit` are tagged `backend_overridable`.

## Token generation model (why it's safe)

- `key = Settings::getHashSalt() . <config 'secret'> . <target user's password hash>`.
  The secret is auto-created once with `random_bytes(48)` (base64) and stored in
  `auto_login_url.settings:secret`.
- Token = `substr(Crypt::hmacBase64($entropy, $key), 0, token_length)`, where `$entropy`
  = `random_bytes(32)` + `uniqid` + pid + time + uid + destination. So the URL token is
  effectively a random 64-char bearer secret, not a deterministic function of uid/time.
- The DB column `hash` stores `Crypt::hmacBase64($token, $key)` (a second HMAC), never the token.
  Login recomputes that value from the submitted token and looks it up by `uid` + `hash`
  (`hash_equals`-grade equality via an indexed DB match).
- Consequences: an attacker cannot forge or brute-force a token without `hash_salt`, the module
  secret, and the user's current password hash; a password change rotates the key and invalidates
  all of that user's URLs; regenerating the secret invalidates everyone's.

## Login flow (route `auto_login_url.login`, controller `AutoLoginUrlMainController::login`)

1. Kill page cache; validate uid > 0 and hash format (`[A-Za-z0-9_-]`, 8–128 chars).
2. Per-IP flood check using core `user.flood` `ip_limit`/`ip_window`.
3. `AutoLoginUrlLogin::login()` — re-derive DB hash, look up record, check expiry, optional IP match,
   load user and reject blocked/inactive accounts, `user_login_finalize()`, log analytics, delete if
   single-use, then redirect (external → `TrustedRedirectResponse`).
4. Any failure registers a flood event and throws 403/404.
