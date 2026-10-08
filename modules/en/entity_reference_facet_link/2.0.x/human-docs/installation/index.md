# Installation

## Requirements

- **Drupal 8.7.7, 9, 10, or 11**
  (`core_version_requirement: ^8.7.7 || ^9 || ^10 || ^11`).
- The **[Facets](https://www.drupal.org/project/facets)** module — this is a hard
  requirement at runtime (the formatters build their links using Facets' URL
  processors). It isn't listed as a Composer/`info.yml` dependency, so install it
  yourself if it isn't already present.
- A working **faceted search page** whose facet targets the field you want to
  format — typically built with **Search API**, **Facets**, and a view. Without an
  existing facet on that field, the formatters have nothing to link to.

There are no third-party PHP library requirements.

## Install with Composer

From the project root, install this module (and Facets if you don't already have
it):

```bash
composer require drupal/entity_reference_facet_link drupal/facets -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_reference_facet_link -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the modules

```bash
drush en facets entity_reference_facet_link -y
```

There's no configuration screen. Once enabled, the **Facet link** and **Facet
URL** formatters become available on `entity_reference` fields — choose one on a
field's *Manage display* page and pick the target facet, as described in
[How to use it](../index.md#how-to-use-it) on the overview page.
