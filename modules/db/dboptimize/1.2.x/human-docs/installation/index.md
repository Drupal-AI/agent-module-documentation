# Installation

## Requirements

- **Drupal 9, 10, 11, or 12** (`core_version_requirement: ^9 || ^10 || ^11 ||
  ^12`).
- A **MySQL** or **MariaDB** database. PostgreSQL is **not** supported yet.
- **Drush** if you want to use the CLI command (optional).

There are no other module dependencies and no third‑party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/dboptimize -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dboptimize -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dboptimize -y
```

## Optimize from the command line (optional)

Alongside the admin UI, DB Optimize provides Drush commands for running
optimizations directly from the CLI — handy for scripting or scheduled maintenance:

```bash
# Optimize all tables (or specific ones)
drush dboptimize:optimize
drush dboptimize:optimize --tables=cache_data,watchdog

# Analyze tables
drush dboptimize:analyze --tables=cache_data,watchdog

# Check tables
drush dboptimize:check --tables=cache_data,watchdog

# Repair tables
drush dbo-repair --tables=cache_data,watchdog
```

Because `OPTIMIZE TABLE` locks tables while it runs, prefer low-traffic windows for
these commands on a live site.

## Verify it worked

Log in as an administrator and go to **Configuration → System → DB Optimize**
(`/admin/config/system/dboptimize`). You should see the optimization form. Run it
once (or run `drush dboptimize:optimize`), then check **Reports → Recent log
messages** for the logged optimization result. Continue to
[Configuration](../configuration/index.md) to choose tables and set up cron.
