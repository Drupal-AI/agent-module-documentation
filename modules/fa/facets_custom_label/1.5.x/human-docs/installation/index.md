# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Facets** module (`drupal/facets`) installed and enabled — this is a hard
  dependency, and you'll normally already have a working faceted search set up
  (typically with Search API) before this module is useful.
- Optional: core **Configuration Translation** if you want to translate the
  custom labels per language.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/facets_custom_label -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including pulling in Facets if it isn't present yet.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/facets_custom_label -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en facets_custom_label -y
```

Enabling Facets Custom Label makes a new processor, **Facets custom label
processor**, available on your facets. There are no submodules. To actually
relabel any facet items you now turn the processor on for a facet and add your
mappings — see [Configuration](../configuration/index.md).
