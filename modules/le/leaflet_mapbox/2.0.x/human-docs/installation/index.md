# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Leaflet** module — the only dependency.
- A **Mapbox account** with a published style and an access token (see
  Configuration).

There are no third‑party Composer or PHP library requirements of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/leaflet_mapbox -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Leaflet
dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/leaflet_mapbox -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en leaflet_mapbox -y
```

This enables the Leaflet dependency if it is not already on.

## Verify it worked

Go to **Configuration → Web Services → Leaflet MapBox** and confirm the settings
form loads. After you add a Mapbox style with its Style URL and access token (see
[Configuration](../configuration/index.md)), create or edit a Leaflet View or
formatter and confirm your new Mapbox style is offered as a map choice.
