# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Geofield** module (`drupal/geofield` `^1.31 || ^10.3`) — a hard
  dependency, since Leaflet maps Geofield data. Composer pulls it in for you.
- The Leaflet JavaScript library (and MapLibre GL for vector tiles) is bundled
  with the module, so there's no separate library download to place under
  `/libraries`.

## Install with Composer

From the project root:

```bash
composer require drupal/leaflet -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Geofield and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/leaflet -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en leaflet -y
```

Drupal enables **Geofield** automatically as a dependency. From here, configure
the Leaflet formatter and widget on your Geofield — see the
[overview](../index.md#how-to-use-it).

## Grant the permission

Advanced map configuration is gated by the **`configure leaflet`** permission.
Grant it at **People → Permissions** (`/admin/people/permissions`) to the roles
that should be able to configure Leaflet maps.

## Submodules — enable only what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Leaflet Views** | `leaflet_views` | A Views style, row, and attachment display so you can render any Views result set of geolocated content as a Leaflet map. |
| **Leaflet Markercluster** | `leaflet_markercluster` | Groups dense markers into expandable clusters, keeping busy maps readable. |

Enable them individually as needed:

```bash
drush en leaflet_views -y
drush en leaflet_markercluster -y
```

Each requires the base Leaflet module, which is already present once you've
installed it above.
