# Leaflet MapTiler — manual setup guide

**Leaflet MapTiler** (`leaflet_maptiler`) lets Drupal's Leaflet maps use
**MapTiler** map styles and tiles. Leaflet is agnostic about where its tiles come
from; this module wires in MapTiler as the provider, so your maps can use
MapTiler's basemaps and styles rather than the default OpenStreetMap tiles. You
select the MapTiler map when you format a single field (such as a Geofield) as a
map, or when you format a View of nodes or users as a map.

MapTiler requires an **API key**, and the module ships a small submodule —
**Leaflet MapTiler Token** (`leaflet_maptiler_token`) — that provides a token so
you can render a map with a Drupal **token** (for example inside rich text)
without needing an iframe. That token takes the form
`[maptiler:lat_lng_zoom_height:+++]`, where the four `+`‑separated values are
latitude, longitude, zoom, and height in pixels.

Leaflet MapTiler depends on the **Leaflet** module and provides its own
permission. The key point to keep in mind is that the MapTiler **API token is a
credential** and map tiles are loaded **from MapTiler** by the visitor's browser
(a third‑party request) — so treat the token as a secret and be aware of the
outbound calls.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optionally enable the token submodule.
2. [Configuration](configuration/index.md) — enter your MapTiler API key, choose
   layers, and handle the token safely.

## Where it lives in the admin menu

Once enabled, configure MapTiler at **`/admin/config/leaflet_maptiler`**, where
you enter your API key and choose the layers. You then use the MapTiler map by
selecting it when formatting a field or a View as a Leaflet map.
