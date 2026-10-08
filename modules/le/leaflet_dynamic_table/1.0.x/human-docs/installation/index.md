# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- **Views** (Drupal core).
- The **Leaflet** module and its **Leaflet Views** submodule (`leaflet_views`,
  included with Leaflet) — this module adds a display that extends Leaflet Views.
- Entities with **geographic coordinates** to map.

There are no third‑party Composer or PHP library requirements of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/leaflet_dynamic_table -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Leaflet
dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/leaflet_dynamic_table -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en leaflet_dynamic_table -y
```

This enables the Views, Leaflet, and Leaflet Views dependencies if they are not
already on.

## Verify it worked

Edit or create a View that has a **Leaflet Map** display, and confirm that
**Leaflet Dynamic Attachment** is offered when you add a new display. Attach it
to the map display, view the page, and check that panning and zooming the map
updates the table below it. From there, follow "How to use it" on the
[overview page](../index.md).
