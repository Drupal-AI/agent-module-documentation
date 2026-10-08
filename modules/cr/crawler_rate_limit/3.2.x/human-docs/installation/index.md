# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- **PHP 7.4 or newer**.
- Two Composer libraries, pulled in automatically when you require the module:
  - `jaybizzle/crawler-detect` (`^1.3`) — identifies bots from the User-Agent.
  - `nikolaposa/rate-limit` (`^3.2`) — does the request counting.
- A **counter backend**, which you must have available before the module can do
  anything. Pick one:
  - **APCu** — the PHP `apcu` extension. Simplest; single-server only.
  - **Redis** — the Drupal [Redis](https://www.drupal.org/project/redis) module
    plus the `phpredis` extension or `predis/predis`. Works across multiple web
    nodes.
  - **Memcached** — the Drupal
    [Memcache](https://www.drupal.org/project/memcache) module plus the
    `memcached` extension.
- **Optional, for ASN features:** `geoip2/geoip2` plus a GeoLite2/GeoIP2 **ASN**
  database file. Only needed if you want to rate-limit or block by network (ASN).

This module has **no dependent Drupal modules** of its own — the backend modules
above are only needed for the backend you choose.

## Install with Composer

From the project root:

```bash
composer require drupal/crawler_rate_limit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update the shared
libraries as needed. Add the optional GeoIP library only if you need ASN
features:

```bash
composer require geoip2/geoip2
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/crawler_rate_limit -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en crawler_rate_limit -y
```

## Important: it does nothing until you configure it

Enabling the module is not enough. It stays inactive until you add settings to
`settings.php` — at minimum the master switch and a supported backend. See
[Configuration](../configuration/index.md) for the full set of keys, then check
the **Status report** (`/admin/reports/status`) to confirm the backend is
healthy.
