# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement:
  ^8 || ^9 || ^10 || ^11`).

There are no other module dependencies and no third-party libraries — this module
relies only on Drupal core.

## Install with Composer

From the project root:

```bash
composer require drupal/machine_name -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/machine_name -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en machine_name -y
```

Once enabled, the **Machine name** field type is available on every fieldable
bundle's **Add field** screen. There is no configuration form; see the
[overview](../index.md#how-to-use-it) for how to add and configure the field.
