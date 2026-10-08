Views GeoJSON provides a Views style plugin that outputs a view's rows as a GeoJSON FeatureCollection, so you can expose Drupal content as map data for Leaflet, OpenLayers, Mapbox and other mapping tools.

---

The module adds a Views **style** plugin `geojson` (`display_types = {"data"}`) that serializes
each result row into a GeoJSON `Feature` and the whole result set into a `FeatureCollection`.
In the style settings you pick the **data source** for each feature's geometry: `latlon` (a
latitude field + a longitude field), `geofield`, `geolocation`, or `wkt` (a WKT field) — plus
optional **id**, **name** and **description** fields, and any remaining fields are emitted as
feature `properties`. It ships a dedicated **GeoJSON export** display (`geojson_export`,
extending core `RestExport`) that defaults its style to `geojson` and returns a proper response
at a route, and it also works inside a normal page/block/attachment display or a REST export.
For map viewports it adds a **bounding box** contextual filter (`views_geojson_bbox_argument`)
and a matching argument-default plugin (`BBoxQuery`) that reads a `bbox` query parameter, so a
map can request only the features within the current view. A `jsonp_prefix` option supports
JSONP, and `hook_geojson_view_alter()` lets modules alter the features array before output.
Geometry conversion uses the `itamair/geophp` library. There is no admin settings page —
everything is configured on the view.

---

- Publish nodes with a location field as a GeoJSON feed for a Leaflet map.
- Serve points from a Geofield as a FeatureCollection to a mapping front end.
- Expose latitude/longitude fields as map markers without writing serialization code.
- Output WKT geometries (polygons, lines) as GeoJSON features.
- Provide a decoupled GeoJSON API endpoint via the GeoJSON export display.
- Feed store locations to a "find a branch near me" map.
- Drive a real-estate listings map from a View of property nodes.
- Return only the features inside the current map viewport using the bbox argument.
- Wire a Leaflet map's move/zoom to a `bbox` query parameter for efficient loading.
- Include each feature's title as its GeoJSON `name` and body as `description`.
- Emit selected Views fields as GeoJSON feature `properties` for popups/styling.
- Set a stable feature `id` from a node id field.
- Serve event locations as GeoJSON for a map of upcoming events.
- Combine with Leaflet/Mapbox modules that consume a GeoJSON URL.
- Provide JSONP output for cross-domain map widgets via the jsonp_prefix option.
- Alter or enrich features before output with hook_geojson_view_alter().
- Export sensor/asset positions as GeoJSON for an operations dashboard.
- Publish points of interest for a tourism map as open GeoJSON data.
- Filter the feed with normal Views filters (published, type, taxonomy) then output GeoJSON.
- Back an OpenLayers vector layer with a Drupal-managed GeoJSON source.
- Aggregate multiple content types with location data into one GeoJSON feed.
- Provide contextual, argument-driven GeoJSON (e.g. features for one region).
