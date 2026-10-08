# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- **Drush** — the module's only feature is a Drush command, so you need Drush
  available (it is in every standard Drupal/DDEV setup).
- No other modules and no third‑party Composer or PHP library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/update_config_entity -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/update_config_entity -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en update_config_entity -y
```

The module ships no submodules and needs no configuration. Run the repair command
as shown in the [main guide](../index.md#how-to-use-it), and once the site is fixed
you can safely **uninstall** the module — it has no other purpose.
