# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Path Alias** module (`path_alias`) — the only dependency, enabled
  automatically (it is part of a standard install anyway).
- There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/customerror -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/customerror -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en customerror -y
```

## After enabling

The module does not take over your error pages automatically — you must complete
two wiring steps: write your error content on the Custom Error settings form, and
point Drupal's core error‑page settings at `/customerror/403` and
`/customerror/404`. Both are covered in [Configuration](../configuration/index.md).
The settings form will warn you if the core error pages are not yet pointed at
the module.
