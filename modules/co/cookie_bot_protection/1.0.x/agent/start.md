<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cookie bot protection (cookie_bot_protection) — agent index

**HTTP middleware that gates configured URL regexes behind an HMAC cookie round-trip challenge to filter cookie-less bots.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10 || ^11
- **Middleware:** `cookie_bot_protection.kernel` (`CookieBotProtectionMiddleware`, `http_middleware` priority 250 — before page cache).
- **Route:** `cookie_bot_protection.settings` → `/admin/config/cookie_bot_protection/settings` (requires `administer site configuration`).
- **Config (`cookie_bot_protection.settings`):** `url_protected_patterns`, `ua_whitelist_patterns`, `ip_whitelist`, `redirect_error_delay` (default 5), `header_response_debug` (default false).
- **Challenge:** cookie `SESScookiebotprotection`; value `hash_hmac('sha256', {accept_language,user_agent,ip,hour}, hash_salt)`; denial = HTTP 401.
- **Security:** admin-gated config; tokens bound to `hash_salt` (not forgeable offline); inert until patterns set. By design only blocks cookie-less clients — not a human/CAPTCHA control; keep `header_response_debug` off in production. No security findings.

See [configure/protection.md](configure/protection.md)
