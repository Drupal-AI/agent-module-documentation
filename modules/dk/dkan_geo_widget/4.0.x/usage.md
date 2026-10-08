<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DKAN Geo Widget adds a Leaflet + Leaflet-Geoman map widget to DKAN's JSON-schema form UI so editors can draw markers and shapes on a map and have them saved as GeoJSON into the related schema field (for example a dataset's `spatial` property).

---

The module extends DKAN's `json_form_widget` (and, when the site has it, `dkan_group`) by decorating their widget-router services so a new widget key `dkan_geo_widget` becomes available for `.ui` schema properties. When a property's UI options set `"widget": "dkan_geo_widget"`, the router turns that property's normal textarea into a `dkan_geo_widget` render element — a subclass of core's `Textarea` (`src/Element/DkanGeoWidget.php`) that adds a `geowidget_leaflet_wrapper` theme wrapper. The wrapper template (`templates/geowidget-leaflet-wrapper.html.twig`) prints the underlying textarea plus a `<div class="geo-widget" data-geoinput="…">` map container and attaches the `dkan_geo_widget/dkan_geoman` asset library. That library bundles Leaflet 1.9.x and Leaflet-Geoman-free 2.17.x (shipped under `dist/`) and the module's own `js/dkanGeomanLeaflet.js`, which builds a Leaflet map with an OpenStreetMap tile layer, enables the Geoman draw/edit/cut/remove controls, and keeps the hidden textarea in sync: drawing or editing a feature calls `update_text()` to write `JSON.stringify(FeatureGroup.toGeoJSON())` back into the textarea, and editing the textarea (or loading an existing value) calls `update_map()` to re-render features via `L.geoJSON(JSON.parse(value))` and fit/pan the map to them. Because the stored field value is the textarea's content, the saved payload is standard GeoJSON that DKAN persists like any other schema value. The module ships no routes, no permissions, no Drush commands, no config forms and no config schema — it is purely a form-widget integration selected through the DKAN schema UI. An empty field centers the map on a default view (roughly central Germany, `[50.179167, 9.458333]`, zoom 13) until the editor draws something.

---

- Let dataset editors set a dataset's spatial coverage by drawing on a map instead of hand-typing GeoJSON.
- Restore the DKAN D7 Leaflet-widget experience for the DKAN 2.x metastore.
- Capture a point marker for a dataset's location and store it as GeoJSON.
- Draw a bounding polygon or region outline for a dataset's `spatial` property.
- Draw multiple markers/shapes as a single GeoJSON FeatureCollection in one field.
- Edit an existing GeoJSON value visually — the map re-renders the stored geometry on load.
- Move or reshape a previously drawn feature by dragging its handles (Geoman edit/drag).
- Cut a hole or split an existing shape with the Geoman cut tool.
- Delete drawn features with the Geoman remove control and have the field update automatically.
- Add the map widget to any DKAN schema property by setting `"widget": "dkan_geo_widget"` in the `.ui` schema.
- Provide a friendly location-entry UI for non-technical open-data publishers.
- Serve map tiles from public OpenStreetMap with no API key or account to configure.
- Keep the raw GeoJSON editable as text — the textarea stays visible and drives the map.
- Use the same widget inside DKAN Group forms when the `dkan_group` module is installed (its widget router is also decorated).
- Attach a title and description to the map field via the schema UI options (`title`, `description`).
- Collect geospatial metadata that downstream DKAN consumers can read as standard GeoJSON.
- Validate geometry visually before saving, since invalid JSON simply fails to render on the map.
- Give reviewers a quick visual check of a dataset's declared location during editing.
- Bundle Leaflet and Geoman locally (under `dist/`) so no third-party JS CDN is required for the map controls.
- Center new/empty spatial fields on a sensible default view until the editor draws a feature.
