# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- A **caching layer**. The module assumes a full‑page cache or reverse proxy is in
  use — Drupal's internal Page Cache and Dynamic Page Cache, or an external
  solution such as Varnish, Nginx, or Cloudflare. Without caching there is no
  performance improvement.

There are no third‑party PHP libraries and no other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/fast_error_pages -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fast_error_pages -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fast_error_pages -y
```

Once enabled, the module automatically intercepts 404 and 403 errors — there is no
required configuration.

## Verify it worked

Make sure a page cache is active, then request a non‑existent path (for example
`/does-not-exist`) as an anonymous visitor. The first request renders and caches
your themed 404; subsequent requests to the same status are served from cache
noticeably faster. If you have a branded 404/403 page set at **Configuration →
System → Basic site settings**, that is the page you should see.
