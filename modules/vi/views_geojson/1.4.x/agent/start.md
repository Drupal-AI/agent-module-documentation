# Views GeoJSON — agent index

Outputs a View as a GeoJSON `FeatureCollection` for Leaflet/OpenLayers/Mapbox. Core piece is
the Views **style** plugin `geojson`; there is also a **GeoJSON export** display and a bounding
box argument. No admin settings page — all config is on the view. Uses `itamair/geophp`.

- **Style options (data source: latlon/geofield/geolocation/wkt, id/name/description/properties),
  the geojson_export display, JSONP, the alter hook** → [configure/style.md](configure/style.md)
- **Bounding-box contextual filter + `bbox` argument default (map viewport loading)** →
  [api/bbox.md](api/bbox.md)

Key facts:
- Style plugin id `geojson` (`display_types = {"data"}`, theme `views_view_geojson`).
- Display plugin id `geojson_export` (extends core `RestExport`; defaults style to `geojson`).
- Data-source option `data_source.value` ∈ `latlon` | `geofield` | `geolocation` | `wkt`,
  with `latitude`/`longitude`/`geofield`/`geolocation`/`wkt` field pickers and
  `id_field` / `name_field` / `description_field`. Other options: `attributes`, `jsonp_prefix`.
- Bounding box: argument `views_geojson_bbox_argument` + argument-default `BBoxQuery` (reads a
  `bbox` query param). Hook `hook_geojson_view_alter(&$features, $view)`.
- Depends on `views`, `serialization`, `rest`.
