# Leaflet — manual setup guide

**Leaflet** (`leaflet`) integrates the popular [Leaflet](https://leafletjs.com/)
JavaScript mapping library into Drupal, rendering interactive maps of your
location data. It builds on the [Geofield](https://www.drupal.org/project/geofield)
module: wherever you store geographic data (points, lines, or polygons) in a
Geofield, Leaflet can display it on an interactive map — with markers, popups,
layer controls, and automatic centering and zoom.

It works in three ways. A **field formatter** turns a Geofield value into a map
on the entity's display, so a node's address shows up as a real, pannable map. A
**map widget** lets editors place a marker or draw geometry visually on a map
instead of typing coordinates. And a programmatic **service** (`leaflet.service`)
renders maps from custom code for cases outside the field system. Maps themselves
are defined through a `hook_leaflet_map_info()` system where modules register
named map definitions (base layers, controls, default center and zoom); the
bundled definitions cover OpenStreetMap and other tile providers, and recent
versions also ship MapLibre GL vector‑tile support. A rich set of alter hooks
lets developers customize markers, icons, tooltips, and popups.

There is **no global settings page** — you configure maps right where you use
them: on the Geofield **formatter** (Manage display) and **widget** (Manage form
display), and through map definitions in code. Leaflet depends on the
**Geofield** module. Two submodules extend it: **Leaflet Views**
(`leaflet_views`) adds a Views style so you can map any Views result set, and
**Leaflet Markercluster** (`leaflet_markercluster`) groups dense markers into
expandable clusters. Access to advanced map configuration is gated by the
**`configure leaflet`** permission.

This guide is written for a **human** setting up maps through the admin UI. If you
want terse, token‑cheap references for an AI coding agent — including the
`leaflet.service` API and the alter hooks — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer alongside
   Geofield, enable it, and pick the submodules you need.

## Where it lives in the admin menu

Leaflet has no central settings page. You configure it on your fields:

- **Manage display** for an entity bundle (`.../display`) — set the Geofield's
  formatter to a **Leaflet** map and choose its map definition, default center,
  zoom, and height.
- **Manage form display** (`.../form-display`) — set the Geofield's widget to the
  **Leaflet** map widget so editors can place or draw geometry on a map.

The **`configure leaflet`** permission (granted at **People → Permissions**)
controls who can access the advanced map configuration.

## How to use it

1. Make sure **Geofield** is installed and you have a Geofield on the entity you
   want to map (for example an *Address* or *Location* field on a content type).
2. Under **Manage display**, set that field's format to a **Leaflet** map. Pick a
   map definition (OpenStreetMap needs no API key), and set the default center,
   zoom, and map height. Optionally configure marker icons and popup content.
3. Under **Manage form display**, set the field's widget to the **Leaflet** map
   widget if you want editors to click to place a marker or draw lines/polygons
   rather than type coordinates.
4. To map a whole list of geolocated content, enable **Leaflet Views** and choose
   the Leaflet map style on a View. To tidy up dense maps, enable **Leaflet
   Markercluster** to group nearby markers into expandable clusters.

Typical uses include store locators, event‑venue maps, real‑estate listings with
custom marker icons, route/track polylines, and coverage‑area or delivery‑zone
polygons. Developers can also render maps entirely from code with
`leaflet.service` and customize output through the alter hooks.
