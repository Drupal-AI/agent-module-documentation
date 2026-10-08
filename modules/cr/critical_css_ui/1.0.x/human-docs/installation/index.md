# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other contributed modules, PHP extensions, or third‑party libraries are
  required.

This is an early release (`1.0.0-alpha3`) — test it on a staging environment before
rolling it out to production.

## Install with Composer

From the project root:

```bash
composer require drupal/critical_css_ui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/critical_css_ui -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en critical_css_ui -y
```

## Verify it worked

Go to **Configuration → Development → Performance → Critical CSS**
(`/admin/config/development/performance/critical-css`). If the listing page loads,
the module is installed. You can now start adding critical CSS entities and attaching
them to contexts — see [Configuration](../configuration/index.md). If changes don't
appear on the front end, clear caches with `drush cr`.
