# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's migration modules **Views** (`views`), **Migrate** (`migrate`), and **Migrate
  Drupal** (`migrate_drupal`), all part of Drupal core and enabled as dependencies.
- The contrib migration toolkit, installed by Composer as dependencies:
  - `drupal/migrate_tools` (`^6.0`) — the Drush commands and UI used to run migrations.
  - `drupal/migrate_plus` (`^6.0`) — the migration group/plugin framework the module
    builds on.
- You also need access to the **source database** of the Drupal 6 or 7 site you're
  migrating from.
- No PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/views_migration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in `migrate_tools` and `migrate_plus`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_migration -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_migration -y
```

Enabling it also turns on the required Views, Migrate, Migrate Drupal, Migrate Tools, and
Migrate Plus modules, and installs the two shipped migrations (`d7_views_migration` and
`d6_views_migration`) in a **Views Migration** group. Next, register your old site's
database and run the migrations — see [How to use it](../index.md#how-to-use-it) on the
main page.
