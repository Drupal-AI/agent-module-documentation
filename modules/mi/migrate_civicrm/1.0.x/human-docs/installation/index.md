# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Migrate** module (`migrate`) — a required dependency.
- A working **CiviCRM** install on the same site. The plugins talk to CiviCRM's
  API v4 through its `@civicrm` service at run time, so CiviCRM must be installed
  and configured before you run any migration.
- You will also need to **write your own migration** YAML to describe the
  import/export — the module ships the plugins, not ready‑made migrations.

There are no additional Composer libraries beyond CiviCRM and Migrate.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_civicrm -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. (CiviCRM itself is installed separately following the
CiviCRM project's own instructions.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/migrate_civicrm -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_civicrm -y
```

## Verify it worked

There is no admin page. Confirm CiviCRM is working, write a small migration that
uses the `CiviCrmApi4` source or destination plugin (see
[the module overview](../index.md#how-to-use-it)), and run
`drush migrate:import <migration_id>`. A successful import (or a clean
`migrate:status`) confirms the plugins are available.
