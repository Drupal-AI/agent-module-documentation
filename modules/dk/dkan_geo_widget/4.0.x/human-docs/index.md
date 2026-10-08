# DKAN Geo Widget — manual setup guide

**DKAN Geo Widget** (`dkan_geo_widget`) gives data authors a map‑based editor for
the spatial properties of a DKAN dataset. Instead of hand‑writing GeoJSON into a
plain textarea, editors draw markers, polygons and rectangles on an interactive
**Leaflet** map (with **Geoman** drawing controls), and the geometry is saved as
GeoJSON into the underlying schema field. It restores the map‑drawing experience
that DKAN had on Drupal 7 through the old Leaflet Widget, now for Drupal 10 and
11.

Under the hood it registers a `dkan_geo_widget` form element — a Leaflet + Geoman
map wrapped around a textarea — and decorates DKAN's JSON Form Widget routers so
that a schema property flagged with the widget renders the map instead of a
textarea. The Leaflet and Geoman assets ship with the module (bundled in its
`dist/` directory), so no external CDN is needed.

It's an editorial widget only: no routes, no permissions, no server endpoints — it
swaps a form widget and serializes the drawn geometry client‑side into the
existing field. Setup is a two‑step affair: enable the module, then point a schema
property at the widget in your dataset's UI schema (a `.ui.json` file).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside DKAN and the JSON Form Widget.

There is **no settings form** — you activate the widget by editing your dataset's
UI schema, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin page. It takes effect on DKAN's JSON‑schema‑generated
metadata forms once you assign the widget to a property in the UI schema.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Edit your dataset UI schema — typically `dataset.ui.json` — and set the widget
   key for the property you want to edit on a map. For the `spatial` property, for
   example, use `dkan_geo_widget` as the widget in that property's
   `ui:options`.
3. Optionally provide a title and description for the map via the same UI options.
4. Now, when an editor opens the dataset form, that property renders as an
   interactive Leaflet map. They draw the location or region, and the geometry is
   saved as GeoJSON into the field. The same works within DKAN group forms.
