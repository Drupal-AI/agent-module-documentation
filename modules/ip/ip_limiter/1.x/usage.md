<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
IP Limiter is an application-level, per-IP rate limiter that temporarily bans IP addresses which exceed configurable request thresholds on paths, routes, or by User-Agent.

---

Install with `composer require drupal/ip_limiter` and enable it (`drush en ip_limiter`); it has no dependencies beyond Drupal core (`^10.3 || ^11`). Configure it at **`/admin/config/system/ip-limiter`** (permission **`administer ip limiter configuration`**), where you add one or more **rules**. Each rule picks a **plugin** — **Path** (match the request path, one per line, no leading slash), **Route** (match a Drupal route name), or **User-Agent** (match the browser/bot string) — and sets a **Time Period** (rolling window in seconds), **Maximum Requests** (threshold in that window), **Ban Duration** (seconds), and a **Response Type** returned to banned visitors (**403**, **404**, or **429**). Path and Route rules support optional **regex** matching and extra **matcher conditions** (apply only to bots or only to non-bots, require a `Referer` header, or match a query-string regex). User-Agent rules use a **blacklist** (block matching agents) or **whitelist** (block non-matching agents) strategy with built-in presets (curl, wget, python, scrapy, and security scanners like nikto/sqlmap/nmap, plus SEO bots) and/or custom patterns. A rule marked **Restrict Globally** enforces an offender's ban on every request, not just matching ones. Enforcement runs very early in the request (before authentication) so banned IPs are stopped with little overhead; repeat offenders get escalating ban durations (the multiplier doubles), and cron gradually decays multipliers and removes stale bans. Review and lift bans at **`/admin/config/system/ip-limiter/banned-ips`**, which lists each banned IP with its multiplier, expiry, and the User-Agent/Referer captured at ban time. Note: this is application-level protection (blocked requests still reach the web server) and not a substitute for a firewall; behind a reverse proxy or CDN configure Drupal's trusted-proxy settings so the real client IP is used rather than the proxy's.

---

- Throttle a heavy endpoint such as search or an autocomplete path.
- Temporarily ban IPs that flood a specific path.
- Rate-limit a specific Drupal route by its route name.
- Block scraping tools by User-Agent (curl, wget, python, scrapy).
- Block security scanners by User-Agent (nikto, sqlmap, nmap, masscan, nuclei).
- Deter SEO crawlers (SemrushBot, AhrefsBot, MJ12bot) that overload the site.
- Whitelist only real browsers and block everything else on a sensitive path.
- Return 429 Too Many Requests to well-behaved clients that back off.
- Return 404 Not Found to hide a protected path from abusers.
- Return 403 Access Denied as a hard block.
- Apply a rule only to bots using the "Block bots only" matcher.
- Apply a rule only to human browsers using the "Exclude bots" matcher.
- Require a Referer header before a rule takes effect.
- Match requests by a query-string regex pattern.
- Use regular expressions to match a family of paths (e.g. all node pages).
- Set a short window and low threshold to catch bursty abuse.
- Escalate ban length automatically for repeat offenders.
- Restrict an offender globally so their ban applies site-wide.
- View all currently banned IPs and their expiry.
- Unban an IP address from the admin list.
- Inspect the User-Agent and Referer captured when an IP was banned.
- Let cron decay ban multipliers and clean up stale bans automatically.
- Extend the system with a custom rule plugin (IpLimiterRule type).
- Combine several rules with independent thresholds on different areas.
- Layer lightweight app-level protection on top of a real firewall.
