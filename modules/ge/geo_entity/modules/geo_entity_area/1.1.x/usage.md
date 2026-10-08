Geo Entity: Area adds an `area` bundle to the Geo entity for storing geographic areas as polygons, derived from an uploaded geo file (GPX, KML, GeoJSON or generic geo file).

---

This submodule is config-only glue: it installs the `area` geo type plus a `geo_file` file field and a `location` geofield, with default form/view displays and `embed`/`full`/`inline` view modes. It relies on the Geocoder field integration (`geocoder_field` + `geocoder_geofield`) so that an uploaded geo file is decoded into the `location` geofield polygon. It ships four optional Geocoder provider configs for file formats — `file`, `gpx_file`, `kml_file`, `geojson_file` — which parse the respective file types into geometry. It has no PHP code, no permissions and no config UI of its own. Depends on `geo_entity`, `geocoder`, `geocoder_geofield` and `geocoder_field`.

---

- Store a geographic area/boundary as a polygon geo entity (regions, districts, service areas, park boundaries).
- Import a boundary by uploading a GPX file and having it geocoded into a geofield.
- Import boundaries from KML exports (e.g. from Google Earth).
- Import boundaries from GeoJSON.
- Parse a generic geo file into the `location` geofield via the shipped `file` geocoder provider.
- Reuse an area geo across many nodes via the geo library Entity Browser.
- Render an area polygon on a Leaflet map using the parent module's OSM tiles.
- Give areas their own `embed` view mode for inclusion inside other entities.
- Keep an `external_id` on each area for syncing with an external boundary dataset.
- Build a map of overlapping service areas each stored as a reusable area entity.
- Translate area labels while keeping one shared geometry.
- Track revisions of a boundary as it is refined over time.
- Combine area entities with geofield proximity/spatial Views.
- Attach additional Field UI fields (population, notes) to the area bundle.
- Store a service catchment area and reference it from the services it applies to.
- Model electoral wards, sales territories or delivery zones as reusable area entities.
- Reuse the shipped `gpx_file`, `kml_file`, `geojson_file` or generic `file` geocoder providers without configuring parsers by hand.
