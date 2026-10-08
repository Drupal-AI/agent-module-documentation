BotShield is a request-level bot-mitigation module that classifies traffic by User-Agent, applies per-bot and per-IP policies (allow / rate-limit / block), enforces flood-control safety nets, enriches events with geolocation, and reports it all on admin dashboards.

---

BotShield installs a single HTTP stack middleware that inspects every non-static main request before the router runs. It classifies the request's User-Agent against configurable regex rules (50+ known crawlers plus custom entries), resolves a per-bot or per-IP/CIDR policy, and either allows, rate-limits, or blocks the client. Rate limiting and flood control use Drupal's Flood API (per client IP), and temporary blocks are stored in a dedicated table and served as a customizable HTTP 429 page. Requests are geolocated from CDN/hosting headers, an optional local GeoLite2 MMDB, or a throttled free geo API, and are logged to `botshield_events` / `botshield_blocks`. Operators tune behavior from `/admin/config/system/botshield` and monitor it from report pages (dashboard, status, log, map, alerts) at `/admin/reports/botshield`. Flood incidents can raise watchdog, email, or Slack alerts, and cron prunes old events, blocks, and alerts. It is aimed at sites that want Drupal-native crawler control and telemetry rather than a full edge/CDN WAF.

---

- Rate-limit AI crawlers (GPTBot, ClaudeBot, PerplexityBot, CCBot, Bytespider, Amazonbot) to a low requests-per-minute to curb training-data scraping.
- Block a specific misbehaving bot outright by setting its per-bot action to `block` in the bot policy table.
- Allow well-behaved search engines (Googlebot, Bingbot, DuckDuckBot, Applebot) while throttling everything else.
- Apply stricter per-minute thresholds to expensive path groups such as `/jsonapi`, `/api`, and `/search` using path-group rules and group overrides.
- Add a site-wide flood-control safety net that temporarily blocks any IP exceeding a high request volume (default 800/min).
- Apply a more aggressive "unknown-bot" flood control for traffic that matches no known crawler.
- Permanently allow trusted IPs or CIDR ranges (office, monitoring, uptime checkers) via the whitelist or the private override file.
- Block or rate-limit specific abusive IPs/CIDR ranges with manual IP policy rules.
- Classify custom or in-house bots by adding label + regex + action rows to the custom-bots list.
- Show a branded, translatable HTTP 429 "please slow down" page with a countdown and a contact link when a visitor is throttled.
- Return a JSON 429 body automatically to API/AJAX callers that send `Accept: application/json`.
- Enrich blocked/rate-limited events with country/region/city/lat/lon for reporting and mapping.
- Use a locally uploaded GeoLite2-City MMDB (via `geoip2/geoip2`) for geolocation without external calls.
- Fall back to a throttled free geo API (configurable endpoint, per-window request cap) only for action events when local geo is missing.
- Review recent rate-limited and blocked events on a filterable log page.
- Visualize where blocked/limited traffic originates on a Leaflet map with state/region aggregation.
- Receive email or Slack alerts when flood thresholds are exceeded, with per-incident cooldown and a daily per-IP email cap.
- Keep a browsable alert history even when notifications are disabled.
- Restrict enforcement to anonymous traffic while tuning, then widen scope once thresholds are validated.
- Tune bot-match and geo cache TTLs, and route BotShield's dedicated cache bins to Redis for scale.
- Automatically prune old events, expired blocks, and alert history on cron to keep tables lean.
- Run a status/health page to confirm cache bins, GeoLite2 reader availability, private-file setup, and mail configuration.
