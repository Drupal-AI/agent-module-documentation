# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- **CMRF Views** (`cmrf_views`, part of the CMRF Core project) — the CiviCRM data
  source, backed by a working CiviMRF connection to a CiviCRM backend.
- **Leaflet Views** (`leaflet_views`, part of the Leaflet project) — the map
  rendering, tiles, and markers.

There are no additional PHP library requirements. (The Leaflet JavaScript is
handled by the Leaflet module.)

## Install with Composer

From the project root:

```bash
composer require drupal/cmrf_leaflet_views -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the CMRF and
Leaflet dependencies as needed. You will typically also need the CMRF Core and
Leaflet base projects if they are not already present:

```bash
composer require drupal/cmrf_core drupal/leaflet -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/cmrf_leaflet_views -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cmrf_leaflet_views -y
```

Drupal will enable the `cmrf_views` and `leaflet_views` dependencies for you.

## Verify it worked

This module adds no page of its own. To confirm it is active, create or edit a
CMRF-backed **View** and open the **Format** section — the **CiviMRF Leaflet
Map** style should now be available to choose. See the "How to use it" section of
the [guide](../index.md) for the full setup, including the `POINT(...)`
coordinate field.
