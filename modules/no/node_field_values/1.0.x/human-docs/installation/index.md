# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- No module dependencies beyond core, and no third‑party Composer packages or PHP
  library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/node_field_values -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_field_values -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_field_values -y
```

## Verify it worked

This module has no UI, so there's nothing to see in the admin. Once enabled, its
helper **service** is available in the service container for your own module or theme
code to use. See the [overview](../index.md) for how to call it.
