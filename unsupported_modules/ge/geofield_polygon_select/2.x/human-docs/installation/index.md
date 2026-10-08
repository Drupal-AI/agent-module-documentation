# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Geofield** module (`geofield`) — the widget attaches to Geofield fields
  (and the module also provides an extended Geofield‑based field type).
- The **`jmikola/geojson`** PHP library, which Composer pulls in with the module.

## Install with Composer

From the project root:

```bash
composer require drupal/geofield_polygon_select -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Geofield and the
`jmikola/geojson` library at compatible versions.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/geofield_polygon_select -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en geofield_polygon_select -y
```

Drupal will enable `geofield` alongside it if it isn't already on.

## Verify it worked

Two quick checks:

1. Open the module's **feature collections** admin list and confirm you can add a
   collection (pasting a GeoJSON `FeatureCollection` and setting a keyholder).
2. On a content type that has a Geofield, go to **Manage form display** and check
   that **Polygon select** is available as a widget, with settings (the cog) for
   enabling and ordering collections.

If both are present, the module is installed correctly. See the "How to use it"
section of the [overview](../index.md) for the full setup flow.
