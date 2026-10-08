<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BotShield services, routes, tables & hooks

## Services (`botshield.services.yml`)
- **`botshield.middleware`** → `StackMiddleware\BotShieldMiddleware` — the enforcement engine (see
  [../architecture/middleware.md](../architecture/middleware.md)). `http_middleware` priority 250.
- **`botshield.bot_classifier`** → `Service\BotClassifier::classify(string $ua): {label, confidence}`.
  Parses `bot_rules` (`label|regex|confidence`), matches `@preg_match('/'.$regex.'/i', $ua)`, caches
  by `ua:sha256(ua)` in `cache.botshield_botmatch` for `cache_botmatch_days`. Empty UA → `unknown`.
- **`botshield.geo_resolver`** → `Service\GeoResolver::resolve($request, $ip, $allowExternal)`.
  Order: CDN/hosting headers → GeoLite2 MMDB (`geoip2/geoip2` `Reader`, or maxmind-db fallback;
  public IPs only) → optional free API (only when `$allowExternal` and `freeapi_enabled`;
  Flood-throttled `botshield:geoapi`, short Guzzle timeouts, `{ip}` substituted rawurlencoded).
  Results cached in `cache.botshield_geo`.
- **`botshield.rate_limiter`** → `Service\RateLimiter::registerAndCheck($ip, $group, $threshold,
  $window)` — wraps core Flood (`register` then `isAllowed`), name `botshield:<group>`, identifier =
  client IP. `clear()` resets counters after a block.
- **`botshield.block_storage`** → `Service\BlockStorage` — temp blocks in `botshield_blocks`, keyed
  by `ip_hash = sha256(ip)` (+ cache in `cache.botshield_block`); schema-tolerant
  (`blocked_until`/`until`, `ip`/`ip_hash`). `block()`, `remainingSeconds()`.
- **`botshield.event_logger`** → `Service\EventLogger::log(array)` — inserts into `botshield_events`.
- **`botshield.bot_stats`** / **`botshield.site_stats`** — counters in `cache.botshield_botstats` /
  `cache.botshield_sitestats` (+ `keyvalue.expirable`), used by report pages.
- **`botshield.alert_manager`** → `Service\AlertManager::notifyFlood($type, $context)` /
  `sendTestEmail()` — records history to `botshield_alerts`, then (if `alerts_enabled`) watchdog +
  email (`plugin.manager.mail`, key `flood_alert`/`test_email`, with direct-plugin and native
  `mail()` fallbacks) + Slack POST to `alert_slack_webhook_url`. Cooldown-throttled; 1 email/day/IP.
- **`botshield.bot_catalog`** → `Service\BotCatalog::knownBots()` — the built-in 50-bot catalog used
  to seed `bot_actions` on install/update.
- **`Service\IpResolver`** — a minimal `getClientIp()` wrapper (honors Symfony trusted proxies).
  Present but **not** injected into the middleware.

## Routes (`botshield.routing.yml`) & permissions
- `botshield.settings` `/admin/config/system/botshield` → `Form\SettingsForm` — **`administer botshield`**.
- `botshield.dashboard` `/admin/reports/botshield` → `Controller\DashboardController::overview`.
- `botshield.status` `/admin/reports/botshield/status` → `Controller\StatusController::status`.
- `botshield.log` `/admin/reports/botshield/log` → `Form\LogReportForm`.
- `botshield.map` `/admin/reports/botshield/map` → `Form\MapReportForm` (Leaflet via CDN in
  `botshield.libraries.yml` `map`).
- `botshield.alerts` `/admin/reports/botshield/alerts` → `Form\AlertHistoryReportForm`.
- `botshield.help` `/admin/reports/botshield/help` → `Controller\HelpController::guide`
  (`view botshield reports+administer botshield`).
  All report routes require **`view botshield reports`**. Both permissions are `restrict access: true`.
  Other forms: `GeoTestForm`, `DashboardClearLogsForm`, `OverviewFiltersForm`, `LogReportForm`,
  `MapReportForm` (all reached from admin report pages).

## Tables (`botshield.install` → `botshield_schema()`)
- **`botshield_events`** — logged rate-limit/blocked/allowed events (event_type, reason, ip, ip_hash,
  bot_label, user_agent, path, path_group, geo fields, limit/window, created).
- **`botshield_blocks`** — active/expired blocks (ip, ip_hash, bot_label, reason, path_group, geo,
  `blocked_until`, created/changed; unique key `ip_hash+path_group+reason`).
- **`botshield_alerts`** — flood-alert history (incident_type, title, body, ip/host/geo, threshold,
  window, block_seconds, context_json).
- Six `cache_botshield_*` bins created explicitly (not via cache.bin tags) so uninstall can drop them.

## Hooks (`botshield.module`, `#[LegacyHook]`)
- `hook_cron` — prunes `botshield_events` (chunked, `retain_events_days`), expired `botshield_blocks`
  (`retain_blocks_days`), and `botshield_alerts`. Never throws.
- `hook_mail` / `hook_mail_alter` / `hook_module_implements_alter` — build & protect alert emails
  (keys `flood_alert`, `test_email`).
- `hook_user_login` / `hook_user_logout` — clear legacy bypass cookies and housekeep dormant runtime
  session markers in state. (Account bypass itself is disabled in 1.0.x.)
- `botshield_clear_logged_items()` — clears event/alert/sitestats data (used by the clear-logs form).

## Install notes
- Requires core `file` + `system`; `composer require drupal/botshield` pulls `geoip2/geoip2:^3.3`.
- Configure `$settings['file_private_path']` for MMDB / override-file uploads (install warns if unset).
- Ensure cron runs; check `/admin/reports/botshield/status` for cache-bin, geo-reader, and mail health.
