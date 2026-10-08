# Installation

## Requirements

- **Drupal 8.9, 9.2, 10, or 11**
  (`core_version_requirement: ^8.9 || ^9.2 || ^10 || ^11`).
- **PHP 7.4 or newer**.
- The **[Facets](https://www.drupal.org/project/facets)** module
  (`drupal/facets ^1.6 || ^2.0 || ^3.0`) — a required dependency. Composer
  installs it and Drupal enables it as a dependency. Facets in turn works with
  Search API, so you will typically already have a Search API index and a search
  page with facets set up.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/facets_date_range -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Facets and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/facets_date_range -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en facets_date_range -y
```

Or enable **Facets Date Range widget** from **Extend** (`/admin/modules`). Facets
is enabled at the same time if it is not already on.

There are no submodules and no configuration page. To use the widget, edit a
facet and select the **Date Range Picker** widget and processor — see
[How to use it](../index.md#how-to-use-it) on the overview page.
