# Installation

## Requirements

Entity Reference Exposed Filters is a small Views add‑on. It needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Views** module (`views`) enabled — this is the only dependency, and it
  is on by default in a standard Drupal install.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_reference_exposed_filters -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_reference_exposed_filters -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_reference_exposed_filters -y
```

Once enabled, the new filter — **Entity Reference Exposed Filters Node Titles** —
becomes available inside any View. There is no settings page to visit; you add and
configure the filter from within a View, as described on the module's
[overview page](../index.md#how-to-use-it).
