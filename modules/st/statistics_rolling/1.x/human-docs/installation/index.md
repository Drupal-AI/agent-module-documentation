# Installation

## Requirements

Statistics Rolling Period needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Statistics** (`statistics`) module, enabled. Drupal enables it as a
  dependency when you turn this module on.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/statistics_rolling -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/statistics_rolling -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en statistics_rolling -y
```

## After installing

For view tracking to work you must enable core Statistics' **count content views**
option and set the rolling period — both on core's Statistics settings page. See
[Configuration](../configuration/index.md).
