# Installation

## Requirements

- **Drupal 10.2+ or 11** (`core_version_requirement: ^10 || ^11`).
- The **Leaflet** module (10.x), which **must include MapLibre GL JS and the
  `leaflet-maplibre-gl` plugin** — both are available from Leaflet's bundled
  libraries, so a current Leaflet install already has them.
- **No API key and no external account** — OpenFreeMap is free to use.

There are no third‑party Composer or PHP library requirements of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/leaflet_openfreemap -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Leaflet
dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/leaflet_openfreemap -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en leaflet_openfreemap -y
```

There is nothing to configure — no key, no account, no settings form.

## Verify it worked

Open any place where you choose a Leaflet map style (a Leaflet field formatter, a
Geofield map widget, or a Leaflet Views display) and confirm the **Liberty**,
**Positron**, and **Bright** OpenFreeMap options appear in the map dropdown.
Select one and confirm the map renders.
