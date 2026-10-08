<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mapbox Field adds a Drupal field type for placing a location marker on a Mapbox map. Editors pick a point
using an interactive Mapbox map widget; the stored coordinates are then rendered on the front end as a
Mapbox GL map via field formatters. It builds on the base [Mapbox](https://www.drupal.org/project/mapbox)
module for the access token and default style, and depends on core `field`.

---

The module ships a `MapboxField` field type (`src/Plugin/Field/FieldType`), a `MapboxWidget` interactive
map widget (`src/Plugin/Field/FieldWidget`) for choosing the marker location, and three formatters
(`src/Plugin/Field/FieldFormatter`): `MapboxFormatter`, `MapboxSingle`, and `MapboxRawFormatter`. Widget
and formatters obtain the Mapbox access token from the injected `mapbox` service
(`$this->mapbox->accessToken()`) and push map settings (including the token) into `drupalSettings` for the
front-end JS, rendering into `.mapbox-map` containers (twig templates
`mapbox-field.html.twig`, `mapbox-field-singlemap.html.twig`). A "missing access token" message is shown
if the base module has no token configured. The token used is the same publishable/browser-side Mapbox
token described for the base module. No permissions are defined, and no server-side HTTP requests are
made — map tiles/styles are fetched by Mapbox GL JS in the browser.

Note: the info.yml declares `configure: mapbox_field.config_form`, but the module ships **no routing.yml**
defining that route — so the "Configure" link resolves to nothing (a harmless packaging leftover);
actual configuration is Mapbox's own `/admin/config/services/mapbox` page for the token/style.

---

- Add a "pick a point on a map" field to any content type.
- Let editors set a marker location via an interactive Mapbox widget.
- Render the stored location as a Mapbox GL map on node view.
- Choose between full, single-map, and raw formatters per display.
- Show a store/office location field on a content type.
- Display event venues on a map field.
- Reuse the site-wide Mapbox token/style from the base module.
- Output raw coordinate data with the raw formatter for custom JS.
- Place multiple map fields on the same entity.
- Configure the marker and map per field instance.
- Warn editors when no Mapbox token is configured.
- Build location-aware content types without custom field code.
- Theme the map container via the bundled twig templates.
- Render maps client-side (no server-side tile fetching).
- Use the widget's map to visually confirm the chosen point.
- Combine with Views to list geolocated content.
