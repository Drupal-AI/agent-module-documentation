# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Geolocation** module (`geolocation`) — including its Leaflet map support,
  since this centers a Leaflet map.
- Core **Views** (`views`), which is where you build the map display this module
  acts on.

There are no third‑party Composer or PHP library requirements. Leaflet loads map
tiles from a third‑party tile provider in the visitor's browser.

## Install with Composer

From the project root:

```bash
composer require drupal/geolocation_leafletcenternode -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Geolocation and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/geolocation_leafletcenternode -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en geolocation_leafletcenternode -y
```

Drupal will enable `geolocation` and `views` alongside it if they aren't already
on.

## Verify it worked

Open (or create) a View with a Geolocation Leaflet / CommonMap display shown in a
node context. In the map display's settings you should see the new option to
center the map on the current node's location. Enable it, place the View's block
on a node page, and confirm the map opens centered on that node while still
showing the other locations.
