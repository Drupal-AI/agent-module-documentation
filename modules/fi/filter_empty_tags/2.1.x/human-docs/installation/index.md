# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No module dependencies — it relies only on Drupal core's Filter system.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/filter_empty_tags -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/filter_empty_tags -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en filter_empty_tags -y
```

There is no settings form to visit. Once enabled, turn the filter on inside a text
format — see the [overview](../index.md#how-to-use-it) for the steps.

There are no submodules.
