<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain SSO — the handshake flow

Three routes cooperate to move a session from the network's **default/issuer** domain to a
**target** domain. All are uncached and available in maintenance mode.

## Actors
- **Target domain (B):** where the visitor wants to be signed in. Anonymous there.
- **Issuer domain (A):** the network's default domain (`loadDefaultDomain()`), where the
  visitor already has a session. Mints the token.

## Step 1 — Kick off: `domain_sso.sso_login`
`SsoController::login()` — route `domain_sso.sso_login`, path `/domain-sso`, anonymous only
(`_user_is_logged_in: FALSE`). File `src/Controller/SsoController.php:18-33`.
- Loads the default domain: `$domain_storage->loadDefaultDomain()`.
- Reads the active domain id: `domain.negotiation_context::getDomainId()`
  (`getActiveDomainId()`, lines 38-40) — this is domain **B**.
- Reads the `Referer` header (the page the visitor came from) as the eventual return URL.
- Builds an absolute URL for `domain_sso.handshake.issue` **on the default domain A**
  (`->setOption('base_url', rtrim($default_domain->getPath(), '/'))`) with query
  `domain=<B id>` and `target=<referer>`.
- Returns a `TrustedRedirectResponse` to that issuer URL.

## Step 2 — Issue the token: `domain_sso.handshake.issue`
`IssueController::issue(Request $request)` — path `/domain-sso/handshake-issue`, GET,
`_access: 'TRUE'`. File `src/Controller/IssueController.php:20-96`. Runs on issuer **A**,
where the browser carries A's session cookie.
- If the current user is **not** authenticated → redirect to `user.login` with
  `?destination=<this request uri>` (lines 85-93). So the effective gate is "must have a
  session on A".
- Reads `domain` query param (target domain id). Empty → HTTP 400 "Missing target domain
  parameter". Loads the `domain` entity; not found → HTTP 400 "Invalid target domain"
  (lines 26-37). **This is the only place the target domain id is checked against the
  registered domain list.**
- Builds the payload (lines 41-53):
  - `uid` = current user id
  - `iat` = `time()`
  - `exp` = `time() + 60` (60-second lifetime)
  - `nonce` = `bin2hex(random_bytes(16))` (CSPRNG, 32 hex chars)
  - `domain` = validated target domain id
- Signs: `signature = hash_hmac('sha256', json_encode(payload), Settings::getHashSalt() . nonce)`
  (line 59). The key is the site hash salt concatenated with the per-token nonce.
- Token = `base64_encode(payload_json) . '.' . signature` (line 62).
- Records the nonce: `cache()->set('domain_sso_handshake_nonce.'.nonce, [], now+300)` — a
  5-minute cache entry used later for single-use enforcement (line 65).
- Builds the consume URL for `domain_sso.handshake.consume` **on the target domain B**
  (`'domain' => $domain` option) with query `token=<token>` plus `target=<referer>` if the
  original request carried one (lines 67-79).
- Returns a `RedirectResponse` to that consume URL (line 82).

## Step 3 — Consume the token: `domain_sso.handshake.consume`
`ConsumeController::consume(Request $request)` — path `/domain-sso/handshake-consume`, GET or
POST, `_access: 'TRUE'`. File `src/Controller/ConsumeController.php:21-90`. Runs on target **B**.
- Reads `token` query param. Empty → HTTP 400 "no token" (lines 22-25).
- Splits on the first `.`: `[$payload_b64, $signature]`, base64-decodes the payload, JSON-decodes
  it (lines 28-34, in a `try/catch`).
- Recomputes `hash_hmac('sha256', payload_str, Settings::getHashSalt() . payload['nonce'])`
  and compares with `hash_equals($expected, $signature)`; mismatch → HTTP 400 "invalid token
  signature" (lines 37-40). Timing-safe compare; the signature cannot be forged without the
  site hash salt.
- Checks `payload['exp'] < time()` → HTTP 400 "token expired" (lines 43-45).
- Requires `payload['nonce']` present → HTTP 400 "missing nonce" (lines 48-51).
- Looks up the nonce in the cache; absent → HTTP 400 "nonce not found or already used", then
  **deletes** it so the token is single-use (lines 54-61). (This works cross-domain only when
  A and B share the same cache backend, i.e. the usual shared-database Domain Access setup.)
- Reads `payload['uid']`, loads that user; missing uid or user → HTTP 400 (lines 64-72).
- `user_login_finalize($user)` — establishes B's session for that uid (line 75).
- Redirect (lines 78-89):
  - If a `target` query param is present → `new RedirectResponse($target)` (the raw, unsigned
    query value).
  - Else → load `payload['domain']`, build `<front>` with `base_url` = that domain's path, and
    return a `TrustedRedirectResponse`.

## What is and isn't signed
Signed (inside the HMAC payload): `uid`, `iat`, `exp`, `nonce`, `domain`. The `target` return
URL travels as a **separate, unsigned** query parameter on both the issue and consume requests
and is not part of the payload.

## Return-domain handling
The `domain` (target site) id is validated against the registered domain list at issue time
(Step 2) and is signed. The no-`target` fallback in Step 3 rebuilds the front-page URL from that
signed `payload['domain']` via `TrustedRedirectResponse`. The explicit `target` URL, when
supplied, is used verbatim.
