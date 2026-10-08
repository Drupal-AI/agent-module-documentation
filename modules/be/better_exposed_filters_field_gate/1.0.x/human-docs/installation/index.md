# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Better Exposed Filters** (`better_exposed_filters`) — this module extends its
  widgets.
- Core **Taxonomy** (`taxonomy`).

Composer pulls in Better Exposed Filters automatically; Taxonomy ships with core.

## Install with Composer

From the project root:

```bash
composer require drupal/better_exposed_filters_field_gate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it brings in Better Exposed Filters.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/better_exposed_filters_field_gate -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en better_exposed_filters_field_gate -y
```

Enabling this also enables Better Exposed Filters and Taxonomy if they were not
already on. The gate widget then becomes selectable in the Views exposed‑filter
settings — see [How to use it](../index.md#how-to-use-it).
