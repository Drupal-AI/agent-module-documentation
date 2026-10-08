# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **[Migrate Tools](https://www.drupal.org/project/migrate_tools)** (`migrate_tools`)
  — a required dependency (which in turn brings core's Migrate and, typically,
  Migrate Plus).
- **[CML API](https://www.drupal.org/project/cmlapi)** (`cmlapi`) — required, for the
  exchange protocol.
- **[CML Starter](https://www.drupal.org/project/cmlstarter)** (`cmlstarter`) — the
  expected data structure the migrations map into.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/cmlmigrations -W
```

The `-W` (`--with-all-dependencies`) flag brings in Migrate Tools and the other
dependencies as needed. Install `cmlapi` and `cmlstarter` too if they aren't already
present:

```bash
composer require drupal/cmlapi drupal/cmlstarter -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cmlmigrations -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cmlmigrations -y
```

## After installing or updating

Because the migration adds a `product_uuid` field to variations, run entity updates
after enabling or updating the module:

```bash
drush entity-updates
```

## Verify it worked

Confirm the module's settings page loads and that its Drush commands are available
(`drush list | grep cml`). You're then ready to configure and run the import —
continue to [Configuration](../configuration/index.md).
