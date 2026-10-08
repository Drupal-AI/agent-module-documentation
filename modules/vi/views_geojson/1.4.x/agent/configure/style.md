# Configuring GeoJSON output

## Quick start (GeoJSON export display)

1. Create a View of the content that has location data.
2. **Add display → "GeoJSON export"** (`geojson_export`). It defaults its **Format/style** to
   **GeoJSON** (`geojson`) and its row plugin to fields, and serves at the path you set.
3. Open the **GeoJSON** style settings and configure the data source (below).

You can also add the **GeoJSON** style to a normal page/block/attachment or a REST export
display — the style plugin id is `geojson`.

## Style settings — data source

Pick where each feature's geometry comes from via `data_source.value`:

| `data_source.value` | Extra fields to select |
|---|---|
| `latlon` | `latitude` field + `longitude` field |
| `geofield` | a `geofield` field |
| `geolocation` | a `geolocation` field |
| `wkt` | a `wkt` (Well-Known Text) field |

Plus, for every feature:

- `id_field` — a field used as the GeoJSON feature `id`.
- `name_field` — becomes the feature's `name` property (e.g. the title).
- `description_field` — becomes the feature's `description` property (e.g. the body).
- **All other Views fields** on the display are emitted under the feature's `properties`
  (useful for popups and client-side styling).

Other style options: `attributes` (extra attributes) and `jsonp_prefix` (set to wrap the
output as JSONP for cross-domain widgets).

## Output shape

```json
{
  "type": "FeatureCollection",
  "features": [
    { "type": "Feature",
      "geometry": { "type": "Point", "coordinates": [lon, lat] },
      "properties": { "name": "…", "description": "…", "id": 123, "…": "…" } }
  ]
}
```

Geometry conversion (e.g. WKT → GeoJSON) uses the `itamair/geophp` library.

## Altering features

Implement `hook_geojson_view_alter(array &$features, \Drupal\views\ViewExecutable $view)` to
add/modify features (e.g. inject computed properties) just before rendering.

## Notes

- Filter/sort the feed with ordinary Views handlers (status, type, taxonomy, etc.).
- For map-viewport loading, add the bounding-box argument — see [../api/bbox.md](../api/bbox.md).
- No module settings page; configuration is entirely per view (config schema
  `views.style.geojson` / display options).
