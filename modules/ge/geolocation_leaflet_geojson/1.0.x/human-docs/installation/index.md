# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Geolocation** module (`geolocation`).
- The **Geolocation Leaflet** submodule (`geolocation_leaflet`) — this add‑on
  extends the Leaflet maps that submodule provides.

There are no third‑party Composer or PHP library requirements. Note that Leaflet
loads map tiles from a third‑party tile provider in the visitor's browser, as
configured in your Geolocation Leaflet setup.

## Install with Composer

From the project root:

```bash
composer require drupal/geolocation_leaflet_geojson -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Geolocation and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/geolocation_leaflet_geojson -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en geolocation_leaflet_geojson -y
```

Make sure both **Geolocation** and its **Geolocation Leaflet** submodule are
enabled — Drupal will pull them in as dependencies if they aren't already.

## Verify it worked

Open the settings of an existing Geolocation Leaflet map (on a field formatter or
a Views map style). You should see the new **GeoJSON layer** feature available to
enable. Turn it on, point it at a GeoJSON source, save, and confirm your shapes
appear as an overlay on the rendered map.
