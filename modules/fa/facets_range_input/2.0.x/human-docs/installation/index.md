# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1||^11`).
- The **Facets** module (`facets`) enabled — this is the only dependency, and it is
  what provides the facets this widget attaches to.
- A working faceted search (typically a Search API index and facet source) with a
  numeric or date facet to apply the widget to.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/facets_range_input -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/facets_range_input -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en facets_range_input -y
```

If Facets is not already enabled, Drupal enables it as a dependency.

## Verify it worked

Edit any numeric or date facet at **Configuration → Search and metadata → Facets**.
In the facet's **widget** options you should now see the range‑input widget offered
alongside the built‑in list widgets. Select it, save, and the facet will render as a
min/max pair on the search page.
