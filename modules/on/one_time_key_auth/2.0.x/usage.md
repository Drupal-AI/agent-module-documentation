<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
One time key auth issues single-use, expiring keys that authenticate a request as a specific user through an `?otka=` query parameter.

---

The module registers a global authentication provider (`OneTimeKeyAuth`) and a service (`OneTimeKeyAuthService`). `generateKeyFor($uid)` mints a key as `bin2hex(random_bytes(32))` — 256 bits of cryptographically secure entropy — stores it with a 15-minute expiry in the `one_time_key_auth` table, and returns it for another module to deliver (there is no built-in route that generates keys, so the site builder controls issuance). On any request, `extractKey()` reads `?otka=`, and `consumeKey()` first purges expired rows, looks up the key (exact indexed match), loads the user, and immediately deletes the key — enforcing true single use. A page-cache request policy denies caching for any request carrying a key.

Security review found this sound: keys are high-entropy and unpredictable (no guessing/forging path to impersonate another user), strictly single-use, and short-lived. The main operational caveat is that the key travels in the URL query string, so it can appear in web-server/proxy logs, browser history, and Referer headers — deliver keys over TLS, keep the 15-minute window, and treat generated URLs as secrets. As an API-only provider, it does nothing until another module calls `generateKeyFor()`.

---
- Issue a one-time link that logs a user in for a single request.
- Authenticate an API call with a short-lived, single-use key.
- Grant temporary, self-expiring access to a protected resource.
- Build "magic link" flows on top of the key-generation API.
- Authorise a webhook or callback as a specific user once.
- Provide passwordless one-shot access for a specific action.
- Deliver a time-boxed access key via email from custom code.
- Authenticate a download or export link that must not be reused.
- Integrate one-time access into a custom module via the service.
- Auto-deny page caching when a key is present.
- Limit exposure with a 15-minute key lifetime.
- Ensure a key cannot be replayed after first use.
- Generate keys server-side with 256-bit entropy.
- Add token auth without a full OAuth stack.
- Give a user a single-use key to trigger a privileged task.
- Combine with your own delivery channel for magic links.
