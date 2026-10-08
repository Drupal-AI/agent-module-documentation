# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11**
  (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The contrib **Token** module (`token`) — a declared dependency, enabled
  automatically.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/tokenuuid -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Token and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/tokenuuid -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tokenuuid -y
```

Drupal enables Token at the same time if it isn't already on. The UUID tokens are
then available immediately — see the [main page](../index.md) for how to use
them, and visit `/admin/help/tokenuuid` for the exact list generated on your
site.

## Submodules

None — Token UUID ships as a single module.
