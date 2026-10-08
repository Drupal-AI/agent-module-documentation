Geomap Field adds a single composite field type that stores a postal address together with its latitude/longitude and renders it as a Leaflet map, with a map-picker widget and a map formatter.

---

Geomap Field defines one field type, `geomap`, whose columns hold `address_name`, `street`, `zipcode`, `city`, `country`, `additional`, `lat`, `lon`, and a `feature` text column (raw GeoJSON of the matched place). Its default widget shows the address text fields beside an interactive map with a draggable marker and a "Try to geolocate the address" button; the coordinates are looked up through the pluggable `geolocation_provider` module (Nominatim, BANO, etc.) and the map tiles/renderer come from the pluggable `map_provider` module (OSM by default). Because both geocoding and map rendering are delegated to those two dependency modules, you swap providers by configuration rather than by code. The default formatter renders each stored value as a read-only map centred on the saved coordinates with a fixed marker, so pages that display locations never need to geocode at request time — the coordinates are already in the database. It is deliberately minimal: no routes, permissions, services, config entities or Drush commands of its own; just a field type, a widget and a formatter.

---

- Add an "address + coordinates" field to any content type, taxonomy term, user or other fieldable entity.
- Store a full postal address and its latitude/longitude in a single field, in one save.
- Let editors geocode an address to coordinates by clicking a button in the edit form.
- Let editors fine-tune a location by dragging the map marker.
- Let editors override the auto-geocoded latitude/longitude with exact values typed by hand.
- Reverse-geocode the address text automatically when the marker is dragged to a new spot.
- Pick from geocoding suggestions returned by the provider and auto-fill the address fields.
- Display a stored location as a live map on the entity's view page via the Geomap formatter.
- Avoid geocoding at page-render time by reading the coordinates already saved in the field.
- Choose the geocoding backend (Nominatim, BANO, …) per widget via the `geolocation_provider` plugin.
- Choose the map/tile provider (OSM, …) per widget and per formatter via the `map_provider` plugin.
- Set the rendered map's height and width per view-display in the formatter settings.
- Keep the map's marker in sync with the latitude/longitude fields as they are edited.
- Build a store-locator or "our offices" page backed by structured, queryable coordinates.
- Populate map markers for Views or custom queries directly from the `lat`/`lon` columns.
- Migrate from heavier geolocation stacks when only an address-plus-map field is needed.
- Capture the full GeoJSON `feature` of the matched place in the field's `feature` column for later use.
- Provide a consistent address-entry UX (name, street, zip, city, country, additional) across bundles.
- Swap a map provider whose pricing or terms change without touching stored data.
- Show a single location per field delta, or several deltas as several maps on one display.
- Seed test content: the field type ships a `generateSampleValue()` for Devel-generated entities.
- Reuse the same field on multiple bundles with independent widget/formatter provider choices.
