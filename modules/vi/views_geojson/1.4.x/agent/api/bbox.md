# Bounding box (map viewport) filtering

Views GeoJSON adds a **Bounding box** contextual filter so a map can request only the features
inside its current viewport, instead of downloading every feature.

## The argument

`hook_views_data()` exposes `views.views_geojson_bbox_argument` (group "Views GeoJSON",
title "Bounding box"). Add it as a **contextual filter** on your GeoJSON display:

- Views UI → **Advanced → Contextual filters → Add → "Views GeoJSON: Bounding box"**.
- It limits results to those within a geospatial bounding box (works well with a Leaflet map
  layer that updates the bbox as the user pans/zooms).

## Providing the bbox value automatically

Use the argument-default plugin **`BBoxQuery`** (extends core `QueryParameter`) so the argument
is taken from a **`bbox` query parameter** on the request:

- On the contextual filter, set *When the filter value is NOT available* → **Provide default
  value → Query parameter**, using the `bbox` parameter (this is what `BBoxQuery` reads).
- The client requests e.g. `?bbox=<minLon>,<minLat>,<maxLon>,<maxLat>` and the view returns
  only features in that box.

## Typical Leaflet wiring

1. GeoJSON export display with the bounding-box contextual filter, defaulting from the `bbox`
   query parameter.
2. The map's `moveend`/`zoomend` handler re-fetches the GeoJSON URL with the current map bounds
   as `bbox`.
3. Only the visible features are returned each time — efficient for large datasets.
