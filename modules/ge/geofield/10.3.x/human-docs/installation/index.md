# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- The **GeoPHP** geometry library (`itamair/geophp`, `^1.6`) — Composer pulls this
  in automatically when you install Geofield the recommended way (below).

There are no dependent Drupal modules; Geofield stands on its own. Interactive
maps, geocoding, and geospatial search are provided by *optional* companion
projects you can add later — Geofield Map, Leaflet, Geocoder, and
Search API Location.

## Install with Composer

Always install Geofield with Composer so the GeoPHP library is fetched with it.
From the project root:

```bash
composer require drupal/geofield -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/geofield -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en geofield -y
```

Geofield ships **no submodules**. Once enabled, the **Geofield** field type
becomes available to add to any entity — continue with
[Configuration](../configuration/index.md).
