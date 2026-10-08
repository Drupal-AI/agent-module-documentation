# OpenLayers 6 — manual setup guide

**OpenLayers 6** (`openlayers6`) renders your geographic field data on interactive
maps using the [OpenLayers 6](https://openlayers.org/) JavaScript mapping library —
an open-source alternative to Google Maps and Leaflet. It plugs into the
[Geofield](https://www.drupal.org/project/geofield) module: wherever you store
locations (points and geometries) in a geofield, OpenLayers 6 can draw them on a
map.

It offers two ways to show that data. The first is a **field renderer**: on a
content type's *Manage display*, format a geofield with OpenLayers 6 and each
entity's location appears as a marker on a map, with control over marker size,
zoom, and an initial position. The second is a **store locator** block — a Drupal
block plugin you can place anywhere, driven by a Views REST export data source,
that shows many markers at once with optional clustering and marker popups (a
popup's content is any node display mode, such as its teaser). If you also install
Search API and Facets, the store locator can be filtered by a search box and
facets.

Because it draws map tiles from an open map provider (OpenStreetMap by default),
the visitor's browser fetches those tiles from a third‑party tile server — worth
noting for privacy notices and for sites that lock down outbound requests. The
module has no access-control role of its own: it renders whatever geofield data
the visitor is already allowed to see, and respects that field's access.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Geofield dependency.

There is **no central settings page** for this module. You configure it per
field on *Manage display*, or per block when you place the store locator —
described in "How to use it" below.

## Where it lives in the admin menu

OpenLayers 6 adds no admin configuration page. You use it entirely from:

- **Structure → Content types → *(type)* → Manage display** — to format a
  geofield as an OpenLayers 6 map.
- **Structure → Block layout** (`/admin/structure/block`) — to place the store
  locator block.

## How to use it

**As a field renderer:**

1. Add a **Geofield** field to a content type (this needs the Geofield module,
   installed as a dependency) and give some content location values.
2. Go to that content type's **Manage display**, find the geofield, and set its
   **Format** to the OpenLayers 6 renderer.
3. Open the format's settings (the gear icon) to choose the base layer and set the
   initial zoom and position.

**As a store locator block:**

1. Build a **View** that exposes your located content as a **REST export** data
   source (the store locator reads from it).
2. Go to **Structure → Block layout**, place the store locator block in a region,
   and point it at that data source.
3. Optionally enable **clustering** to group nearby markers, and configure marker
   **popups** to show a node display (for example the teaser). If you have Search
   API and Facets installed, add a search box and facet filters to narrow the
   markers shown.
