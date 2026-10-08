# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- No other module dependencies. Note, however, that the module provides **no
  autovalue plugins itself** — you will need a plugin from another module or your
  own code before it does anything useful (see the
  [overview](../index.md#how-to-use-it)).

## Install with Composer

From the project root:

```bash
composer require drupal/field_autovalue -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_autovalue -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_autovalue -y
```

## Verify it worked

Confirm the module is enabled with `drush pm:list --status=enabled | grep
field_autovalue`. On a field's configuration form you should now be able to pick an
autovalue plugin — but only once a plugin is available on the site. See the
[overview](../index.md#how-to-use-it).
