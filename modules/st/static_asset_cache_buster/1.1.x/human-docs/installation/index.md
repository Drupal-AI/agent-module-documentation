# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No contrib module dependencies, no third-party PHP libraries — nothing beyond
  core.

## Install with Composer

From the project root:

```bash
composer require drupal/static_asset_cache_buster -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/static_asset_cache_buster -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en static_asset_cache_buster -y
```

That's all it takes — there is no settings form. Enabling the module is the whole
configuration: from now on rendered image and file URLs carry a cache-busting
version marker derived from each file's metadata.

## Verify it worked

View the page source (or inspect an image) on a page that renders an uploaded image
or file — the URL should now carry a query-string version marker. Replace a file in
place, clear caches if needed, and confirm the marker changes so the fresh bytes
are served.

Remember the CDN trade-off from the [main guide](../index.md): a changed query
string is a new cache key, and some CDNs ignore query strings for caching — check
your edge configuration if busting seems to have no effect.
