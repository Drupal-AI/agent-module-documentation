Google Map Field defines a `google_map_field` field type that stores an interactive Google Map (center, zoom, marker, and info-window) per entity, with widgets to place the map and formatters to render it.

---

The module adds a single field type, `google_map_field`, whose storage holds a map's `name`, `lat`, `lon`, `zoom`, map `type`, `width`, `height`, a `marker` flag, a `traffic` layer flag, a custom `marker_icon` path, a `controls` flag, and an `infowindow` HTML message. Editors set these through one of two widgets — `google_map_field_default` (a Google Maps picker) or `olmap_field` (an OpenLayers picker that needs no API key to author) — and the stored value is rendered by one of three formatters: `google_map_field_default` (interactive Google map), `google_map_field_embed` (Google Maps Embed "place" iframe), or `google_map_field_open_layers` (OpenLayers map). A small global settings form at `/admin/config/services/gmap-field-settings` (route `gmap.field.settings`) stores the Google Maps JavaScript API key in the `google_map_field.settings` config object, choosing between a plain **API Key** (`google_map_field_auth_method: 1`) and **Google Maps API for Work** client ID (`google_map_field_auth_method: 2`). A Feeds target plugin lets the field be populated during Feeds imports. There is no plugin manager of its own — it plugs into core's Field API. The Google-based widgets and formatters require a valid API key to display tiles, while the OpenLayers variants work without one.

---

- Attach a map to a "Location" content type so each place shows an interactive Google map.
- Let editors drag a marker to set latitude/longitude instead of typing coordinates.
- Store a per-node zoom level and map type (roadmap/satellite/terrain) alongside the coordinates.
- Render a stored map as a Google Maps Embed "place" iframe with the `google_map_field_embed` formatter.
- Render maps without a Google API key using the OpenLayers formatter (`google_map_field_open_layers`).
- Author map values without an API key using the OpenLayers widget (`olmap_field`).
- Show a custom marker icon per map via the field's `marker_icon` value.
- Display an info-window bubble with HTML content on the marker.
- Toggle the Google traffic layer on a rendered map through the `traffic` value.
- Hide or show the map's zoom/pan controls per field value via `controls`.
- Configure one global Google Maps API key for the whole site at `/admin/config/services/gmap-field-settings`.
- Switch between a standard API key and a Google Maps API for Work client ID.
- Populate map fields during a Feeds import using the module's Feeds target.
- Add multiple map deltas to a single entity (multi-value map field).
- Set map width and height per value to control the rendered map size.
- Build a store-locator or directory where each entity carries its own map.
- Present event venues on a map embedded in the node display.
- Store coordinates programmatically by setting the field's `lat`/`lon`/`zoom` properties.
- Export the API-key configuration (`google_map_field.settings`) as part of a deployment.
- Give content authors a visual map picker rather than a raw geolocation field.
- Reuse one map field across several bundles with different formatters per view mode.
- Show a satellite view on one display and a roadmap on another using the same stored value.
- Provide a lightweight map field for editorial sites without a full geofield/GIS stack.
- Migrate legacy latitude/longitude data into a single map field via Feeds.
- Drop a default marker at a chosen center point for new nodes.
