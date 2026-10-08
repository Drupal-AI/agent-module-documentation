Geofield adds a field type for storing geographic data — points, lines, polygons and multi-geometries — on any entity, keeping the raw geometry as Well-Known Text (WKT) plus derived latitude/longitude, bounding box and geohash columns for querying.

---

Geofield lets site builders attach a "Geofield" field to any entity type/bundle and choose how editors enter data through several widgets: a raw WKT textarea (`geofield_default`), a Latitude/Longitude pair (`geofield_latlon`, with optional HTML5 browser geolocation), a Degrees-Minutes-Seconds widget (`geofield_dms`), and a bounding-box widget (`geofield_bounds`). Every value is normalized through the GeoPHP library into a canonical geometry, and the field stores nine columns — the WKT geometry itself plus centroid `lat`/`lon`, bounding box `top`/`bottom`/`left`/`right`, `geo_type` and `geohash` — so other systems can index and query it. Storage is pluggable via GeofieldBackend plugins (a default WKB backend, plus a PostGIS backend). Two default formatters render the stored value as raw geometry text or as a lat/lon pair in various formats. Geofield ships Views integration for proximity: distance filters, sorts, arguments and fields, plus rectangular boundary filters/arguments, whose origin point is supplied by pluggable GeofieldProximitySource plugins (manual origin, client browser location, context, or another filter). It exposes reusable services — a WKT generator and a DMS↔decimal converter — and a JSON:API field enhancer that emits GeoJSON. On its own Geofield only stores and displays coordinates; it is the foundation that mapping modules (Geofield Map, Leaflet), Geocoder, and Search API Location build upon.

---

- Add a coordinate/geometry field to nodes, users, taxonomy terms or any entity.
- Store single points such as a shop or event location.
- Store linestrings for routes, trails or delivery paths.
- Store polygons for service areas, regions or property boundaries.
- Store multi-geometries (multipoint, multipolygon) in one field.
- Let editors type latitude/longitude pairs with a simple widget.
- Capture the visitor's current position via HTML5 browser geolocation.
- Enter coordinates in Degrees/Minutes/Seconds (DMS) format.
- Draw or paste raw WKT geometry directly.
- Define a bounding box (top/bottom/left/right) as the stored value.
- Power "find locations near me" proximity search in Views.
- Sort Views results by distance from an origin point.
- Filter Views to items within X km/miles of a coordinate.
- Filter Views to items inside a rectangular map boundary.
- Expose a distance unit selector on an exposed proximity filter.
- Display a computed distance column in a Views listing.
- Feed stored coordinates to map modules like Leaflet or Geofield Map.
- Geocode addresses into Geofield values using the Geocoder module.
- Serve geometries as GeoJSON through JSON:API for a decoupled front end.
- Index location data for geospatial search with Search API Location.
- Query the derived geohash column for coarse location clustering.
- Import location data from CSV/feeds into a Geofield.
- Migrate Drupal 7 geofields into Drupal 10+ via the bundled migrate plugins.
- Store geometries in PostGIS via the PostGIS backend plugin.
- Programmatically build WKT geometries with the WKT generator service.
- Convert between decimal degrees and DMS in custom code.
- Validate submitted geometries with the bundled Geo constraint.
- Show coordinates as a formatted lat/lon pair on entity display.
- Add a custom storage backend or proximity origin source via plugins.
