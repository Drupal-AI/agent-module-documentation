# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Facets** module (`drupal/facets`) — this module extends it and cannot work
  without it. Composer pulls it in with the command below.

There are no third‑party PHP library requirements. This project is **not covered by
Drupal's security advisory policy**, so review it before relying on it in
production.

## Install with Composer

From the project root:

```bash
composer require drupal/facets_custom_order -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including the Facets module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/facets_custom_order -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en facets_custom_order -y
```

This also ensures the Facets module is enabled.

## Verify it worked

Edit one of your facets at **Configuration → Search and metadata → Facets**
(`/admin/config/search/facets`) and confirm the custom‑order option now appears
among the facet's sorting/processor settings. Enable it, arrange the values, save,
and load the page where the facet is shown to confirm it renders in your chosen
order.
