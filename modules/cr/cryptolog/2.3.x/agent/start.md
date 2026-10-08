<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cryptolog (cryptolog) — agent index

An HTTP stack **middleware** replaces the client **IP address with an ephemeral, non-reversible
identifier** (128-bit keyed hash in IPv6 notation) before Drupal reads it — raw IPs stay out of
logs and DB (GDPR data minimization) while the salt's lifetime keeps short-term per-visitor
correlation (unique-IP stats, IP-based flood control). Package none. **No module dependencies**,
no libraries. Core `^11.2 || ^12`. License GPL-2.0-or-later. Version 2.3.0.

- **Settings form, config object + schema, salt storage/TTL, diagnostics** →
  [config/settings.md](config/settings.md)
- **The middleware, salt lifecycle, hashing, service provider, reverse-proxy handling** →
  [architecture/middleware.md](architecture/middleware.md)

## What it actually is

- One `http_middleware` service `cryptolog.middleware` (`src/CryptologMiddleware.php`, priority
  **222**) implementing `HttpKernelInterface` + `CryptologMiddlewareInterface`. On the MAIN request
  it rewrites `$_SERVER['REMOTE_ADDR']` to `inet_ntop(hash)` so
  `\Drupal::request()->getClientIp()` returns the pseudonym.
- One settings route `cryptolog.settings` → `/admin/config/people/cryptolog`
  (`src/ConfigForm.php`, `ConfigFormBase`), permission **`administer site configuration`**; menu
  link under *People* (`cryptolog.links.menu.yml`, parent `user.admin_index`).
- One config object **`cryptolog.settings`** with `single_webhead` (bool) and `ttl` (int),
  schema in `config/schema/cryptolog.schema.yml`, install defaults in `config/install/`.
- `ConfigSubscriber` (`src/ConfigSubscriber.php`) invalidates the service container when
  `single_webhead` or `ttl` changes (so `CryptologServiceProvider` re-wires the backend/TTL).
- `CryptologServiceProvider` (`src/CryptologServiceProvider.php`) injects the APCu cache backend
  and TTL argument into the middleware at container-build time, reading bootstrap config.
- Requirements: `Install/Requirements/CryptologRequirements` (IPv6 support check) plus hook
  classes `Hook/RuntimeRequirements` (middleware active? hash function? TTL vs flood window) and
  `Hook/UpdateRequirements`.

## Provides

- **No** custom permissions, **no** Drush commands, **no** plugin types, **no** entities, **no**
  content dependencies. Config schema: yes. Empty `cryptolog.post_update.php` stubs only.

## Key facts (from source)

- Salt: `random_bytes(32)`, cached under key `cryptolog` (`CryptologMiddlewareInterface::KEY`),
  expiry = request time + TTL. Default TTL 86400s (`::TTL`).
- Hash: `sodium_crypto_generichash($ip, $salt, 16)` (BLAKE2b, 16 bytes → IPv6) when the Sodium
  extension is present, else `hash_hmac('md5', $ip, $salt, TRUE)`.
- Reverse proxy: because REMOTE_ADDR changes, a request stops matching a trusted proxy; the
  middleware saves and restores scheme (`HTTPS`) and HTTP host so downstream extraction still
  works, and records what it restored for the diagnostics panel.
- Requires PHP compiled with IPv6 support (install requirement); APCu recommended for
  performance; nothing is added to `settings.php` (unlike the D7 version).
