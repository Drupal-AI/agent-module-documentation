Geocoder Geofield integrates the Geocoder engine with the contrib Geofield module, letting you geocode addresses into a Geofield (and reverse-geocode a Geofield back to an address) and import geometry from GPX/KML/GeoJSON files.

---

Geofield stores rich geometry (points, lines, polygons) as WKT in Drupal. This submodule teaches Geocoder how to read and write that geometry. It adds a `Geofield` Preprocessor and a `GeofieldField` plugin so a Geofield can be used as a geocode source or target on the Geocoder Field settings form, plus `Geometry` and `Geohash` Dumper plugins that output the geometry Geofield expects. It also registers file-based geometry providers — `GeoJsonFile`, `GPXFile` and `KMLFile` — so an uploaded spatial file can be geocoded into a Geofield, and matching field formatters (`GeoPhpGeocodeFormatter`, `GeoJsonFileGeocodeFormatter`, `KmlFileGeocodeFormatter`, `GpxFileGeocodeFormatter`, `ReverseGeocodeGeofieldFormatter`) that render or reverse-geocode geofield values on display. Because it builds on Geocoder Field, all configuration is done through the same per-field third-party settings — pick the Geofield as the source or target and choose the Geometry dumper. It depends on `geocoder_field` and the contrib `geofield` module. Use it whenever your map data lives in a Geofield rather than plain lat/lng text.

---

- Geocode an address field into a Geofield point on save.
- Reverse-geocode a Geofield back into a readable address.
- Store full geometry (polygons/lines), not just a single point.
- Import a GeoJSON file field into a Geofield.
- Import a GPX track file into a Geofield.
- Import a KML file into a Geofield.
- Output geocoding results as a Geofield-compatible geometry.
- Produce a geohash from geocoded coordinates.
- Render a Geofield's geometry on display via a geocode formatter.
- Reverse-geocode geofield values at display time.
- Use a Geofield as the source for further geocoding.
- Power a map (Leaflet/Geofield Map) fed by auto-geocoded points.
- Build a store locator whose coordinates come from an address field.
- Migrate spatial file data into structured Geofield geometry.
- Keep geometry and address in sync on every entity save.
- Support proximity search by geocoding into a Geofield.
- Handle multi-geometry values from imported files.
- Convert between address text and WKT geometry automatically.
- Add mapping geometry to content without manual coordinate entry.
- Choose the Geometry or Geohash dumper per field.
