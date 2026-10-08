# Installation

## Requirements

- **Drupal 8.8 through 12** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11 || ^12`).
- The **[Facets](https://www.drupal.org/project/facets)** module (`facets`).
- The **[Search API](https://www.drupal.org/project/search_api)** module
  (`search_api`).
- A working Search API index with a **numeric field** (integer, decimal, or float)
  indexed, and a **facet** created on that field.

There are no third-party Composer libraries and no permissions.

## Install with Composer

From the project root:

```bash
composer require drupal/facet_range_list_item -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Facets and Search
API (if not already present) and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/facet_range_list_item -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en facet_range_list_item -y
```

There is no settings page to visit next — configuration happens on the facet's edit
form. See [the overview](../index.md#how-to-use-it) for the step-by-step.
