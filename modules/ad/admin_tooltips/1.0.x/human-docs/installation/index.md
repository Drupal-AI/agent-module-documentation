# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's Field system, which every standard Drupal site already has.

There are no third-party Composer or PHP library requirements. Note the current
release is a beta.

## Install with Composer

From the project root:

```bash
composer require drupal/admin_tooltips -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/admin_tooltips -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en admin_tooltips -y
```

Once enabled, a tooltip text setting is available in each field's configuration
form. See the [overview](../index.md) for how to add a tooltip to a field.
