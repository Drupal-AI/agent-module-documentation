# Alimap — manual setup guide

**Alimap** (`alimap`) puts maps on your site using **AMap** (Gaode / 高德地图),
the mapping service that is standard inside mainland China. It is the alternative
you reach for when Google Maps is blocked or unavailable — it loads AMap's
JavaScript and lets you display coordinate points and polygon shapes on a map.

The module adds a settings form where an administrator stores the AMap **API key**
and **security (jscode) key**, plus default map options: map dimensions, zoom
level, standard-or-satellite base layer, a named colour theme (dark, light,
macaron, blue, and more), and toggles for on-map controls such as the toolbar,
place search, scale, control bar, geolocation, and hawkeye overview.

For placing map data on your content, the project also provides field types:
`alimap_field` for basic coordinate points, and `alimap_polygon_field` for lines,
polygons, dashed lines, and circles. Add one of these fields to an entity (such as
a content type) to capture and render map data on that entity.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter your AMap keys and set the map
   defaults.

## Where it lives in the admin menu

The settings form is at **Configuration → Web services → Alimap**
(`/admin/config/services/alimap`), gated by the core **Administer site
configuration** permission. There are no custom routes or web-service endpoints
beyond this admin form.

## How to use it

1. Get an AMap key and security key (see [Configuration](configuration/index.md)).
2. Enter them on the settings form and choose your default map appearance.
3. Add an `alimap_field` (points) or `alimap_polygon_field` (lines/polygons/
   circles) to an entity, then enter map data on that entity to render a map in
   its display.
