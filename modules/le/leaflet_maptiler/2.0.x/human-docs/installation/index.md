# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3||^10||^11`).
- The **Leaflet** module — enable it before Leaflet MapTiler.
- A **MapTiler account** and API key (see Configuration).

There are no third‑party Composer or PHP library requirements of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/leaflet_maptiler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Leaflet
dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/leaflet_maptiler -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en leaflet_maptiler -y
```

This enables the Leaflet dependency if it is not already on. Check the **Status
report** (`/admin/reports/status`) afterwards — you should see no MapTiler‑ or
Leaflet‑related errors.

## Submodule — Leaflet MapTiler Token

The package includes an optional submodule, **Leaflet MapTiler Token**
(`leaflet_maptiler_token`), which provides a Drupal **token** so you can drop a
map into content (such as rich text) without an iframe. Enable it like any other
module:

```bash
drush en leaflet_maptiler_token -y
```

Once enabled, the token is available in the form
`[maptiler:lat_lng_zoom_height:+++]`, where the four `+`‑separated values are:

- **Latitude** — a decimal number for the marker position;
- **Longitude** — a decimal number for the marker position;
- **Zoom** — an integer for the initial zoom level;
- **Height** — an integer for the map height in pixels.

To use tokens inside rich‑text fields you will also need the
[Token Filter](https://www.drupal.org/project/token_filter) module installed and
configured on the relevant text format.

## Verify it worked

Go to **`/admin/config/leaflet_maptiler`** and confirm the settings form loads.
After entering your API key (see [Configuration](../configuration/index.md)),
format a Geofield or a View as a Leaflet map and confirm the MapTiler map renders.
