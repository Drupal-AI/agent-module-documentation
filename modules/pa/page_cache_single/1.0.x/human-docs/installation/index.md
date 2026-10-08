# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Internal Page Cache** module (`page_cache`) enabled — a hard
  dependency. This module has no effect without it.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/page_cache_single -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/page_cache_single -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable core Page Cache and this module

```bash
drush en page_cache page_cache_single -y
```

The module works for anonymous users immediately, with no additional
configuration.

> **Before you rely on it:** confirm that your site does not display different
> content to anonymous users based on the query string or other per‑request
> variation. If it does, collapsing the cache to a single entry per page could
> serve the wrong variant.

## Verify it worked

Confirm the module is enabled at **Extend** (`/admin/modules`). Over time, the
`cache_page` table should hold far fewer rows, since each content page (and the
404 page) now uses a single anonymous cache entry instead of many.
