<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Crawler Rate Limit throttles requests from web crawlers, bots and spiders (and optionally regular traffic) very early in the request lifecycle, returning HTTP 429 once a configurable per-interval limit is exceeded, and can block traffic by autonomous system number (ASN).

---

The module works entirely through an **HTTP middleware** (`crawler_rate_limit.middleware`, priority 240) that decorates the kernel and runs before routing. All configuration lives in **`settings.php`** under `$settings['crawler_rate_limit.settings']` — there is no admin UI, config entity, permission or Drush command. On each request `RateLimitManager` reads the merged settings, honors an IP allowlist and a regex path allowlist, then applies up to three independent limits: **bot traffic** (crawlers identified by the `jaybizzle/crawler-detect` library, keyed by the matched bot name), **regular traffic** at the visitor level (keyed by a hash of IP + User-Agent), and **regular traffic at the ASN level** (requires the `geoip2/geoip2` library plus a GeoLite2/GeoIP2 ASN database). Counting is delegated to the `nikolaposa/rate-limit` library backed by **APCu, Redis or Memcached** (chosen via the required `backend` key; the `RateLimitBackendFactory` builds the right limiter). When a limit is reached the middleware returns a tiny `429 Too many requests` response with a `Retry-After` header; an ASN on the `asn_blocklist` gets a `403 Blocked.` response, which takes precedence over everything. If the backend or settings are invalid the limiter fails open (disabled) and reports on the Status report page. It logs nothing to the database by design — rate-limited requests are identified by 429s in the web server access log.

---

- Throttle aggressive AI/SEO crawlers (e.g. Bytespider, GPTBot) to N requests per interval by User-Agent.
- Return HTTP 429 to bots that exceed the configured request budget, then auto-unblock after the interval.
- Count all IPs used by a single named crawler toward one shared limit.
- Rate-limit regular visitors at the IP + User-Agent level to blunt scraping that fakes a browser UA.
- Rate-limit an entire ASN to stop distributed scraping from many IPs in one network.
- Outright block one or more abusive ASNs with a 403 (via `asn_blocklist`).
- Allowlist office/CI IP addresses or CIDR subnets so trusted clients bypass all limiting.
- Exclude specific request paths (regex) such as image styles, batch, or AJAX from being counted.
- Use Redis as the shared counter backend across multiple web nodes.
- Use APCu as a zero-dependency single-server backend.
- Use Memcached (via the Memcache module) as the counter backend.
- Reduce server load during a crawl spike by serving cheap 429s instead of full Drupal responses.
- Set separate intervals/limits for bots vs. humans vs. ASNs.
- Send a `Retry-After` header so well-behaved bots back off politely.
- Protect an origin behind a CDN by limiting per real client IP (with correct reverse-proxy settings).
- Identify rate-limited traffic from access-log 429s without adding DB logging overhead.
- Temporarily clamp down during an incident by tightening `requests`/`interval` in settings.php.
- Migrate a v1/v2 config to v3 by moving `operations`/`interval` under `bot_traffic` and adding `backend`.
- Keep the limiter safely disabled (fails open) if the backend is misconfigured, surfacing errors on the status report.
- Combine bot limiting with ASN blocking for layered protection against a known-bad network.
- Bypass limiting for public files and optimized asset paths automatically (default path allowlist).
- Enforce whole-minute/whole-hour request budgets tuned to your server capacity.
