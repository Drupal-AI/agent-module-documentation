# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No contributed module dependencies and no extra PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/override_cache_control_headers -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/override_cache_control_headers -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en override_cache_control_headers -y
```

## Grant the permission

The module provides the **Administer override cache control headers** permission,
which is flagged as *restricted* because it controls site-wide caching behaviour.
Grant it only to trusted administrators under **People → Permissions**.

## Verify it worked

Visit `/admin/config/development/override-cache-control-headers` to confirm the
settings form loads (see [Configuration](../configuration/index.md)). After adding
a rule, request the matching URL and inspect its response headers (browser dev
tools or `curl -I`) to confirm the `Cache-Control` header matches what you set.
