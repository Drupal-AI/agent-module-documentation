# Geolocation Leaflet GeoJSON — manual setup guide

**Geolocation Leaflet GeoJSON** (`geolocation_leaflet_geojson`) is a very small
add‑on that lets you overlay a **GeoJSON layer** on the **Leaflet** maps produced
by the **Geolocation** module. If you're already rendering a Leaflet map of
locations and you want to draw boundaries, routes, catchment areas, or other
custom shapes on top of it, this module adds that capability as an extra map
feature.

It's purely a display/mapping helper. The GeoJSON source is supplied by a site
builder or developer — it isn't driven by anonymous visitor input — and the
module has no access‑control role of its own. Because it renders through Leaflet,
map tiles are loaded from whatever tile provider your Geolocation Leaflet setup
uses; be aware that this means map tiles come from a third‑party service in the
visitor's browser.

It depends on the **Geolocation** (`geolocation`) module and its **Geolocation
Leaflet** (`geolocation_leaflet`) submodule.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Geolocation Leaflet dependencies.

There is **no configuration page** for this module. You enable the GeoJSON layer
as a map feature where you already configure a Leaflet map — described in "How to
use it" below.

## Where it lives in the admin menu

The module adds no admin settings page of its own. It surfaces as an extra
**map feature/layer option** wherever you configure a Geolocation Leaflet map —
on a geofield/geolocation‑field formatter or in a Geolocation Views map style.

## How to use it

1. Make sure you already have a working **Geolocation Leaflet** map — for example
   a geolocation field displayed with a Leaflet formatter, or a Views display
   using a Geolocation Leaflet map style.
2. In that map's settings, enable the **GeoJSON layer** feature this module adds.
3. Point it at your GeoJSON source (the boundaries, routes, or shapes you want to
   overlay), as provided by your site build.
4. Save. The Leaflet map now renders your GeoJSON data as an overlay on top of the
   base map.
