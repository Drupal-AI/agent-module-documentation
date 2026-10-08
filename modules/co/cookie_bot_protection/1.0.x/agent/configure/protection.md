<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring cookie bot protection

## Settings form
`/admin/config/cookie_bot_protection/settings` (permission `administer site configuration`). Fields (stored as arrays, one pattern per line):
- `url_protected_patterns` — PCRE patterns (no delimiters) matched against `Request::getRequestUri()`. Only when a request matches is the challenge applied. Empty ⇒ middleware is a no-op.
- `ua_whitelist_patterns` — PCRE patterns matched against the User-Agent; a match skips the challenge.
- `ip_whitelist` — IP/CIDR entries checked with `IpUtils::checkIp()`; a match skips the challenge.
- `redirect_error_delay` — seconds for the `Refresh` retry after a 401 deny; `0` = immediate deny, no retry.
- `header_response_debug` — adds `Drupal-CBP-*` diagnostic response headers (includes serialized challenge values). Keep OFF in production.

Patterns support `\uXXXX` escapes (rewritten to `\x{XXXX}`) and are validated on save by compiling them.

## Challenge flow (`CookieBotProtectionMiddleware::handle`)
1. Skip for sub-requests or when `isNeeded()` is false (no URL match, or UA/IP whitelisted).
2. Compute HMAC challenges for the current and next hour: `hash_hmac('sha256', json({accept_language,user_agent,ip,'Y-m-d H'}) . 'unchecked'|'checked', hash_salt)`.
3. No/mismatched cookie ⇒ `challenge()`: set cookie to the `unchecked` HMAC, redirect with `?drupal_cbp_check=1`.
4. Return trip with `drupal_cbp_check=1` and the `unchecked` cookie ⇒ `authorize()`: set cookie to the `checked` HMAC (HttpOnly), redirect to clean URL.
5. Neither matches ⇒ `deny()`: HTTP 401, optional `Refresh` retry, challenge cookie removed.

Responses are marked non-cacheable.

## Scope / limitations
Only defeats clients that do not store/return cookies. Any redirect-following, cookie-storing client (including capable bots) passes. Pair with a CAPTCHA for human verification on sensitive forms.
