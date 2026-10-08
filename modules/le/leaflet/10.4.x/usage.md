Leaflet integrates the Leaflet JavaScript mapping library into Drupal, rendering interactive maps of Geofield data as field formatters, widgets, and programmatically-built maps.

---

Leaflet builds on the Geofield module to display geographic data (points, lines, polygons) on interactive Leaflet maps. It provides a **field formatter** that turns a Geofield value into a map with markers and popups, and a **map widget** that lets editors place/draw geometry visually on a map instead of typing coordinates. Maps are defined through a `hook_leaflet_map_info()` system where modules register named map definitions (base layers, controls, default center/zoom), which other modules can alter; the bundled definitions cover OpenStreetMap and other tile providers, and newer versions ship MapLibre GL vector-tile support. The `leaflet.service` renders maps programmatically via `leafletRenderMap()` and converts Geofield items into Leaflet features via `leafletProcessGeofield()`, so custom code can build maps outside the field system. A rich set of alter hooks lets you customize individual features/markers, widget settings, and formatter settings, including custom icons, tooltips, and popups. Two submodules extend it: **Leaflet Views** adds a Views style/row/attachment display to map any Views result set, and **Leaflet Markercluster** groups dense markers into expandable clusters. Theming is exposed through the `leaflet_map` theme hook. Access to advanced map configuration is gated by the `configure leaflet` permission.

---

- Show a node's address/location as an interactive map via a field formatter.
- Let editors place a marker by clicking on a map widget.
- Draw polygons or lines on a map to store as Geofield geometry.
- Display multiple points from a multi-value Geofield on one map.
- Render popups with content when a user clicks a marker.
- Use OpenStreetMap tiles without any API key.
- Switch base layers with a layer-control toggle.
- Map an entire Views result set of geolocated content (Leaflet Views).
- Cluster dense markers into expandable groups (Leaflet Markercluster).
- Build a store locator from address/Geofield data.
- Show event venues on a map across a site.
- Plot real-estate listings with custom marker icons.
- Center and zoom a map to fit all displayed features automatically.
- Use custom marker icons per content type or category.
- Add tooltips to markers on hover.
- Render maps programmatically in custom code via `leaflet.service`.
- Convert Geofield items to Leaflet features for a custom map.
- Alter marker/feature output with `hook_leaflet_formatter_feature_alter()`.
- Register a custom named map definition with base layers and controls.
- Provide a decoupled map by exposing rendered map settings.
- Show a route or track as a polyline on a map.
- Add MapLibre GL vector base layers for crisp zooming.
- Attach a geocoder search control to a map.
- Theme the map wrapper via the `leaflet_map` template.
- Display hiking trails, delivery zones, or coverage areas as polygons.
- Combine clustered markers with a Views-driven data source.
- Set per-formatter default center, zoom, and height.
- Restrict who can configure Leaflet maps with a dedicated permission.
