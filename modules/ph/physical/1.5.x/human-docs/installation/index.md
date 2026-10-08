# Installation

## Requirements

Physical Fields has minimal requirements:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 8.0 or newer** (`php: ^8.0`).
- Core's **Field** module (`field`), which Drupal enables automatically as a
  dependency.

For the precision-safe arithmetic it is best to have PHP's **bcmath** extension
available; it is standard in most Drupal-ready PHP builds (including DDEV).

There are no third-party Composer packages to install.

## Install with Composer

From the project root:

```bash
composer require drupal/physical -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/physical -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en physical -y
```

That's all. There is no configuration page and no permissions to grant. To start
using it, add a **Measurement** or **Dimensions** field through the Field UI, or
use the PHP value-object API in your own code — see the
[overview](../index.md#how-to-use-it) for both.

There are no submodules.
