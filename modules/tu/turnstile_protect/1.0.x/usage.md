<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Turnstile Protect puts chosen Drupal **routes** behind a Cloudflare Turnstile challenge for anonymous visitors, with an optional per-IP-range rate limit and a verified-crawler allow-list, so bots pay for expensive GET routes instead of your server.

---

The problem it addresses is not spam submission but load. A search page, a faceted listing or an expensive view costs the site real work per request, and a scraper hitting it thousands of times a day is a performance incident that looks like traffic. Putting a CAPTCHA on a *form* does not help, because the cost is in the GET; putting the challenge on the *route* does. Turnstile suits this because it is usually invisible. Mechanically the module is a `KernelEvents::REQUEST` subscriber (`src/EventSubscriber/Challenge.php`): for each request it checks a server-side session flag `turnstile_protect_pass` (set once the visitor solves a challenge), matches the request's `_route` name against the configured `routes` list (route-name matching, so aliases, trailing slashes and case are already normalised by the router), and skips authenticated users and IPs allow-listed in the CAPTCHA module (`captcha_whitelist_ip_whitelisted`). It then does the bot allow-listing **properly**: rather than trusting a `User-Agent` claiming to be Googlebot it performs a **forward-confirmed reverse DNS** check — `gethostbyaddr()` on the client IP, `gethostbyname()` back on the resulting hostname, requiring the two to match — takes the parent domain (last two labels) and lets it through only if that domain is in the configured `bots` list; the code comment says this is to avoid spoofing. When `protect_parameters` is on, a good bot hitting a protected route *with* query parameters gets a `403` instead (to stop crawlers walking facets). If `rate_limit` is on, only clients whose IP range (`/16` for IPv4, `/64` for IPv6, tracked in core's `flood` table with `threshold`/`window`) is seeing excess traffic are challenged; otherwise every unmatched anonymous request is. A matched visitor is redirected to `/challenge?destination=<original-uri>`, which renders a form whose only element is the `turnstile`/`captcha` CAPTCHA widget (verification is fully delegated to those modules — this module never calls Cloudflare's `siteverify` itself); a small JS callback auto-submits one second after the widget succeeds, the submit handler sets the session pass flag and redirects to `destination` via `Url::fromUserInput()`. A per-session `max_challenges` counter (default 5) returns `429 Too many requests` to visitors who keep failing, logging every tenth failure. Two operational points follow. **The client IP must be right**: behind a CDN `getClientIp()` returns the proxy unless `reverse_proxy` is configured in `settings.php`, and a protection module working from the wrong address either challenges everyone or rate-limits the whole site as one visitor. And **it performs two blocking DNS lookups per unmatched request** on exactly the routes that are under load when this matters — worth measuring and caching. An optional `history_enabled` flag makes `hook_cron` snapshot the flood counts into a `turnstile_protect_history` table.

---

- Protect a search page from scrapers without a login wall.
- Put an expensive or uncacheable view behind an invisible challenge.
- Reduce bot load on a faceted listing route.
- Challenge only anonymous visitors on a specific route (authenticated users pass).
- Allow verified search-engine crawlers (Googlebot, Bingbot, DuckDuckGo) through via forward-confirmed reverse DNS.
- Return 403 to good bots that crawl parameterised URLs (facet walking) while still serving clean URLs.
- Rate-limit by IP range so only ranges sending excess traffic are challenged.
- Protect an API-like or export route from automated abuse.
- Reduce server/infrastructure cost from distributed bot traffic.
- Add a nearly frictionless Turnstile check in front of a page.
- Cap repeated challenge failures per session with a 429 response.
- Allow-list a monitoring or uptime service's IP via the CAPTCHA module.
- Protect a directory/listing page from content harvesting.
- Throttle a route that triggers an expensive query before the query runs.
- Protect a public dataset or report page from aggressive crawling.
- Keep low-value routes out of reach of aimless bots without blocking humans.
- Snapshot flood/rate-limit history for offline traffic analysis.
- Reuse the CAPTCHA module's Turnstile keys already configured for form protection.
- Shield a login or password-reset page from automated hammering.
- Reduce bot noise in analytics on high-traffic anonymous routes.
