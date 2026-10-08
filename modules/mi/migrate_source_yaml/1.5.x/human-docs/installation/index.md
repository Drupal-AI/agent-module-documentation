# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Migrate** module (`migrate`), enabled — the only dependency, and Drupal
  enables it automatically as a dependency.

There are no third-party Composer or PHP library requirements. To actually run
migrations you'll typically also want **Migrate Tools** (`drupal/migrate_tools`)
for the `drush migrate:*` commands, and often **Migrate Plus**
(`drupal/migrate_plus`) if you define migrations as config entities — but neither
is a hard dependency of this module.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_source_yaml -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/migrate_source_yaml -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_source_yaml -y
```

Core Migrate is pulled in automatically if it isn't already on.

## Verify it worked

There's nothing to click — the module just makes the `yaml` source plugin
available. Confirm it by writing a small migration with `source.plugin: yaml`
(see the [overview](../index.md#how-to-use-it) for a complete example) and running
`drush migrate:import <your-migration-id>`. If the module is missing you'll get an
error that the `yaml` source plugin does not exist.
