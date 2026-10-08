# Installation

## Requirements

Synfilters needs:

- **Drupal 8, 9, 10 or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- The **Better Exposed Filters** module (`better_exposed_filters`) — Synfilters
  extends it, so BEF must be present.
- Core's **Views** (BEF and Synfilters both operate on Views exposed filters).

There are no third-party PHP library dependencies listed.

## Install with Composer

From the project root:

```bash
composer require drupal/synfilters -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Better Exposed
Filters and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/synfilters -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en synfilters -y
```

Drupal will enable Better Exposed Filters automatically as a dependency.

## Verify it worked

Edit a View that has exposed filters and open its Better Exposed Filters
settings in the Views UI. The additional widgets and behaviours Synfilters
provides should now appear among the options for rendering each exposed filter.
