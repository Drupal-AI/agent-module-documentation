# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`).
- No other module dependencies and no third-party Composer libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/calculate_working_days -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/calculate_working_days -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en calculate_working_days -y
```

## Before you rely on it — fix the form's access control

The settings form ships gated by only the "access content" permission, which
anonymous visitors have by default. That means the form is effectively public
and anyone could overwrite your holiday/weekend calendar. Re-gate the route to
require "Administer site configuration" (or a dedicated permission) before
using the module in earnest — see [Configuration](../configuration/index.md).
