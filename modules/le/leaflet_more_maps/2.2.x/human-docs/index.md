# Leaflet More Maps — manual setup guide

**Leaflet More Maps** (`leaflet_more_maps`) adds 40-plus ready-made map styles to
the [Leaflet](https://www.drupal.org/project/leaflet) module. Out of the box
Leaflet gives you the standard OpenStreetMap look; this module bolts on a whole
catalogue of alternative basemaps — Bing road/satellite/hybrid, Esri (World
Imagery, National Geographic, Topo, Ocean, and more), Google (satellite, roadmap,
hybrid, retina), Mapbox, Mapy.cz, the nine Thunderforest OSM styles, OpenTopoMap,
the Stamen family (Toner, Terrain, Watercolor), HERE, and Navionics nautical
charts.

Once installed, these styles simply appear in the map-style dropdown wherever
Leaflet already offers one — for example a Geofield formatted as a Leaflet map, or
a View rendered with the Leaflet Views style. You don't write any code: you pick a
style from the list.

Some providers need an API key or access token before their tiles will load
(Thunderforest, HERE, Mapbox, Mapy.cz, Navionics), and there's a single settings
form where you enter those. That same form lets you build up to three **custom
maps** — combining several layers from the catalogue into one map with an
automatic layer switcher — again without any code. A companion submodule, **Leaflet
Demo** (`leaflet_demo`), renders every available style on a single page so you can
preview them and confirm your keys work.

The module requires the Leaflet module and works on Drupal 8.8 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the full list of
map keys and their zoom ranges — read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and the optional demo submodule.
2. [Configuration](configuration/index.md) — the settings form: provider API keys,
   custom maps, and using a style on a map.

## Where it lives in the admin menu

The settings form sits at **Configuration → System → Leaflet More Maps**
(`/admin/config/system/leaflet-more-maps`).

## How to use it

1. Enable the module. The extra styles are immediately available in any Leaflet
   map-style dropdown.
2. If you want a style from a provider that needs a key (Thunderforest, HERE,
   Mapbox, Mapy.cz, or Navionics), enter it on the settings form — see
   [Configuration](configuration/index.md).
3. Pick a style: on a Geofield's *Manage display* Leaflet formatter, or in a
   Leaflet Views style, choose your new basemap from the **map** dropdown.
4. After any settings change, clear caches (`drush cr`) so the map list refreshes.
