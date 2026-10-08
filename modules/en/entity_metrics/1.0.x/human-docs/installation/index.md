# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **GeoIP Autoupdate** module (`geoip_autoupdate`) — downloads and refreshes the
  local MaxMind GeoLite2 database that the geolocation features read. Composer
  installs it automatically when you require Entity Metrics.
- Core **Node**.
- Composer also pulls the `maxmind-db/reader` PHP library for reading the local
  database. The map block uses Leaflet from a CDN.

> **Heads-up:** this is a **beta** release.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_metrics -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install `geoip_autoupdate`
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_metrics -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_metrics -y
drush updb -y
drush cr
```

Drupal enables `geoip_autoupdate` at the same time if it isn't already on. The
install step creates the module's `entity_metrics_data` and `entity_metrics_regions`
database tables.

## Set up geolocation (optional)

The map and region features read a **local** MaxMind GeoLite2-**City** database — no
visitor IP is sent to a remote service, and Entity Metrics holds no geolocation
credential of its own. Configure the **GeoIP Autoupdate** module to download a
GeoLite2-City database (its own settings page holds any MaxMind account details).
Once that database is present, Entity Metrics reads it locally.

If you don't need the geolocation features, view/download counting still works
without the database.

## Verify it worked

Confirm the module is enabled (`drush pml --status=enabled | grep entity_metrics`).
View some content and download a file, then check that view/download counts begin
accumulating for those entities (for example through the module's view-count block).
