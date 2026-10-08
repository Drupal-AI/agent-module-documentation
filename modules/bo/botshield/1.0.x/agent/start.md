<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BotShield (botshield) — agent index

Request-level **bot mitigation** for Drupal `^10.3 || ^11`. A single HTTP **stack middleware**
(`http_middleware`, priority **250**) classifies each request's **User-Agent**, applies per-bot and
per-IP/CIDR policies (**allow / rate_limit / block**), enforces flood-control safety nets via the
core **Flood API** (per client IP), temporarily blocks abusive IPs with a customizable **HTTP 429**
page, geolocates events, and logs them for admin reports. Package **Security**. Version **1.0.8**.

- Core module deps: **`file`**, **`system`**. Composer: **`geoip2/geoip2:^3.3`** (optional local
  GeoLite2 lookups). No entities, no plugin types, no Drush.
- All config in one config object **`botshield.settings`** (single form). Two permissions:
  **`administer botshield`** (settings), **`view botshield reports`** (report pages). Both
  `restrict access: true`.

## Solution docs

- **Enforcement pipeline (the middleware — how a request is judged)** →
  [architecture/middleware.md](architecture/middleware.md)
- **Configuration: `botshield.settings` keys, schema, policies, geo, alerts** →
  [config/settings.md](config/settings.md)
- **Services, routes, report pages, tables, hooks** → [services/services.md](services/services.md)

## What it provides (from source)

- **Middleware** `Drupal\botshield\StackMiddleware\BotShieldMiddleware` (`implements HttpKernelInterface`;
  not extending core `StackMiddleware` by design). Only enforces `MAIN_REQUEST` when
  `botshield.settings:enabled`. Skips static assets and a few internal utility paths; **skips
  `/admin`** in Phase 1. Account/role bypass is **disabled** (all `isBypass*()` return FALSE).
- **Services** (`botshield.services.yml`): `bot_classifier` (UA→label via `bot_rules` regex, cached),
  `geo_resolver` (headers → GeoLite2 MMDB → optional throttled free API), `rate_limiter`
  (Flood-backed, keyed on client IP), `block_storage` (temp blocks in `botshield_blocks`),
  `event_logger` (`botshield_events`), `bot_stats`, `site_stats`, `alert_manager`
  (watchdog/email/Slack), `bot_catalog`. Six dedicated cache bins.
- **Routes** (`botshield.routing.yml`): settings form + five report pages (dashboard, status, log,
  map, alerts, help) — all behind `administer botshield` or `view botshield reports`.
- **Hooks** (`botshield.module`): `hook_cron` (retention prune), `hook_mail`/`hook_mail_alter`
  (alert emails), `hook_user_login`/`hook_user_logout` (runtime session-marker housekeeping).
- **Tables** (`botshield.install`): `botshield_events`, `botshield_blocks`, `botshield_alerts` +
  six `cache_botshield_*` bins.

Notes: this is app-layer mitigation (not a volumetric/network WAF). Enforcement decisions key on the
**client IP** and the **User-Agent** — both derived from the request; deploy behind correctly
configured trusted proxies and expect that UA-based classification is advisory. See the config doc
for the full key list.
