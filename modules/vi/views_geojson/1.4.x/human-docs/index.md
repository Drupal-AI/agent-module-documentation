# Views GeoJSON — manual setup guide

**Views GeoJSON** (`views_geojson`) provides a Views **style** that outputs a
view's rows as a GeoJSON *FeatureCollection*. In other words, it turns any list of
Drupal content that has location data into map data that Leaflet, OpenLayers,
Mapbox, and other mapping tools can consume directly — no serialization code
required. You build a normal view (filter it with the usual Views filters — status,
type, taxonomy, and so on) and choose the GeoJSON format, and the module emits each
row as a map feature.

When you configure the GeoJSON style you pick where each feature's geometry comes
from: a separate **latitude + longitude** pair of fields, a **Geofield**, a
**Geolocation** field, or a **WKT** (Well‑Known Text) field. You can also nominate
fields to become each feature's `id`, `name`, and `description`, and any other
fields you add to the display are emitted under the feature's `properties` —
handy for map pop‑ups and client‑side styling. The module ships a dedicated
**GeoJSON export** display that serves the feed at a URL (great for a decoupled
map API), but the GeoJSON style also works inside an ordinary page, block,
attachment, or REST export display.

For efficient maps over large datasets, it adds a **bounding box** contextual
filter so a map can request only the features inside its current viewport (driven
by a `bbox` query parameter). There's also a JSONP option for cross‑domain
widgets, and a `hook_geojson_view_alter()` hook so modules can enrich features
before output. Geometry conversion relies on the `itamair/geophp` PHP library,
which Composer installs for you. There is no admin settings page — everything is
configured on the view itself. The module depends on core **Views**,
**Serialization**, and **REST**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There's no dedicated settings page. You configure Views GeoJSON entirely inside
the Views UI (**Structure → Views**, `/admin/structure/views`), on the display and
style settings of the view you build.

## How to use it

**1. Build the view.** Create a view of the content that carries location data,
and filter/sort it however you like with ordinary Views handlers.

**2. Add a GeoJSON export display.** Click **Add display** and choose **GeoJSON
export**. It automatically sets its format to **GeoJSON** and its rows to fields,
and serves at the path you give it. (Alternatively, on a normal page/block display
set the format/style to **GeoJSON**.)

**3. Configure the GeoJSON style.** Open the **GeoJSON** style settings and set the
**data source** for the geometry:

- **Lat/Lon** — pick a latitude field and a longitude field.
- **Geofield** — pick a Geofield.
- **Geolocation** — pick a Geolocation field.
- **WKT** — pick a Well‑Known Text field.

Then optionally choose an **ID** field (feature `id`), a **Name** field (becomes
each feature's `name`, e.g. the title), and a **Description** field (becomes
`description`, e.g. the body). Every other field on the display is output under the
feature's `properties`. There's also a **JSONP prefix** option if you need JSONP
output for a cross‑domain widget.

**4. (Optional) Limit to the map viewport.** Under **Advanced → Contextual
filters**, add **Views GeoJSON: Bounding box**. Set its "when the filter value is
not available" behavior to **Provide default value → Query parameter** using the
`bbox` parameter. Your map's move/zoom handler then re‑fetches the GeoJSON URL with
`?bbox=<minLon>,<minLat>,<maxLon>,<maxLat>`, and only the visible features come
back — efficient for large datasets.

The output looks like a standard FeatureCollection:

```json
{
  "type": "FeatureCollection",
  "features": [
    { "type": "Feature",
      "geometry": { "type": "Point", "coordinates": [lon, lat] },
      "properties": { "name": "…", "description": "…", "id": 123 } }
  ]
}
```

Point any Leaflet/OpenLayers/Mapbox layer at the view's URL to render the features
on a map.
