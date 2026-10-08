# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Views** module (part of Drupal core) — this module extends a Views
  header/footer plugin.
- No other module dependencies, and no third‑party Composer packages or PHP
  libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/display_link_plus -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/display_link_plus -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en display_link_plus -y
```

## Verify it worked

Edit a View with more than one display, add a **Header** or **Footer** item, and
confirm that **Display Link Plus** appears as an available option alongside core's
plain *Display link*. If it does, the module is installed correctly — configure the
plugin's label, classes, and dialog options as described in the
[overview](../index.md).
