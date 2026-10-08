<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mapping OSM Nodes with Views + Leaflet

## What this submodule does

Nothing at runtime beyond forcing its dependencies. `openstreetmap_views.info.yml` declares
`dependencies: [openstreetmap, leaflet]`, so enabling it installs the **leaflet** contrib module if
it is not already present. There is no code, config, or plugin in this submodule — do not look for
custom Views handlers here; the parent's `OSMNodeViewsData` already exposes `osm_node` to Views.

## Install & enable

```bash
composer require drupal/leaflet   # if not already present; this submodule depends on it
drush en openstreetmap_views -y   # enables openstreetmap + leaflet as deps
```

## Build the map (from the project README FAQ)

1. Ensure the parent module is configured (OSM Settings endpoint) and you have imported/synced some
   `osm_node` entities with populated `geodata`.
2. Enable **Leaflet** and **Leaflet Views** (submodule of leaflet).
3. Create a new **View** of *OSM Node* entities.
4. Add the **Geodata** field (base field `geodata`, a Geofield) to the View.
5. Set the View's display/style to **Leaflet** and configure it to read geodata from the Geodata
   field.
6. Save. The map renders every OSM Node matching the View — points for nodes, polygons for ways.

## Notes

- Tile rendering, marker layers, and any client-side map assets are provided by **Leaflet**, not by
  this project. Leaflet loads its own tiles/library client-side (the browser fetches map tiles); that
  is Leaflet's configuration, not OpenStreetMap's.
- Because this submodule is a pure dependency shim, you can equally skip it and just enable
  `leaflet` yourself; enabling `openstreetmap_views` only documents and enforces that choice.
