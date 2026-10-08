<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Crawler Rate Limit — agent index

Throttles bots/visitors/ASNs via an **HTTP middleware** and returns **429** (or **403** for a
blocked ASN). **All configuration is in `settings.php`** under
`$settings['crawler_rate_limit.settings']` — no admin UI, no config entity, no permission, no
Drush, no config schema (`configure: null`). Depends on external libs `jaybizzle/crawler-detect`
and `nikolaposa/rate-limit`; a counter backend (`redis` | `apcu` | `memcached`) is required.

- **Every settings.php key, the three limits, backends, ASN, how to enable/verify** →
  [configure/settings.md](configure/settings.md)
- **The runtime pieces: middleware, `RateLimitManager`, `RateLimitBackendFactory`** →
  [api/services.md](api/services.md)

Key facts:
- Required to do anything: `enabled: TRUE` **and** a supported `backend`. Otherwise it fails
  open (disabled) and reports on `/admin/reports/status`.
- Three independent limits, each `interval` (s) + `requests`: `bot_traffic`, `regular_traffic`
  (IP+UA), `regular_traffic_asn` (needs `geoip2/geoip2` + ASN db). A limit is only active when
  both its `interval` and `requests` are > 0.
- `ip_address_allowlist`, `path_allowlist` (regex), `asn_blocklist` (403, takes precedence).
- Read effective settings live with
  `\Drupal\crawler_rate_limit\RateLimitManager::getSettings()`.
