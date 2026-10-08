# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- **PHP 7 or newer** (`php: >= 7`).
- Core's **Views** (`views`), **Serialization** (`serialization`), and **REST**
  (`rest`) modules — Drupal enables these as dependencies.
- The **`itamair/geophp`** PHP library (`^1.3`), which handles geometry conversion.
  Composer installs it for you when you require the module — which is why you should
  install this module **with Composer** rather than downloading the archive.

## Install with Composer

From the project root:

```bash
composer require drupal/views_geojson -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update the
required `itamair/geophp` library and any other shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_geojson -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_geojson -y
```

Enabling Views GeoJSON also enables core Views, Serialization, and REST if they
aren't already on. There is no settings page — the **GeoJSON** style and **GeoJSON
export** display become available inside the Views UI. See the
[overview](../index.md#how-to-use-it) for building a GeoJSON feed.
