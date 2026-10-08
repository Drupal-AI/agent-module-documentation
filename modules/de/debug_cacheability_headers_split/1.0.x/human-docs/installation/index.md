# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- No module dependencies, and no third-party Composer or front-end library
  requirements.
- To have any effect, Drupal's **debug cacheability headers** must be enabled
  (the `http.response.debug_cacheability_headers` service parameter, typically set
  in `development.services.yml`). This module only acts on those headers.

## Install with Composer

From the project root:

```bash
composer require drupal/debug_cacheability_headers_split -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/debug_cacheability_headers_split -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en debug_cacheability_headers_split -y
```

> **Development aid.** Because it only matters when debug cacheability headers are
> on — which is a development setting — you'll usually enable this on local and
> staging environments rather than production.

## Verify it worked

With debug cacheability headers enabled, load a page that has a large number of
cache tags and inspect the response headers (your browser's network panel or
`curl -I`). Where previously you'd have seen a server error, you should now see the
tags split across `X-Drupal-Cache-Tags`, `X-Drupal-Cache-Tags-1`,
`X-Drupal-Cache-Tags-2`, and so on. Tune the thresholds on the
[Configuration](../configuration/index.md) page if your server's header limit
differs from the default.
