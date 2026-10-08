# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A supported database: **MySQL, MariaDB, or PostgreSQL**.
- **Optional:** Drush, if you want to run optimization from the command line.

There are no extra PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/optimize_database_tables -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/optimize_database_tables -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en optimize_database_tables -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → System → Optimize Database
Tables** (`/admin/config/system/database_optimize_tables`). You should see the
optimization form with the choice between all tables and a selected list. See
[Configuration](../configuration/index.md) for how to run it safely.
