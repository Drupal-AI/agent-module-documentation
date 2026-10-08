<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cookie bot protection is an HTTP middleware (priority 250, before page cache) that protects configured URL patterns by requiring the client to complete a cookie round-trip challenge, filtering out bots that do not store and return cookies.
---
The module solves cheap scraping/DoS traffic from clients that ignore Set-Cookie headers. When a request matches a configured `url_protected_patterns` regex (and is not User-Agent- or IP-whitelisted), the middleware issues a redirect that sets a challenge cookie `SESScookiebotprotection` and appends `?drupal_cbp_check=1`. A legitimate browser follows the redirect, returns the cookie, and is issued an authorized cookie and redirected back to the clean URL; a client that never returns the cookie is denied with a 401 (optionally with a `Refresh` header retry after `redirect_error_delay` seconds). The challenge value is an `hash_hmac('sha256', payload, hash_salt)` where the payload binds Accept-Language, User-Agent, client IP and the current hour (two hours are accepted to survive an hour rollover).

Operational and security notes: the challenge is keyed to the site's `hash_salt`, so tokens cannot be forged offline, and challenge/authorized states are distinct HMACs. Configuration lives at `/admin/config/cookie_bot_protection/settings` behind the core `administer site configuration` permission; the settings form validates each protected/whitelist pattern by compiling it. By design the protection only stops cookie-less bots — any client (including a headless bot) that follows redirects and stores cookies will pass, so this is a coarse first-line filter, not a CAPTCHA or human-verification control. The module is inert until `url_protected_patterns` is populated (default empty). A `header_response_debug` toggle emits diagnostic response headers (including serialized challenge values) and should stay off in production. The typical setup task is to add one or more URL regexes (e.g. expensive search or listing paths), optionally whitelist known good crawlers by UA or IP, and leave the redirect delay at a few seconds.
---
- Protect an expensive search path from cookie-less scrapers.
- Add multiple URL regex patterns, one per line, to cover several routes.
- Whitelist Googlebot/Bingbot by User-Agent so real crawlers pass.
- Whitelist a monitoring service's IP/CIDR so uptime checks are not challenged.
- Tune the retry delay (`redirect_error_delay`) shown to denied clients.
- Set the delay to 0 to deny immediately with no retry refresh.
- Bind challenges to the site `hash_salt` so tokens cannot be forged.
- Rely on the two-hour challenge window to avoid hourly false denials.
- Leave `url_protected_patterns` empty to keep the middleware inactive.
- Enable `header_response_debug` temporarily to inspect challenge headers.
- Disable debug headers in production to avoid leaking challenge internals.
- Use non-capturing groups `(?:...)` in patterns per the field guidance.
- Protect a login or contact page from automated cookie-less abuse.
- Reduce origin load by filtering bots before the page cache.
- Combine with real CAPTCHA on forms for human verification.
- Verify a pattern compiles by saving the settings form (it validates regexes).
- Restrict a whole path prefix by anchoring the regex.
- Exempt an internal office IP range from challenges.
- Confirm browsers are unaffected by testing a protected URL manually.
- Roll out protection to one path first, then expand patterns.
