# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- No third-party Composer or PHP library requirements, and no other module
  dependencies beyond core's Field system.

## Install with Composer

From the project root:

```bash
composer require drupal/bundle_reference -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bundle_reference -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bundle_reference -y
```

Once enabled, the **Bundle reference** field type is available when you add a
field to any bundle via **Manage fields**. There is no separate configuration
step for the module itself.
