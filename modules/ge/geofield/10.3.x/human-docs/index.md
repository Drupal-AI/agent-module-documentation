# Geofield — manual setup guide

**Geofield** (`geofield`) adds a field type for storing geographic data —
points, lines, polygons, and multi-geometries — on any entity (nodes, users,
taxonomy terms, and so on). It keeps the raw geometry as Well-Known Text (WKT)
and, from that, derives handy columns you can query: centroid latitude/longitude,
a bounding box, a geometry type, and a geohash.

Once you've attached a Geofield to a content type, editors can enter coordinates
in whichever way suits them: a raw WKT textarea, a plain **Latitude/Longitude**
pair (optionally pre-filled from the browser's HTML5 geolocation), a
**Degrees-Minutes-Seconds** widget, or a **bounding-box** widget. Every value is
normalized through the GeoPHP library into a canonical geometry before it's
stored, so your data stays consistent no matter how it was entered. Two built-in
formatters render the stored value back out as raw geometry text or as a
formatted lat/lon pair.

Geofield also brings Views integration for **proximity** — distance filters,
sorts, arguments, and fields for "find locations near me" listings, plus
rectangular boundary filters. The origin point for those proximity queries comes
from pluggable sources (a manually entered origin, the visitor's browser
location, context, or another filter). Under the hood it exposes reusable
services (a WKT generator, a DMS↔decimal converter) and a JSON:API enhancer that
emits GeoJSON for decoupled front ends.

Importantly, Geofield on its own only **stores and displays** coordinates as
text — it does not draw interactive maps. It is the foundation that mapping
modules build on. To show a real map, pair it with a contrib module such as
**Geofield Map** or **Leaflet**; to turn addresses into coordinates, add
**Geocoder**; for geospatial search, add **Search API Location**. Geofield
depends on the GeoPHP PHP library (`itamair/geophp`) and ships no submodules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add a Geofield to a content type and
   choose its widget and formatter, field by field.

## Where it lives in the admin menu

Geofield has **no module-wide settings page** — everything is configured
per field on the entity you attach it to. You add and set up a Geofield under
**Structure → Content types → *(your type)* → Manage fields**
(`/admin/structure/types/manage/<bundle>/fields`), then pick how editors enter it
under **Manage form display** and how it renders under **Manage display**. See
[Configuration](configuration/index.md) for the full walkthrough.
