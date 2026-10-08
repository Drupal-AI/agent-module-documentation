# Configuration

The middleware does nothing until you tell it which URLs to protect. All settings
are on one form.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Navigate to **`/admin/config/cookie_bot_protection/settings`**.

Each pattern field takes **one entry per line**. The form validates every
protected and whitelist pattern by compiling it when you save, so an invalid regex
is caught immediately.

## Fields

- **Protected URL patterns** (`url_protected_patterns`) — PCRE regular expressions
  (no delimiters) matched against the request URI. Only requests that match get the
  challenge. **Leave this empty and the module is inactive.** Use non‑capturing
  groups `(?:...)` as the field guidance recommends, and anchor your patterns so you
  don't accidentally protect the whole site (which would hurt SEO). A good starting
  point is to mirror the paths you already list in `robots.txt`. Roll out to one
  path first, then expand.
- **User‑Agent whitelist patterns** (`ua_whitelist_patterns`) — PCRE patterns
  matched against the User‑Agent; a match skips the challenge. Use this to let real
  crawlers such as Googlebot or Bingbot through.
- **IP whitelist** (`ip_whitelist`) — IP addresses or CIDR ranges; a match skips
  the challenge. Use it to exempt monitoring/uptime services or an internal office
  range.
- **Redirect error delay** (`redirect_error_delay`, default **5**) — seconds for
  the `Refresh` retry shown to a denied client after a `401`, so a legitimate user
  who failed the challenge can recover. Set it to **0** to deny immediately with no
  retry.
- **Header response debug** (`header_response_debug`, default **off**) — adds
  `Drupal-CBP-*` diagnostic response headers, including serialized challenge
  values. Useful for troubleshooting, but **keep it off in production** so you don't
  leak the challenge internals.

Save the form.

## Scope and limits

This challenge only defeats clients that do not store and return cookies. Any
redirect‑following, cookie‑storing client — including a capable bot — will pass, so
it is a lightweight first‑line filter, not a human‑verification control. For
sensitive forms (login, contact), pair it with a real CAPTCHA. Challenge responses
are marked non‑cacheable, and tokens are bound to the site `hash_salt` so they
cannot be forged offline.
