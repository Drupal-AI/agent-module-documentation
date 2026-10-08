Geofield Map turns a Geofield field into an interactive map for both data entry and display: a Google-Maps (or Leaflet) input widget, a Google Maps field formatter, and a Google Maps Views style, all driven by one site-wide Google Maps API key.

---

Geofield Map builds on the Geofield module and provides three main integrations for a `geofield` field. The **Geofield Map widget** (`geofield_map`, set under Manage form display) shows an interactive map on the content edit form where an editor clicks to place, find or remove a marker, or types an address that is geocoded via the Google Maps Geocoder to fill the lat/lon coordinates; it supports Google or Leaflet map libraries, configurable zoom, a map-type selector, and writing the reverse-geocoded address back into another field. The **Geofield Google Map formatter** (`geofield_google_map`, set under Manage display) renders stored points on a Google Map with heavy customization: marker icons, infowindow and tooltip content, custom map styles, gesture/zoom/pan controls, marker clustering, and overlapping-marker spiderfying. The **Geofield Google Map Views style** (`geofield_google_map`) plots a whole View result set on one map and adds MapThemer plugins that vary marker icons by field/taxonomy/entity-type values plus an optional legend block. A single **settings form** at `/admin/config/system/geofield_map_settings` (route `geofield_map.settings`, permission `configure geofield_map`) holds the Google Maps API key (optionally via a Key entity), the API localization (default vs China), marker-icon storage location/extensions/size limits used by the theming system, and client-side geocoder caching. Developers get a `MapThemer` plugin type for custom marker-styling logic, a `LeafletTileLayerPlugin` type for Leaflet base layers, services (`geofield_map.google_maps`, `geofield_map.marker_icon`, `geofield_map.geocoder`), and five `hook_geofield_map_*_alter()` hooks. The `geofield_map_extras` submodule adds cheaper static-image and iframe-embed Google Map formatters.

---

- Add an interactive map to a content edit form so editors set a location by clicking on it.
- Let editors type a street address and have it geocoded (Google Maps Geocoder) into lat/lon.
- Place, find, or remove a point marker on the widget map with click actions.
- Capture multiple points on one entity (MULTIPOINT geofield support).
- Choose Google Maps or Leaflet as the interactive map library for the widget.
- Write the geocoded address back into a separate text field on the entity.
- Display a stored geofield point on a Google Map with the Geofield Google Map formatter.
- Customize the marker icon (uploaded image, SVG, or path) shown for a content location.
- Show an infowindow with rendered field/view-mode content when a marker is clicked.
- Add a hover tooltip (e.g. the entity title) to markers.
- Apply a custom Google Maps JSON style to restyle the base map.
- Enable marker clustering to group many nearby points at low zoom.
- Spiderfy overlapping markers so co-located points remain individually clickable.
- Control zoom, gesture handling, scrollwheel, dragging, and map-reset behavior per display.
- Plot an entire View of geolocated content on a single map with the Geofield Google Map Views style.
- Vary marker icons across a View by a List field's value (MapThemer plugin).
- Vary marker icons by taxonomy term or by entity type on a map View (MapThemer plugins).
- Show a legend block explaining what each themed marker icon means.
- Set one site-wide Google Maps API key for all mapping and geocoding operations.
- Store the Google Maps API key securely as a Key entity instead of plain config.
- Switch Google Maps API loading to the China endpoint for sites serving that region.
- Configure where custom marker-icon image files are stored (public/private, path, extensions, max size).
- Cache reverse-geocoding results client-side (SessionStorage/LocalStorage) to cut API calls.
- Render a cheaper static Google Map image via the `geofield_map_extras` static formatter.
- Embed a Google Map in an iframe with no JavaScript via the `geofield_map_extras` embed formatter.
- Alter widget or formatter map settings programmatically with the module's alter hooks.
- Register a custom Leaflet base tile layer via a LeafletTileLayerPlugin.
- Write a custom MapThemer plugin to drive marker styling from any dynamic logic.
