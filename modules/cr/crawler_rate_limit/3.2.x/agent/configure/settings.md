<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Crawler Rate Limit (settings.php)

There is **no admin form**. Everything lives in `settings.php` under the single array
`$settings['crawler_rate_limit.settings']`. `RateLimitManager::getSettings()` merges your
values over defaults; read it live with `drush php:eval` (below).

## Required keys

```php
// Master switch. If FALSE, the module does nothing regardless of other settings.
$settings['crawler_rate_limit.settings']['enabled'] = TRUE;

// Counter backend. One of: 'redis' | 'apcu' | 'memcached'. Anything else => limiter disabled.
$settings['crawler_rate_limit.settings']['backend'] = 'apcu';
```

If `enabled` is not TRUE, or `backend` is not one of the three supported values, the limiter is
force-disabled (fails open). Errors surface on `/admin/reports/status`.

## The three independent limits

Each is an array with `interval` (seconds) and `requests` (count). **A limit is only active
when both values are > 0.** Omit a section to disable that limit.

```php
// 1. Bots/crawlers (identified by CrawlerDetect via the User-Agent; keyed by matched bot name).
$settings['crawler_rate_limit.settings']['bot_traffic'] = [
  'interval' => 600,
  'requests' => 100,
];

// 2. Regular traffic, visitor-level (keyed by hash of client IP + User-Agent).
$settings['crawler_rate_limit.settings']['regular_traffic'] = [
  'interval' => 600,
  'requests' => 300,
];

// 3. Regular traffic, ASN-level (needs geoip2/geoip2 + a GeoLite2/GeoIP2 ASN .mmdb).
$settings['crawler_rate_limit.settings']['regular_traffic_asn'] = [
  'interval'  => 600,
  'requests'  => 600,
  'database'  => '/path/to/GeoLite2-ASN.mmdb',
];
```

Evaluation order in `RateLimitManager::limit()`: IP allowlist → path allowlist → if crawler and
`bot_traffic` active, apply bot limit (return); else apply `regular_traffic` (visitor) limit;
if not exceeded and `regular_traffic_asn` active, apply ASN limit. Exceeding any active limit
returns **429** with a `Retry-After` header equal to that limit's interval.

## Allow / block lists

```php
// IPs / CIDR subnets that bypass ALL rate limiting (IPv4 + IPv6).
$settings['crawler_rate_limit.settings']['ip_address_allowlist'] = ['127.0.0.1', '10.0.0.0/8'];

// ASNs to block outright -> 403 "Blocked." Takes precedence over limiting AND the IP allowlist.
// Requires geoip2/geoip2 + the ASN database path (see regular_traffic_asn['database']).
$settings['crawler_rate_limit.settings']['asn_blocklist'] = [24567, 202469];

// Regex patterns for request URIs that must NOT be rate limited. If you set this you REPLACE
// the built-in default list (public files, image styles, /batch, layout_builder, ckeditor,
// autocomplete, favicon, ...). Start from RateLimitManager::defaultPathAllowlist() if editing.
$settings['crawler_rate_limit.settings']['path_allowlist'] = [ /* ...regex strings... */ ];
```

## Read the effective settings on the live site

```bash
drush php:eval 'var_export(\Drupal\crawler_rate_limit\RateLimitManager::getSettings());'
# or the raw override only:
drush php:eval 'var_export(\Drupal\Core\Site\Settings::get("crawler_rate_limit.settings"));'
```

Useful derived flags in the returned array: `limit_bots`, `limit_regular`, `limit_regular_asn`
(TRUE when the matching section's interval & requests are both > 0), and `deprecated` (TRUE when
legacy v1/v2 `interval`+`operations` keys were detected and auto-migrated to `bot_traffic`).

## v1/v2 → v3 migration

Old:
```php
$settings['crawler_rate_limit.settings']['operations'] = 100;
$settings['crawler_rate_limit.settings']['interval'] = 600;
```
New: add `backend`, and move to `bot_traffic` => `['requests' => 100, 'interval' => 600]`.
(The module auto-handles the old keys but defaults `backend` to `redis` in that path.)

## Verify it works

Send more than `requests` bot requests within `interval`; the last should be `429`:
```bash
for i in $(seq 1 101); do curl -A "Bytespider" -skLI "https://example.com/?i=$i" | head -1; done
```
Rate-limited requests appear as `429` in the web server access log (no DB logging by design).
Backend prerequisites (extensions/modules) are listed in the module README.
