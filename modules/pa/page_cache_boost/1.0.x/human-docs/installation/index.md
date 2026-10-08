# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Internal Page Cache** module (`page_cache`) enabled — this is the
  storage backend the module builds on, and it is a hard dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/page_cache_boost -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/page_cache_boost -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable core Page Cache and this module

Make sure core's Internal Page Cache is on, then enable the module:

```bash
drush en page_cache page_cache_boost -y
```

That is all that is required — the module starts working immediately for
anonymous traffic, with no admin configuration.

## Optional: tune the behavior in settings.php

There is no admin form; the two adjustable values live in `$settings` in your
`settings.php`:

```php
// How long a stale page may be served while a fresh one is generated (seconds).
$settings['page_cache_boost.stale_response_ttl'] = 10;

// How long the rebuild lock is held before another request may rebuild (seconds).
$settings['page_cache_boost.lock_timeout'] = 30;
```

The defaults (10 seconds and 30 seconds respectively) are sensible for most
sites. Keeping the stale TTL low means visitors only ever see very slightly stale
content while the background rebuild happens. Adjust these per environment as
needed.

## Verify it worked

Confirm `page_cache_boost` is enabled at **Extend** (`/admin/modules`) alongside
core Page Cache. The improvement is in serving behavior rather than anything
visible on screen — under load, popular anonymous pages should be served without
a thundering‑herd of simultaneous rebuilds. It pairs well with a reverse
proxy/CDN layer in front of Drupal.
