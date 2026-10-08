# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Database Logging** module (`dblog`) enabled — this is the only
  dependency, and Drupal enables it automatically as a dependency when you turn on
  this module.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/search_dblog -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_dblog -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_dblog -y
```

That is all it takes — there is no configuration.

## Verify it worked

Go to **Reports → Recent log messages** (`/admin/reports/dblog`). A search box
should now appear on the report; type a keyword and the log entries filter to
matches.
