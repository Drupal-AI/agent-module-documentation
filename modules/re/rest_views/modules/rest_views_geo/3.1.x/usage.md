<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
REST Views Geo is a submodule of REST Views that lets a Geolocation field be exported as structured `{lat, lng}` data in a Views REST Export display, instead of a rendered string.

---

It plugs into REST Views' serialization system for the `geolocation` field type (from the Geolocation module). Two pieces: (1) a `hook_views_data_alter()` that, for every Views field handler with id `geolocation_field`, adds a parallel **"(serializable)"** handler (`field.id = field_export`, exposed as `<field>_export`) exactly like the parent module does for core fields; and (2) a field formatter **`geolocation_latlng_formatter_export`** (class `GeolocationLatLngExportFormatter`, label "Export", for field type `geolocation`) whose `viewElements()` emits, per delta, a `SerializedData` object wrapping `['lat' => $item->lat, 'lng' => $item->lng]`. As with all REST Views export formatters it only takes effect on the serializable (`field_export`) handler; the `DataNormalizer` then serializes the coordinates as a real JSON object. The submodule has no configuration, permissions, Drush, or plugin types; it requires `rest_views` and `geolocation`.

---

- Export a location's latitude and longitude as a JSON object in a REST feed.
- Serve map coordinates to a decoupled/headless map front-end.
- Return `{lat, lng}` for each result of a Views REST Export instead of a string.
- Feed a mobile app with structured geo data from Drupal content.
- Combine geo coordinates with other serialized fields in one JSON row.
- Power a store/location finder API from a Geolocation field.
- Provide coordinates for client-side clustering or heatmaps.
- Export event venue coordinates for a calendar app.
- Serialize a property listing's location for a real-estate front-end.
- Include geo data in a search-results JSON endpoint.
- Avoid custom code to expose Geolocation field values over REST.
- Keep coordinates typed (numbers in an object) rather than a rendered string.
- Export multiple geo values as an array of `{lat, lng}` objects.
- Supply coordinates to a routing/directions integration.
- Build a GeoJSON-adjacent payload by combining with other export fields.
- Return venue coordinates alongside a nested entity reference export.
- Drive a Leaflet/Mapbox front-end from a Views REST endpoint.
