# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The contrib **Facets** module (`facets`) — this is the module's only
  dependency. Install it too if it is not already present
  (`composer require drupal/facets`).
- There are no third‑party Composer or PHP library requirements.

This module is intended for a **Search API + Facets** search page whose filters
are applied through URL query parameters.

## Install with Composer

From the project root:

```bash
composer require drupal/facets_reset_button -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/facets_reset_button -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en facets_reset_button -y
```

## After enabling

There is no configuration form. The module's whole feature is a block — place the
**Facets Reset Button block** in the region with your facets, as described in the
[main guide](../index.md).
