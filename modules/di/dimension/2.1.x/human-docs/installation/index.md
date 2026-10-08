# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer**.
- Core's **Field** module (`field`) — enabled on every standard Drupal site, and
  pulled in automatically as a dependency.

There are no third‑party Composer libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/dimension -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dimension -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dimension -y
```

There are no submodules and no module settings page. Once enabled, the three field
types — **Length**, **Area**, and **Volume** — appear in the field‑type list when
you add a field to any content type or other fieldable entity. See
[Configuration](../configuration/index.md) for the per‑field settings.
