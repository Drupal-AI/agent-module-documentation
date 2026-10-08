<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BotBuster — middleware, token, challenge generation

## Middleware `DdosProtectionMiddleware`

`src/Middleware/DdosProtectionMiddleware.php`, service `botbuster.ddos_protection_middleware`
(`http_middleware`, **priority 300**, `responder: true`, arg `@file_system`). Implements
`HttpKernelInterface`, decorating the kernel; runs before Drupal routing.

`handle()` flow:
1. No file system (e.g. during install) → pass through.
2. Load runtime config via `getConfig()` — reads `private://botbuster/botbuster.json`, decoded once
   into a **`private static $cachedConfig`** (per-process cache; `error_log` if the file is missing).
3. `empty($config['enabled'])` → pass through.
4. `isProtectedPath()` false → pass through.
5. Read cookie `$config['cookie_name']` (default `botbuster_token`); `isValidToken()` → pass through
   if valid, else `generateToken()` + `createChallengeResponse()`.

`isProtectedPath()` / `matchesPattern()`: each pattern is `preg_quote`d, `\*`→`.*`, wrapped `^…$`,
tested against `getPathInfo()` and `getRequestUri()`. Patterns are admin-supplied config, not
request-supplied.

## Token (HMAC, signed with the site hash salt)

- `generateToken($lifetime)` → `base64_encode($expiry . '|' . sign($expiry))`, `$expiry = time()+lifetime`.
- `sign($expiry)` → `hash_hmac('sha256', (string) $expiry, getSecret())`; `getSecret()` = `Settings::getHashSalt()`.
- `isValidToken($token, $lifetime)`:
  - `base64_decode(..., strict)`; split on `|` into exactly 2 parts;
  - `ctype_digit($expiry)`;
  - reject if `expiry <= now` or `expiry > now + lifetime + CLOCK_SKEW` (`CLOCK_SKEW = 300`s — lets a
    fast-clocked node's tokens validate on other nodes);
  - `hash_equals(sign(expiry), signature)` — constant-time compare.

Because the signature depends only on the hash salt (shared cluster-wide), any node validates tokens
issued by any other node; a client cannot forge a token offline.

## Challenge response `createChallengeResponse()`

- `$redirect_url = $request->getRequestUri()`; `isValidRedirectUrl()` requires it to start with `/`
  (not `//`) and blocks `javascript:`/`data:`/`vbscript:`/`<script`/`on\w+=`/control chars, else
  falls back to `/`. Same-site relative redirects only (no open redirect).
- Reads `private://botbuster/challenge.html`; throws `RuntimeException` if absent/unreadable.
- Substitutes `<%REDIRECT_URL%>` and `<%CHALLENGE_TOKEN%>` via `json_encode(..., JSON_HEX_TAG |
  JSON_HEX_APOS | JSON_HEX_AMP | JSON_HEX_QUOT)` (prevents breaking out of the inline `<script>`).
- Status **503**; headers: `Content-Type text/html`, aggressive no-cache, `Retry-After: 60`,
  `Vary: Cookie`, CSP `default-src 'none'; script-src 'self' 'unsafe-inline'; style-src 'self';
  connect-src 'self'`, `X-Frame-Options: DENY`, `X-Content-Type-Options: nosniff`.
- Sets an already-expired cookie (`new Cookie($cookie_name, '', 1, '/')`) to clear a stale/invalid token
  and avoid loops.

## Client script `js/challenge.js`

Reads `window.CHALLENGE_TOKEN` / `TOKEN_LIFETIME` / `REDIRECT_URL` / `BOTBUSTER_COOKIE_NAME` injected by
the template. If the cookie already exists it redirects immediately; otherwise it stores the
server-issued token cookie (`path=/; max-age=lifetime; SameSite=Lax; Secure`) and redirects after ~2s.
`localStorage` attempt counter caps at 3 (then shows the error block). The client only **stores** the
signed token — it performs no proof-of-work and no browser fingerprinting.

## `ChallengeFileGenerator`

`src/Service/ChallengeFileGenerator.php`. `privateSchemeAvailable()` guards every method
(`streamWrapperManager->isValidScheme('private')`).
- `generateChallengeFile()` — renders `@botbuster/challenge.html.twig` with the `challenge_page.*` config
  + `token_lifetime`, `cookie_name`, cache-busted `css_path`/`js_path`; writes `private://botbuster/challenge.html`.
- `generateConfigFile()` — builds `botbuster.json` = `{enabled, token_lifetime, cookie_name, patterns,
  updated, count}` where `patterns` = trimmed non-empty lines of `ddos_protection.protected_paths`.
- `removeChallengeFile()` — deletes both files; removes the dir only if empty.

## `ProtectedPathHelper`

`src/Helper/ProtectedPathHelper::isProtectedPath()` — static duplicate of the middleware's matcher
(takes the raw newline string). Present in the codebase but **not invoked** by the request path in this
release; the middleware uses its own private methods against the pre-split `patterns` array.
