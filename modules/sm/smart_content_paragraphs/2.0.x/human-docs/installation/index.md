# Installation

## Requirements

- **Drupal 9.4 or 10** (`core_version_requirement: ^9.4 || ^10`).
- **Smart Content** (`smart_content`).
- **Paragraphs** (`paragraphs`) and **Paragraphs Library** (`paragraphs_library`).
- **Geocoder** (`geocoder`) — the region-based geolocation conditions geocode
  addresses server-side via the Google Maps geocoder, so you'll need a Google Maps
  API key configured on the geocoder provider.

The module's own documentation notes that Smart Content Segments may require a
patch on some versions; check the module's issue queue if segment authoring
misbehaves.

## Install with Composer

From the project root:

```bash
composer require drupal/smart_content_paragraphs -W
```

The Composer package name (`drupal/smart_content_paragraphs`) matches the module's
machine name (`smart_content_paragraphs`). The `-W` (`--with-all-dependencies`)
flag lets Composer install Smart Content, Paragraphs, Paragraphs Library and
Geocoder and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/smart_content_paragraphs -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en smart_content_paragraphs -y
```

The condition types are provided by sub-submodules — `pce_device`,
`pce_geolocation`, `pce_geobrowser`, `pce_node` and `pce_cookie`. Enable the ones
whose conditions you plan to use, for example:

```bash
drush en pce_device pce_geolocation -y
```

## Next step

Before building variations, configure the geolocation HTTP header (if you'll use
region conditions) and create your Smart Segments — see
[Configuration](../configuration/index.md).
