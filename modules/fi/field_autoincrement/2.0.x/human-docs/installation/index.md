# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1||^11`).
- Core's **Field** module (`field`) — part of core, enabled as a dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/field_autoincrement -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_autoincrement -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_autoincrement -y
```

## Verify it worked

Go to **Manage fields** on any bundle and click **Add field** — an **Auto
Increment** field type should now be available. See the
[overview](../index.md#how-to-use-it) for how to configure its prefix, suffix, and
start value.
