# Installation

## Requirements

- **Drupal 8.7.7, 9, 10, or 11** (`core_version_requirement:
  ^8.7.7 || ^9 || ^10 || ^11`).
- The **Geofield** module (`geofield`) — the required dependency; it provides the
  geographic field that stores each feature's location (the Geodata field).
- An **Overpass interpreter URL** — a public or self-hosted Overpass API endpoint.
  You enter this during [configuration](../configuration/index.md); a list of
  public endpoints is on the
  [Overpass API wiki](https://wiki.openstreetmap.org/wiki/Overpass_API).
- **Optional but recommended:** a mapping module such as
  [Leaflet](https://www.drupal.org/project/leaflet) (with Leaflet Views) to
  display the synced features on a map.

## Install with Composer

From the project root:

```bash
composer require drupal/openstreetmap -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. You may also need `composer require drupal/geofield` if
Composer does not pull the Geofield dependency in automatically.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/openstreetmap -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en openstreetmap -y
```

## Submodules — enable what you need

OpenStreetMap ships two optional submodules. Enable them individually with
`drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **OpenStreetMap Query Tools** | `openstreetmap_queries` | The ability to define and run **Overpass queries** that import groups of matching OSM features into a node type. Required if you want to sync more than a handful of individually-added features. |
| **OpenStreetMap Views** | `openstreetmap_views` | Views integration for listing and displaying your synced OSM features. |

For example, to enable the Overpass query tools:

```bash
drush en openstreetmap_queries -y
```

## Verify it worked

Go to **Configuration → OSM Settings** (`/admin/config/osm`) and confirm the
settings form appears so you can enter your Overpass interpreter URL — see
[Configuration](../configuration/index.md) for the full setup, including creating
an OSM node type and importing your first feature.
