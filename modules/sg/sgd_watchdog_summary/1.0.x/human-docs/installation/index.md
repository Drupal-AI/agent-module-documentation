# Installation

## Requirements

Site Guardian Watchdog Summary is lightweight. It needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Drupal's core **Database Logging** (`dblog`) module, since the summary reads the
  watchdog/dblog entries that `dblog` records.

There are no dependent contrib modules, no third-party Composer packages, and no PHP
library requirements. It pairs with the rest of the *Site Guardian* framework but
does not require it.

## Install with Composer

From the project root:

```bash
composer require drupal/sgd_watchdog_summary -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sgd_watchdog_summary -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sgd_watchdog_summary -y
```

That's all it takes. There is no required configuration.
