# Yandex.Maps — manual setup guide

**Yandex.Maps** (`yandex_maps`) brings the Yandex.Maps JavaScript API (version 2.1)
into Drupal. It gives you three things: a reusable `yandex_map` render/form element
for custom code, a **geofield widget and formatter** so editors can place and
display map geometry on entities, and a **Views style** that plots many entities'
locations on a single interactive map with clustering and pop‑up balloons.

Editors can click a map to drop a marker, or draw lines and polygons, and the
geometry is stored as standard WKT in a geofield — which means the same data can be
reused by other geospatial tools. On the display side you can show a single
entity's location, or use the Views map style to render a whole result set as a map:
markers can be clustered when there are many of them, each marker can show a tooltip
(hint) and open a balloon containing the rendered Views row, and marker icons can be
styled with Yandex presets. Map type (roadmap, satellite, hybrid, public transit),
centre, zoom, visible controls, and behaviours (drag, scroll‑zoom) are all
configurable per map.

Because it talks to Yandex's servers, the module needs a **Yandex.Maps API key**,
which you enter on its settings page. This is a public, browser‑side key (it appears
in the page's JavaScript), so it is not a server secret — but you should still store
it as configuration and keep it tied to your domain in the Yandex developer console.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, add the required
   geofield module, and enable the module (and the examples submodule).
2. [Configuration](configuration/index.md) — the global settings page (API key,
   presets, default marker, debug) and the per‑display widget, formatter, and Views
   options.

## Where it lives in the admin menu

The global settings form is at **Configuration → System → Yandex.Maps**
(`/admin/config/system/yandex-maps`). The map widget, formatter, and Views style
are configured where you would expect them: on a geofield's **Manage form
display** / **Manage display** tabs, and in a View's **Format** settings.

## How to use it

1. Enter your **API key** on the settings page (see [Configuration](configuration/index.md)).
2. Add a **geofield** field to a content type (this needs the separate
   [Geofield](https://www.drupal.org/project/geofield) module — see
   [Installation](installation/index.md)).
3. On **Manage form display**, set that field's widget to the Yandex map widget so
   editors can draw points, lines, or polygons on a map.
4. On **Manage display**, set the field's formatter to the Yandex map formatter to
   show the saved geometry on a map. Optionally set hint/balloon content, which
   supports token replacement.
5. To plot many entities at once, build a View, add the geofield, and choose the
   **Yandex map** display format, then map its per‑row options (marker id, hint,
   icon, cluster caption, preset).

The bundled **Yandex.Maps examples** submodule (`yandex_maps_examples`) provides
demo pages and forms that show the render element, clustering, and form usage — a
good way to learn the API before wiring up your own maps.
