# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- The **Facets** module (`drupal/facets`) — this module provides a widget for it
  and cannot work without it. Composer pulls it in with the command below.

There are no third‑party PHP library requirements. This project **is covered by
Drupal's security advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/facets_navlinks_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including the Facets module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/facets_navlinks_widget -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en facets_navlinks_widget -y
```

This also ensures the Facets module is enabled.

## Verify it worked

Edit one of your facets at **Configuration → Search and metadata → Facets**
(`/admin/config/search/facets`) and confirm the **navigation links** widget now
appears in the list of available widgets. Choose it, save, and load the page where
the facet is shown to confirm the values render as navigation links.
