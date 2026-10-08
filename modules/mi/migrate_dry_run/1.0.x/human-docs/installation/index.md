# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Migrate Tools** (`migrate_tools`) — a required dependency; this module adds
  its dry‑run option to Migrate Tools' execution screen. (Migrate Tools in turn
  brings core Migrate and Migrate Plus.)

There are no third‑party Composer libraries beyond the modules above.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_dry_run -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Migrate Tools and
any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/migrate_dry_run -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_dry_run -y
```

Drush will enable Migrate Tools (and core Migrate) as dependencies if they aren't
already on.

## Verify it worked

Open any migration's **Execute** screen and expand **Additional execution
options** — a **Dry run** checkbox should now be present. Tick it and run a
migration to confirm it previews the result without writing changes.
