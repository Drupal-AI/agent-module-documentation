<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User Secure Tokens (user_secure_tokens) — agent index

**Exposes `[user:one-time-login-url]` and `[user:cancel-url]` tokens, backed by Drupal core's secure URL builders.**

- **Version:** 1.0.x  (project: user_secure_token)
- **Core:** ^9 || ^10
- **Depends:** user

**Surface:** no routes/permissions. `user_secure_tokens.tokens.inc` implements `hook_token_info`/`hook_tokens`; replacements call core `user_pass_reset_url()` / `user_cancel_url()`. Service `user_secure_tokens.service` (`SecureTokens`) with `acquireEnabler()`/`hasEnabler()` gating (WeakReference-tracked `SecureTokensEnabler`).

**Security:** tokens are NOT self-generated — they delegate to core's HMAC-signed, time-limited, single-use login/cancel URLs (no weak RNG). They resolve only while an enabler is held, so generic token replacement on untrusted content will not leak a login link. Developer API only; no anonymous endpoints.

See [api/tokens.md](api/tokens.md).
