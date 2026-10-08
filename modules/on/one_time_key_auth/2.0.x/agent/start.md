<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# One time key auth (one_time_key_auth) — agent index

**Global authentication provider + API for single-use, 15-minute access keys that authenticate a request as a user via `?otka=`.**

- **Version:** 2.0.x
- **Core:** ^8 || ^9 || ^10
- **Depends:** none
- **Surface:** auth provider `one_time_key_auth.authentication.otka` (global, priority 0); service `OneTimeKeyAuthService` (`generateKeyFor`, `consumeKey`, `extractKey`); page-cache request policy; `one_time_key_auth` table. No routes/forms/permissions — API only.

**Security (reviewed — sound):** keys = `bin2hex(random_bytes(32))` (256-bit CSPRNG), stored with 15-min expiry, matched by exact indexed lookup, and **deleted on first use** (true single-use); expired rows purged on each consume. No forge/guess path to impersonate another user. Caveat: key travels in the URL query string (`?otka=`) — can leak via logs/Referer/history; deliver over TLS and treat URLs as secrets. Issuance is up to the caller — no built-in key-generation route.
