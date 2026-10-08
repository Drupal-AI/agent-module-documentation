# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No contributed modules are required.
- A writable **public files** directory (`public://`), since the module creates its
  `robots.txt` files there.

There are no third-party Composer or PHP library requirements. Note this module is
not covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/robots_rerouter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/robots_rerouter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en robots_rerouter -y
```

## Verify it worked

Log in as an administrator and open **Configuration → Search and metadata → Robots
Rerouter** (`/admin/config/search/robots-rerouter`). If the settings form loads,
the module is installed — continue with the [Configuration](../configuration/index.md)
guide. After saving your settings, visit `/robots.txt` on a non-production host and
confirm you get the disallow-all fallback, and on production confirm you get your
real file.
