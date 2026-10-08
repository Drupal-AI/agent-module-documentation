# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The **Webform** module (`drupal/webform`) — required. This is a contrib module,
  so Composer pulls it in for you if it isn't already present.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/webform_composite -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — here it also pulls in the required **Webform** module if
you don't already have it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/webform_composite -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en webform_composite -y
```

This enables Webform as a dependency if it isn't already on. Once enabled, a
**Composites** tab appears under Webform's configuration — see
[Configuration](../configuration/index.md).

There are no submodules.
