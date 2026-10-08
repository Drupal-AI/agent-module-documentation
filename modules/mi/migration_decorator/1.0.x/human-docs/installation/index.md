# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Migrate** module (`migrate`) — Drupal enables it automatically as a
  dependency when you turn on this module.

There are no third-party Composer or PHP library requirements.

> This project is **not covered by Drupal's security advisory policy** and is
> minimally maintained — it is developer infrastructure you configure in code, so
> review the bundled plugins before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/migration_decorator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/migration_decorator -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migration_decorator -y
```

Enabling it installs the decorated migration discovery pipeline (its install hook
sets the module weight to 1 so its service provider loads after Migrate Drupal's).
There is nothing to configure in the UI — you shape behavior by writing decorator
plugins.

## Verify it worked

After enabling, clear caches (`drush cr`). The `plugin.manager.migration` service
is now wrapped with the decorator pipeline. To exercise it, add a
`@MigrationDiscoveryDecorator` plugin (see the [main guide](../index.md)), clear
caches again, and confirm your migrations reflect the decoration via
`drush migrate:status`.
