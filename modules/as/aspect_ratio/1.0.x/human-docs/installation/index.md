# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No module dependencies beyond Drupal core, and no third‑party Composer or PHP
  libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/aspect_ratio -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/aspect_ratio -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en aspect_ratio -y
```

Once enabled, images are tagged with their aspect ratio as they render. There is
no settings form — the remaining step is on the theme side, using the tagged
value in your CSS. See [How to use it](../index.md#how-to-use-it).

This module has no submodules.
