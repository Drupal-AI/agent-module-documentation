# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8.9 || ^9 || ^10 ||
  ^11`), PHP 7.0 or newer.
- Core's **Update** module (`update`) — Vitals depends on it for the
  pending/security-updates check, and Drupal enables it automatically when you
  turn on Vitals.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/vitals -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/vitals -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en vitals -y
```

A random access token is generated automatically on install. The module ships
no submodules. Next, open [Configuration](../configuration/index.md) to copy the
token and build your endpoint URL.
