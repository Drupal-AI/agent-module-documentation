# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The **[Leaflet](https://www.drupal.org/project/leaflet)** module (`drupal/leaflet`,
  `^2.1.0 || ^10.0`) — a hard dependency. Composer installs it automatically. You'll
  typically also want something to put on a map, such as a Geofield field or the
  Leaflet Views integration, but that's part of setting up Leaflet itself.

There are no PHP library requirements. Some map providers require an API key (see
[Configuration](../configuration/index.md)), but those are entered in the UI, not
installed.

## Install with Composer

From the project root:

```bash
composer require drupal/leaflet_more_maps -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed — including pulling in the Leaflet module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/leaflet_more_maps -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en leaflet_more_maps -y
```

The extra map styles are now available in every Leaflet map-style dropdown.

## Optional submodule — Leaflet Demo

**Leaflet Demo** (`leaflet_demo`) ships inside this project and renders every
currently-available map style on one page — a quick way to preview the catalogue
and to check that any API keys you enter actually work:

```bash
drush en leaflet_demo -y
```

## Next steps

If you plan to use a style from a provider that needs a key or token
(Thunderforest, HERE, Mapbox, Mapy.cz, Navionics), or you'd like to combine layers
into a custom map, head to [Configuration](../configuration/index.md).
