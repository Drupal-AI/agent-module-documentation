# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- A working Drupal **cron** (the optimization runs on `hook_cron`), unless you only
  ever use the manual "Optimize now" link.
- A **MySQL/MariaDB** or **PostgreSQL** database — the module picks the right query
  (`OPTIMIZE TABLE` or `VACUUM`) automatically based on your connection.

There are **no Composer library dependencies** and no other required modules.

## Install with Composer

From the project root:

```bash
composer require drupal/db_maintenance -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/db_maintenance -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en db_maintenance -y
```

The module does nothing until you configure it: no tables are optimized until you
select some (or enable "Optimize all tables") on the settings form. Continue with
[Configuration](../configuration/index.md).

## Verify it worked

Grant the *Administer db maintenance* permission, then visit **Configuration →
System → DB Maintenance** (`/admin/config/system/db_maintenance`). You should see
the settings form listing the tables in your database.
