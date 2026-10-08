# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- No dependent modules, and no third-party Composer or PHP library requirements.

The tool runs **only from the command line** — its bootstrap script returns
immediately under any non-CLI PHP SAPI, so there is nothing to configure or expose
on the web.

## Install with Composer

From the project root:

```bash
composer require drupal/smart_db_tools -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/smart_db_tools -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en smart_db_tools -y
```

## Verify it worked

From your site root, run the script with no arguments to confirm it is present and
executable:

```bash
php modules/contrib/smart_db_tools/scripts/smart-db-tools.php
```

You should see the DbTools application's usage/help output. From there, see the
[main guide](../index.md) for how to run a per-table split dump.
