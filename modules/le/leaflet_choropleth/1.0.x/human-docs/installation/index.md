# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2||^11`).
- The **Leaflet** module and its **Leaflet Views** submodule (`leaflet_views`) —
  this module builds on Leaflet Views to draw its shaded layers, and the region
  data and values come from a View.
- Content or entities with **polygon / multipolygon** geometry and a **numeric
  field** to drive the shading.

There are no third‑party Composer or PHP library requirements of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/leaflet_choropleth -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Leaflet
dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/leaflet_choropleth -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en leaflet_choropleth -y
```

This enables the `leaflet_views` dependency (and the Leaflet module behind it) if
they are not already on.

## Verify it worked

Check the **Status report** (`/admin/reports/status`) for any Leaflet‑related
errors, then edit or create a View and confirm the choropleth Leaflet map style
is offered as a **Format**, with a **Choropleth Map Settings** section available.
From there, follow "How to use it" on the [overview page](../index.md).
