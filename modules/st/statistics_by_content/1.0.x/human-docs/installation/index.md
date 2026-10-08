# Installation

## Requirements

Statistics by content type needs:

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's **Statistics** (`statistics`) module, enabled and configured to count
  content views. Drupal enables it as a dependency when you turn this module on.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/statistics_by_content -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/statistics_by_content -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en statistics_by_content -y
```

## After installing

Nothing changes until you configure the module. Go to
`/admin/config/system/statistics/by-content-type` and choose which content types
should keep accruing view counts — see [Configuration](../configuration/index.md).
