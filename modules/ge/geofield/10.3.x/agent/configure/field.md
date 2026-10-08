# Configure a Geofield field

Add a field of type **Geofield** (`id: geofield`) to any entity bundle at
`/admin/structure/types/manage/<bundle>/fields`. There is no module-wide settings form —
everything is per-field on the field settings, form display and view display.

## Storage columns
One field stores nine columns derived from the WKT geometry: `value` (WKT), `geo_type`,
`lat`, `lon`, `top`, `bottom`, `left`, `right`, `geohash`, plus a computed `latlon` pair.

## Storage setting
- `backend` (field storage setting): which GeofieldBackend plugin stores the geometry.
  Default `geofield_backend_default` (WKB). Alternative `geofield_backend_postgis`.

## Widgets (Manage form display)
- `geofield_default` — raw WKT textarea. Setting: `geometry_validation` (bool).
- `geofield_latlon` — Latitude/Longitude pair. Setting: `html5_geolocation` (bool, prefill
  from the browser).
- `geofield_dms` — Degrees/Minutes/Seconds inputs.
- `geofield_bounds` — bounding box (top/right/bottom/left).

## Formatters (Manage display)
- `geofield_default` — outputs the geometry. Settings: `output_format` (e.g. `wkt`, `json`),
  `output_escape` (bool).
- `geofield_latlon` — outputs the centroid as a lat/lon pair. Settings: `output_format`,
  `output_escape`.

Config schema lives in `config/schema/geofield.schema.yml`. For interactive maps use a
contrib formatter/widget (Geofield Map, Leaflet) — core Geofield only renders text.
