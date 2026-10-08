# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- The **Facets** module (`drupal/facets`), version **2.x or 3.x**
  (`^2.0 || ^3.0`) — Facets autocomplete is a widget for it and cannot work
  without it. Composer pulls it in automatically with the command below.

There are no third‑party PHP or JavaScript library requirements — the widget's
JavaScript and CSS ship with the module. This project is **not covered by Drupal's
security advisory policy**, so review it before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/facets_autocomplete -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including the Facets module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/facets_autocomplete -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en facets_autocomplete -y
```

This also ensures the Facets module is enabled.

## Verify it worked

Edit one of your existing facets at **Configuration → Search and metadata →
Facets** (`/admin/config/search/facets`) and confirm that **autocomplete** now
appears in the list of available widgets. Choose it, save, and load the page where
the facet is shown to confirm the type‑ahead field renders and matches values as
you type.
