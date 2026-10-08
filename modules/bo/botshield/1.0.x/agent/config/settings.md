<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BotShield configuration (`botshield.settings`)

One config object, one form: `Drupal\botshield\Form\SettingsForm` at
`/admin/config/system/botshield` (route `botshield.settings`, permission **`administer botshield`**).
Schema: `config/schema/botshield.schema.yml`. Defaults: `config/install/botshield.settings.yml`.
Enable: `drush en botshield` (creates tables + `private://botshield` dir; seeds `bot_actions` from
the 50-bot `BotCatalog`). Grant `administer botshield` and `view botshield reports` as needed.

## Master switches & scope
- `enabled` (bool, default `true`) — middleware no-ops when false.
- `traffic_scope` (`anonymous` default | e.g. all) — `anonymous` skips authenticated requests that
  lack a session cookie.
- `enforcement_backend` (`flood`) — only Flood is implemented.

## Rate limiting (defaults)
- `threshold_per_minute` (120), `window_seconds` (60), `block_seconds` (900).
- `path_group_rules` (text; `regex|group` lines, default maps `^/jsonapi`,`^/api`→`api`,
  `^/search`→`search`, `.*`→`page`).
- `group_overrides` (text; `group|threshold|block` lines; note the shipped `page|120|900` line is
  intentionally ignored when it would mask changed global defaults — see `resolveGroupOverrides`).

## Allow / block lists
- `whitelist_ips` (text, newline-separated exact IPs) — always pass.
- `override_ips_fid` / `override_ips_path` — a private file of always-allow IPs (default
  `private://botshield/botshield-overrides.txt`).
- `ip_policies` (sequence of `{ip (IP or CIDR), action: allow|rate_limit|block, rpm, log, enabled}`)
  — manual per-IP rules, matched before the blocklist. `ip_policy_block_seconds` (default 3600).

## Bot classification & policy
- `bot_rules` (text; `label|regex|confidence` lines) — drives `BotClassifier`. Default ships ~50
  crawler rules (Googlebot, Bingbot, GPTBot, ClaudeBot, AhrefsBot, …).
- `bot_actions` (sequence keyed by bot label → `botshield.bot_action {action, rpm, log}`) — per-bot
  policy. AI/scraper crawlers default to `rate_limit rpm:30`, search engines to 120.
- `custom_bots` (sequence → `botshield.custom_bot {label, regex, category, action, rpm, log,
  enabled}`) — site-defined rules; take precedence over `bot_rules`.
- `log_unknown_allowed` (false) + `log_unknown_allowed_sample_rate` (10) — sample-log passed
  unknown traffic.

## Flood-control safety nets
- `flood_control_enabled` + `flood_control_threshold_per_minute` (800) / `_window_seconds` (60) /
  `_block_seconds` (3600) — site-wide per-IP.
- `unknown_flood_control_enabled` + `unknown_flood_threshold_per_minute` (120) / `_window_seconds`
  (60) / `_block_seconds` (1800) — stricter, only for `unknown`-label traffic.

## 429 response
- `error_429_enabled` (true), `error_429_title`, `error_429_body` (limited HTML via `Xss::filter`;
  `[Company]`/`%site_name%`, `%retry_after%`, `%reason%` placeholders), `error_429_show_retry_after`,
  `error_429_contact_email` / `error_429_contact_url` (legacy) / `error_429_contact_label`.

## Geolocation (`GeoResolver`)
- Header source: `geo_country_headers`, `geo_region_headers`, `geo_city_headers`,
  `geo_lat_headers`, `geo_lon_headers` (CSV of header names; sensible CDN defaults —
  `cf-ipcountry`, `x-vercel-ip-country`, …).
- GeoLite2: `geolite2_enabled`, `geolite2_mmdb_fid`, `geolite2_mmdb_path` (uploaded MMDB, read via
  `geoip2/geoip2` or maxmind-db). Requires private files.
- Free API fallback: `freeapi_enabled`, `freeapi_endpoint` (must contain `{ip}`),
  `freeapi_timeout_seconds`, `freeapi_requests_per_window`, `freeapi_window_seconds` (Flood-throttled
  site-wide; only called for action events with public IPs, over the Guzzle `http_client`).

## Alerts (`AlertManager`)
- `alerts_enabled`, `alert_watchdog_enabled`, `alert_email_enabled`, `alert_email_to`,
  `alert_slack_enabled`, `alert_slack_webhook_url`, `alert_cooldown_seconds` (900).
- `alert_auto_allow_ip` / `alert_auto_allow_bot` — append triggering IP/bot to state allow-lists
  (`botshield.alert.allow_ips` / `.allow_bots`). `alert_allow_ips` / `alert_allow_bots` (config).
- History is written to `botshield_alerts` even when notifications are off; one email/day per IP.

## Caching & retention
- `caching_mode` (`auto`/`off`), `cache_botmatch_days` (30), `cache_geo_days` (7),
  `cache_block_seconds` (900), `status_cache_selftest` (true).
- `retain_events_days` (14), `retain_blocks_days` (30) — pruned by `botshield_cron`.

Six dedicated cache bins (`cache.botshield_rate|block|geo|botmatch|botstats|sitestats`) are declared
in `botshield.services.yml` and backed by `cache_botshield_*` tables; map them to Redis for scale.
