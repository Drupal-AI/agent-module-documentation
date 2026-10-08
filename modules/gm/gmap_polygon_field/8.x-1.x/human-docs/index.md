# GMap Polygon Field — manual setup guide

**GMap Polygon Field** (`gmap_polygon_field`) adds a new field type that lets
editors **draw one or more polygons on an embedded Google Map** and stores the
resulting shape alongside a content item. It is the tool to reach for when you need
someone to mark out an *area* rather than a single point — a delivery or service
zone, a land parcel, a venue catchment, a sales territory, or any editor-drawn
region.

The field comes with three parts: a **field type** that stores the geometry (in
Google's polyline format), a **widget** built on the Google Maps drawing tools for
creating and editing polygons, and a **formatter** that renders the map with the
shape drawn on it. Editors click to add vertices, drag points to move them, click a
side to insert a new vertex, right-click a vertex to delete it, and can undo the
last move — all directly on the map.

Because the map is drawn with the **Google Maps JavaScript API**, the module needs
a valid Google Maps API key (with the Maps JavaScript and Drawing libraries
enabled) before any map will render. You set that key, and the polygon's
appearance, on the module's settings page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the Google Maps API key and tune
   the polygon's appearance.

## Where it lives in the admin menu

The settings page is at **Configuration → Content authoring → GMap Polygon Field**
(`/admin/config/content/gmap_polygon_field`, route `gmap_polygon_field.settings`),
reached with the *Administer GMap Polygon Field* permission. A bundled example page
at `/examples/gmap_polygon_field` lets you try the field.

## How to use it

After setting the API key, add a **GMap polygon** field to any content type (or
other fieldable entity) under **Structure → Content types → *(type)* → Manage
fields**. On **Manage form display** the drawing widget lets editors sketch the
area; on **Manage display** the formatter shows the map with the polygon rendered.
