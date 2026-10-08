# Installation

## Requirements

Views Taxonomy radios filter is lightweight. It needs:

- **Drupal 8.8, 9, 10, or 11**
  (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Taxonomy** and **Views** modules (both part of Drupal core), enabled as
  dependencies.

There are no third-party Composer or PHP library requirements.

> **Note:** the `1.0.x` version directory is a development/pre-release snapshot.
> Review it before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/views_taxonomy_radios_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_taxonomy_radios_filter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_taxonomy_radios_filter -y
```

Taxonomy and Views are enabled automatically as dependencies. There is no settings
page — configure the radios/checkboxes option per filter in the Views UI, as
described in the [overview](../index.md).
