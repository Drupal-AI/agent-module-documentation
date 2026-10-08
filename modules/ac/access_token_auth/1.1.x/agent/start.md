<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Access Token Authentication — agent orientation

Global auth provider that maps a valid `X-ACCESS-AUTH-TOKEN` to its owning user (or a stub user).

Key files:
- `src/Authentication/AccessTokenAuthProvider.php` — `applies()`/`authenticate()`; reads header or `query` param; loads user, requires active account.
- `src/Services/TokenGenerator.php` — `hash('sha256', bin2hex(random_bytes(64)))` (strong entropy).
- `src/Services/TokenManager.php` — DB CRUD, `validateToken()` (marks used), `getTokenById()` scopes to current user unless `access any access_token_auth`.
- `src/Cache/RequestPolicy/DisallowAccessTokenRequests.php` — no page cache for token requests.

Security posture: fundamentally sound — strong token entropy, empty/null tokens rejected, per-user DB scoping, page-cache guarded, restricted permissions. Minor notes: (1) token also accepted via URL query param → can leak into access logs/referrers (D1); (2) DB `==` match is not constant-time but the 64-hex-char space makes timing attacks impractical. Recommend header-only + HTTPS + short TTL.
