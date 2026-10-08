# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8||^9||^10||^11`).
- Core's **Taxonomy** module (`taxonomy`) — enabled as a dependency.

No external libraries or PHP requirements. You'll want at least one taxonomy
vocabulary (with some terms) for the menu to draw from.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_taxonomy_menu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. (The Composer package name, `drupal/simple_taxonomy_menu`,
matches the module's machine name.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_taxonomy_menu -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_taxonomy_menu -y
```

## Place a menu block

The navigation appears once you place a block. Go to **Structure → Block layout**
(`/admin/structure/block`), pick the **Simple taxonomy menu** block for the
vocabulary you want, drop it into a region, and save. See the **How to use it**
section of the [main guide](../index.md) for the walkthrough.
