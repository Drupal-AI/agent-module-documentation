# Leaflet OpenFreeMap — manual setup guide

**Leaflet OpenFreeMap** (`leaflet_openfreemap`) adds **OpenFreeMap** vector‑tile
basemaps as an option for Drupal's Leaflet maps. OpenFreeMap is a fully
open‑source, free‑to‑use tile service that requires **no API key and no external
account** — which makes this the simplest way to give your Leaflet maps a proper,
production‑friendly basemap without signing up for a commercial provider or
worrying about per‑map‑load billing.

It ships three map styles: **Liberty** (the full‑detail default, recommended),
**Positron** (an ultra‑clean, minimal style), and **Bright** (a high‑contrast
style). The tiles are rendered through MapLibre GL via the `leaflet-maplibre-gl`
plugin, which is bundled with the Leaflet contrib module — so there is nothing
extra to download and nothing to configure. Once enabled, the three styles simply
appear in any Leaflet map selector.

Leaflet OpenFreeMap is a tile‑provider add‑on and nothing more: it has no content
type, no settings, and no access‑control role of its own. It depends only on the
Leaflet module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — enable the module (no API key or
   account needed).

There is **no configuration page** for this module and nothing to set up — see
"How to use it" below.

## Where it lives in the admin menu

Leaflet OpenFreeMap adds no admin page. Its styles appear wherever you already
choose a Leaflet map — for example a Leaflet field formatter or a Geofield map
widget.

## How to use it

1. Make sure the **Leaflet** module (10.x) is installed, including its bundled
   MapLibre GL / `leaflet-maplibre-gl` libraries.
2. Enable Leaflet OpenFreeMap. No API key or external account is required.
3. Anywhere you configure a Leaflet map — a formatter on a Geofield, a map
   widget, a Leaflet Views display — open the **map style dropdown** and pick one
   of the OpenFreeMap options: **Liberty**, **Positron**, or **Bright**.
4. Save, and your map renders on OpenFreeMap tiles.
