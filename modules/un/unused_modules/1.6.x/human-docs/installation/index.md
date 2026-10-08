# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).

There are no module dependencies, no PHP version requirement, and no third-party
Composer libraries. **Site Audit** (`site_audit`) is optional — install it only if
you want the unused-module check to run as part of a Site Audit report.

## Install with Composer

From the project root:

```bash
composer require drupal/unused_modules -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/unused_modules -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en unused_modules -y
```

The module adds no permission of its own — access to its report is controlled by
the core **Administer modules** permission, which administrators already have. Once
enabled, view the report at **Configuration → Development → Unused Modules** or run
`drush unused:modules` — see [Configuration](../configuration/index.md).

There are no submodules.
