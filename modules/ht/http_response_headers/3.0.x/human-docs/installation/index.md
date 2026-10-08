# Installation

## Requirements

- **Drupal 10.6, 11.3, or 12** (`core_version_requirement: ^10.6 || ^11.3 || ^12`).
- No other modules, and no third-party Composer or PHP libraries. It reuses core's
  own condition plugins for the visibility feature.

## Install with Composer

From the project root:

```bash
composer require drupal/http_response_headers -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/http_response_headers -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en http_response_headers -y
```

You can also enable it from **Extend** (`/admin/modules`).

## What happens next

Enabling the module installs ten ready-made header configurations (X-Frame-Options,
Content-Security-Policy, Strict-Transport-Security, and so on), but they arrive
**disabled or empty**, so your site's response headers do not change until you enable
and configure them. Head to [Configuration](../configuration/index.md) to turn on the
ones you want or add your own.
