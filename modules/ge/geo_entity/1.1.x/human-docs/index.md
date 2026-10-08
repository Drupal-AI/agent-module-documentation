# Geo Entity — manual setup guide

**Geo Entity** (`geo_entity`) gives your site a dedicated, reusable content entity
for storing geographic information — points, addresses, and areas. Instead of
copying the same address or coordinates onto dozens of nodes, you create a location
**once** as a Geo entity and reference it from as many other entities as you like.

Geo entities are first-class content: they're revisionable, translatable, and
fieldable, so each location gets its own view/edit/delete pages and can carry extra
fields (opening hours, capacity, images) via the normal Field UI. You define
**bundles** ("geo types") whose labels are generated automatically from a token
pattern, so editors don't hand-type titles. A preconfigured **Entity Browser**
library lets editors search and reuse existing locations through a reference-field
popup — turning your stored geos into a shared "location library."

Out of the box it's wired for OpenStreetMap tiles (via Leaflet) and the
OSM/Nominatim geocoder, both swappable for commercial providers. Geocoding itself
is delegated to the Geocoder module and switched on per bundle by three submodules:
**geo_entity_address** (a point + postal-address bundle with geocoding
autocomplete), **geo_entity_area** (a polygon/area bundle from geo files), and
**geo_entity_tz** (fills a Time Zone field from coordinates via GeoNames).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it has several
   contrib dependencies), enable it, and pick the submodules you need.
2. [Configuration](configuration/index.md) — create geo types, use the token label,
   set up fields and the reuse library, and manage permissions.

## Where it lives in the admin menu

- **Content → Geo** (`/admin/content/geo`) — where you create and manage individual
  geo entities.
- **Structure → Geo types** (`/admin/structure/geo_types`) — where you define and
  configure bundles (this is the module's `configure` route).

## How to use it

Enable the module (plus the address and/or area submodule for concrete,
ready-to-use bundles), create or review your geo types, then add locations under
*Content → Geo*. On any entity that should point at a location, add an entity
reference field to Geo entities and choose the Entity Browser widget so editors can
reuse existing geos. See [Configuration](configuration/index.md) for the details —
and note the default that anonymous users can **view** geos.
