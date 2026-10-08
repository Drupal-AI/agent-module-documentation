<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cryptolog middleware & salt lifecycle

The whole module is one HTTP stack middleware plus its wiring. Service `cryptolog.middleware`
(`cryptolog.services.yml`): class `Drupal\cryptolog\CryptologMiddleware`, tagged
`http_middleware` at **priority 222**, constructor arg `@cache.bootstrap`. It implements
`HttpKernelInterface` (decorates the next kernel) and `CryptologMiddlewareInterface`.

## Constructor & backend selection

`__construct(HttpKernelInterface $httpKernel, CacheBackendInterface $cacheBackend,
?ApcuBackendFactory $apcuBackendFactory = NULL, ?int $ttl = NULL)`:

- Default cache backend is `cache.bootstrap`.
- If an `ApcuBackendFactory` was injected **and** `apcu_enabled()`, the backend is swapped to the
  APCu `bootstrap` bin — so the salt lives only in APCu (off disk).
- The APCu factory and the `$ttl` argument are added by `CryptologServiceProvider::alter()`
  (`src/CryptologServiceProvider.php`) at container-build time: it reads `cryptolog.settings` from
  the bootstrap config storage (merged with the global `$config` override), passes a
  `Reference('cache.backend.apcu')` when `single_webhead` is truthy (else NULL), and appends the
  integer `ttl` when set. Changing either value invalidates the container (see
  `ConfigSubscriber`), triggering a rebuild.

## Request handling (`handle`)

On `MAIN_REQUEST` only, `handle()` calls `setClientIp($request)` before delegating to the wrapped
kernel. Sub-requests are untouched.

`setClientIp()` steps:
1. If `$request->isFromTrustedProxy()`, remember `isSecure()` and `getHttpHost()` first (they may
   have been derived from trusted-proxy headers).
2. Save the real IP to `$this->clientIp = $request->getClientIp()` (used only for the diagnostics
   panel; not persisted).
3. Load the salt from cache key `cryptolog` (`::KEY`). Legacy array-shaped cache data is
   supported (`$cache->data['salt']`); if the salt isn't a string, regenerate. On cache miss,
   regenerate.
4. If there is no client IP, return early.
5. Compute the keyed hash and write it back:
   `$request->server->set('REMOTE_ADDR', inet_ntop($hmac))`.
6. Reverse-proxy fix-up (below).

## Salt generation (`getNewSalt`)

`$salt = random_bytes(32)`; expiry = `REQUEST_TIME` (or `time()`) `+ getTtl()`; stored via
`$cacheBackend->set('cryptolog', $salt, $expire)`. `getTtl()` returns the injected `$ttl` or the
`::TTL` constant (86400). Because the salt is cached with an absolute expiry, it rotates
automatically; the settings form can force rotation by invalidating the key.

## Hash function

```
$hmac = function_exists('sodium_crypto_generichash')
  ? sodium_crypto_generichash($this->clientIp, $salt, 16)   // BLAKE2b, 16-byte digest
  : hash_hmac('md5', $this->clientIp, $salt, TRUE);          // 16-byte raw HMAC-MD5 fallback
```

The 16-byte binary digest is passed to `inet_ntop()`, yielding an IPv6-notation string that
replaces `REMOTE_ADDR`. This is why PHP must have IPv6 support and why the output is always IPv6.
Same IP + same salt ⇒ same pseudonym (stable within a TTL window); salt rotation ⇒ new pseudonym.

## Reverse-proxy / forwarded-header restoration

Rewriting `REMOTE_ADDR` means the request no longer matches a trusted reverse proxy, so
HttpFoundation stops extracting scheme/host from `X-Forwarded-*`. For trusted-proxy requests the
middleware compares the post-rewrite `isSecure()` / `getHttpHost()` to the values saved in step 1
and, if they changed, restores them: sets `$_SERVER['HTTPS']` on/off (recording `$this->isSecure`)
and the `HOST` header (recording `$this->httpHost`). `ConfigForm` surfaces these recorded values
(and `isFromTrustedProxy()`) in its diagnostics section.

## Interface constants & accessors

`CryptologMiddlewareInterface`: `KEY = 'cryptolog'`, `TTL = 86400`. Diagnostic accessors used by
the form: `getCacheBackend()`, `getClientIp()`, `getHttpHost()`, `getTtl()`, `isSecure()`,
`isFromTrustedProxy()`.

## Operating notes

- CLI/console requests don't run the middleware, so `getClientIp()` is unmodified there (the
  status report reports "Not initialized").
- APCu-only storage (`single_webhead`) is per-web-node; don't use it on multi-node sites (each
  node would hash differently). Multi-node sites should point the default cache backend at
  Memcache/Redis to keep the shared salt off disk.
- Keep `ttl` ≥ the flood window (`user.flood` `ip_window`/`user_window`) or flood control degrades;
  the status report warns when it isn't.
