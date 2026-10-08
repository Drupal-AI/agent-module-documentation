# Configuration

Crawler Rate Limit has **no admin form**. Everything lives in your site's
`settings.php` (or an included settings file) under the single array
`$settings['crawler_rate_limit.settings']`. Your values are merged over the
module's defaults on every request.

After editing `settings.php`, the changes take effect on the next request — no
cache clear needed. Always check the **Status report**
(`/admin/reports/status`) afterwards; a misconfigured backend or settings shows
up there, and the limiter simply stays disabled ("fails open") rather than
breaking the site.

## Required: turn it on and choose a backend

```php
// Master switch. If not TRUE, the module does nothing, whatever else is set.
$settings['crawler_rate_limit.settings']['enabled'] = TRUE;

// Counter backend. One of: 'apcu' | 'redis' | 'memcached'.
// Anything else leaves the limiter disabled.
$settings['crawler_rate_limit.settings']['backend'] = 'apcu';
```

The backend must actually be available (extension and, for Redis/Memcached, the
matching Drupal module) — see [Installation](../installation/index.md).

## The three limits

Each limit is an array with an **`interval`** (in seconds) and a **`requests`**
count (how many requests are allowed in that window). A limit is only active when
**both** values are greater than zero; omit a section to leave that limit off.

```php
// 1. Bots / crawlers — identified by the User-Agent, counted per bot name.
$settings['crawler_rate_limit.settings']['bot_traffic'] = [
  'interval' => 600,   // 10 minutes
  'requests' => 100,
];

// 2. Regular visitors — counted per client (a hash of IP + User-Agent).
$settings['crawler_rate_limit.settings']['regular_traffic'] = [
  'interval' => 600,
  'requests' => 300,
];

// 3. Regular traffic per ASN (whole network).
//    Needs the geoip2/geoip2 library and a GeoLite2/GeoIP2 ASN database.
$settings['crawler_rate_limit.settings']['regular_traffic_asn'] = [
  'interval'  => 600,
  'requests'  => 600,
  'database'  => '/path/to/GeoLite2-ASN.mmdb',
];
```

For each request the module checks, in order: the IP allowlist, then the path
allowlist, then — if the client is a crawler and the bot limit is active — the
**bot** limit; otherwise the **visitor** limit; and finally, if still within
limits, the **ASN** limit. Exceeding any active limit returns **429** with a
`Retry-After` header equal to that limit's interval, after which the client is
automatically unblocked.

## Allow lists and the ASN block list

```php
// IPs or CIDR subnets that bypass ALL rate limiting (IPv4 and IPv6).
$settings['crawler_rate_limit.settings']['ip_address_allowlist'] = [
  '127.0.0.1',
  '10.0.0.0/8',
];

// ASNs to block outright with a 403 "Blocked." response.
// This takes precedence over everything, including the IP allowlist.
// Requires geoip2/geoip2 + the ASN database (see regular_traffic_asn['database']).
$settings['crawler_rate_limit.settings']['asn_blocklist'] = [24567, 202469];

// Regex patterns for request paths that must NOT be counted.
// WARNING: setting this REPLACES the built-in default list (public files,
// image styles, /batch, layout_builder, ckeditor, autocomplete, favicon, ...).
// If you customise it, start from that default list so you keep those exclusions.
$settings['crawler_rate_limit.settings']['path_allowlist'] = [ /* regex strings */ ];
```

## Check the effective settings on a live site

```bash
drush php:eval 'var_export(\Drupal\crawler_rate_limit\RateLimitManager::getSettings());'
```

The returned array includes handy derived flags — `limit_bots`, `limit_regular`,
`limit_regular_asn` (TRUE when the matching section is fully configured) — and
`deprecated` (TRUE when older v1/v2 keys were detected and auto-migrated).

## Verify it works

Fire more than `requests` bot requests within the `interval` and watch the last
one get a `429`:

```bash
for i in $(seq 1 101); do curl -A "Bytespider" -skLI "https://example.com/?i=$i" | head -1; done
```

Rate-limited requests appear as `429` (and blocked ASNs as `403`) in your web
server access log — there is no database logging by design.

## Upgrading from version 1 or 2

Older versions used top-level `operations` and `interval` keys. In version 3,
add a `backend`, and move those values under `bot_traffic` as
`['requests' => …, 'interval' => …]`. The module auto-handles the old keys for
compatibility, but defaults `backend` to `redis` in that path — so set it
explicitly.
