BotBuster shields configurable URL paths from automated/DDoS traffic with a lightweight, server-issued JavaScript browser-verification challenge (no CAPTCHA, no third-party service).

---

BotBuster registers a high-priority Symfony HTTP middleware (`DdosProtectionMiddleware`, priority 300, responder) that runs before Drupal routing. For every request whose path or path+query matches one of the admin-configured wildcard patterns, the middleware requires a valid browser token cookie (default `botbuster_token`); when it is missing or invalid it returns an HTTP 503 challenge page whose script stores the token and redirects back to the original URL. Tokens are HMAC-SHA256 signed with the site hash salt and expiry-bounded, so they cannot be forged offline and expire after a configurable lifetime (1 hour to 7 days). Everything is configured at `/admin/config/system/botbuster` (permission `administer site configuration`); on config save and on cache flush the module regenerates two files under `private://botbuster/` — `challenge.html` (rendered template) and `botbuster.json` (runtime config the middleware reads without a full bootstrap). A private file system (`$settings['file_private_path']`) is mandatory and enforced via `hook_requirements`. The challenge is intentionally lightweight: it stops bots that do not process cookies, but it is not a substitute for rate limiting or a real CAPTCHA against determined/headless clients.

---

- Protect a faceted search page (`/search`, `/search/*`) from bot-driven request floods.
- Shield high-traffic catalog or product-listing paths (`/catalog/*`, `/products`) from scraping.
- Add a browser-verification gate in front of any URL containing a substring, e.g. `*facet*`.
- Reduce origin server load caused by automated crawlers hitting expensive query pages.
- Require a one-time browser check before a visitor can reach a resource-heavy listing.
- Configure exactly which paths are protected, one wildcard pattern per line, in the admin UI.
- Use `*` wildcards anywhere in a pattern: leading (`*facet*`), trailing (`/search/*`), or middle (`/api/*/results`).
- Tune how long a passing visitor stays verified by choosing a token lifetime of 1h, 6h, 12h, 24h, or 7 days.
- Rename the verification cookie (default `botbuster_token`) to match a CDN's forwarded-cookie allowlist.
- Enable or disable all protection with a single checkbox without uninstalling the module.
- Customize the challenge page title, heading, description, loading text, error title and error message for branding/localization.
- Run bot mitigation with no external API calls — nothing leaves the server, no third-party JavaScript.
- Serve the challenge with hardened response headers (CSP, `X-Frame-Options: DENY`, `X-Content-Type-Options: nosniff`, no-cache).
- Deploy across a multi-node cluster: tokens validate on any node because they are signed with the shared site hash salt (300s clock-skew tolerance).
- Automatically regenerate the challenge and runtime-config files whenever configuration is saved or caches are cleared.
- Pair with core Flood Control / rate limiting and SecKit for layered defense (BotBuster handles path-level browser verification only).
- Keep the challenge assets out of the webroot by storing them under `private://botbuster/` (module refuses to run without a private file path).
- Front the protection with a reverse proxy/CDN, using the admin warning that detects proxy headers and reminds you to forward the token cookie to origin.
- Block trivial cookie-less scrapers and load-test tools that never store the verification cookie.
