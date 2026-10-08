<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DKAN Geo Widget (dkan_geo_widget) — agent index

A **Leaflet + Leaflet-Geoman map widget** for DKAN's JSON-schema form UI. Editors draw markers
and shapes on an OpenStreetMap map; the module serializes them to **GeoJSON** and stores that in
the related schema field (e.g. a dataset's `spatial` property). Package `DKAN`. Core
`^10 || ^11`. License GPL-2.0-or-later. Version dir `4.0.x`.

Depends on **`dkan:dkan`** (composer `drupal/dkan:^4`) and **`json_form_widget:json_form_widget`**
(composer `drupal/json_form_widget:*`). No routes, no permissions, no Drush, no config forms, no
config schema.

- **How to enable the widget on a schema property, the render element, the router decorators, the
  JS/GeoJSON round-trip, and the bundled libraries** → [fields/widget.md](fields/widget.md)

## What it actually is

- **One render/form element:** `DkanGeoWidget` (`@FormElement("dkan_geo_widget")`,
  `src/Element/DkanGeoWidget.php`) — extends core `Textarea` and appends the
  `geowidget_leaflet_wrapper` theme wrapper. No new field type, no field-formatter, no widget
  plugin type.
- **Two service decorators** (`dkan_geo_widget.services.yml`):
  - `geo_widget.json_form.widget_router` decorates `json_form.widget_router` with
    `WidgetRouter` (`src/WidgetRouter.php`).
  - `geo_widget.group.json_form.widget_router` decorates `dkan_group.widget_router` with
    `GroupWidgetRouter` (`src/GroupWidgetRouter.php`), `decoration_on_invalid: ignore` (so it is
    a no-op when `dkan_group` is absent).
  Each adds `'dkan_geo_widget' => 'handleGeoWidgetElement'` to `getWidgets()`; the handler turns
  the target textarea element into `#type = 'dkan_geo_widget'`.
- **One hook:** `dkan_geo_widget_theme()` registers `geowidget_leaflet_wrapper`;
  `template_preprocess_geowidget_leaflet_wrapper()` sets `mapid`
  (`Html::cleanCssIdentifier($element['#name'])`) and `geo_input` (`$element['#name']`).
- **Template:** `templates/geowidget-leaflet-wrapper.html.twig` renders the textarea, a
  `<div id="{{ mapid }}" class="geo-widget" data-geoinput="{{ geo_input }}">`, and
  `attach_library('dkan_geo_widget/dkan_geoman')`.

## How it is selected

Not a UI toggle — set it in the DKAN `.ui` schema (e.g. `dataset.ui.json`):

```json
"spatial": {
  "ui:options": { "widget": "dkan_geo_widget", "title": "Relevant Location",
    "description": "…latitude/longitude pairs." }
}
```

## Libraries (`dkan_geo_widget.libraries.yml`)

- `leaflet` → bundled Leaflet (`dist/leaflet/…`, ~1.9.x).
- `geoman` → bundled Leaflet-Geoman-free (`dist/geoman/dist/…`, ~2.17.x), depends on `leaflet`.
- `dkan_geoman` → `css/leaflet_base.css` + `js/dkanGeomanLeaflet.js`, depends on `geoman`,
  `core/jquery`, `core/once`. This is the library the template attaches.

## Data flow (`js/dkanGeomanLeaflet.js`)

`Drupal.dkan_geo_widget` binds each `.geo-widget` div to its textarea (matched by
`data-geoinput` → `textarea[name=…]`). Map tiles come from public OpenStreetMap
(`https://tile.openstreetmap.org/{z}/{x}/{y}.png`, HTTPS, no key). Drawing/editing/cutting/
removing features writes `JSON.stringify(FeatureGroup.toGeoJSON())` into the textarea; changing
the textarea re-renders via `L.geoJSON(JSON.parse(value))`. Empty value → default view
`[50.179167, 9.458333]` zoom 13. Details in [fields/widget.md](fields/widget.md).
