# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **`spatie/data-transfer-object`** PHP library, used to shape the OSM
  results. It's installed automatically by Composer when you require the module.
- Outbound HTTP access to an Overpass API endpoint (the public instance by
  default, or one you configure).

There are no contributed module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/overpass_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the
`spatie/data-transfer-object` library alongside the module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/overpass_api -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en overpass_api -y
```

## Verify it worked

Visit `/admin/config/system/overpass-api` to confirm the settings form is
available (see [Configuration](../configuration/index.md)). To confirm the service
works end‑to‑end, call `\Drupal::service('overpass_api')->query(...)` from custom
code (or a quick `drush php:eval`) with a small Overpass QL query and check that it
returns an array of OSM elements.
