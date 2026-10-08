# Geo Entity: Area — agent index

Config-only submodule that installs the `area` geo bundle for storing polygons/boundaries derived from an
uploaded geo file. No PHP, no permissions, no config UI (`configure` null). Depends on `geo_entity`,
`geocoder`, `geocoder_geofield`, `geocoder_field`. Parent:
[../../../../1.1.x/agent/start.md](../../../../1.1.x/agent/start.md).

Key facts:
- Installs bundle `area` (`geo_entity.geo_entity_type.area`) with fields: `geo_file` (file), `location`
  (geofield), `external_id`. Displays: default/inline form; default/embed/full view.
- Uses `geocoder_field`/`geocoder_geofield` to decode the uploaded `geo_file` into the `location` polygon.
- Ships optional Geocoder provider configs (in `config/optional`): `file`, `gpx_file`, `kml_file`,
  `geojson_file` — one per supported file format.
- No solution docs needed: there is no code to call — configure it entirely through Field UI / Geocoder
  provider config. See the parent module's configure doc for the bundle admin surface.
