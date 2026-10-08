# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/performance_profiler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/performance_profiler -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en performance_profiler -y
```

## Verify it worked

Browse a few pages, then open **Reports → Recent log messages**
(`/admin/reports/dblog`). You should see entries recording page build time and
peak memory usage. Remember this is a diagnostic tool — disable it again once
you have gathered what you need, rather than leaving it logging verbosely in
production.
