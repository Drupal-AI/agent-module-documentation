<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `dkan_geo_widget` map widget

## Install & enable

```bash
composer require drupal/dkan_geo_widget
drush en dkan_geo_widget -y
```

Requires **DKAN** (`drupal/dkan:^4`) and the standalone **JSON Form Widget**
(`drupal/json_form_widget`). Both are listed as `dependencies` in the info.yml
(`json_form_widget:json_form_widget`, `dkan:dkan`). (For the module's own 1.x line the README
notes `json_form_widget` had to be enabled first; the 4.x line lists it as a normal dependency.)

## Select the widget on a schema property

This widget is **not** chosen through Manage-display. You opt a DKAN schema property into it by
setting the widget key in the metastore `.ui` schema (for a dataset, `dataset.ui.json`):

```json
{
  "spatial": {
    "ui:options": {
      "widget": "dkan_geo_widget",
      "title": "Relevant Location",
      "description": "If your dataset has a spatial component, please provide location such as place name or latitude/longitude pairs."
    }
  }
}
```

Any property whose `ui:options.widget` is `dkan_geo_widget` renders as the map widget. The value
saved for that property is a GeoJSON string.

## How the widget is wired in

The module never registers a form-widget plugin. Instead it **decorates the JSON-form widget
router** (`dkan_geo_widget.services.yml`):

| Service id | Decorates | Class |
|---|---|---|
| `geo_widget.json_form.widget_router` | `json_form.widget_router` | `Drupal\dkan_geo_widget\WidgetRouter` |
| `geo_widget.group.json_form.widget_router` | `dkan_group.widget_router` | `Drupal\dkan_geo_widget\GroupWidgetRouter` |

The group decorator uses `decoration_on_invalid: ignore`, so it silently disappears on sites
without `dkan_group`. Both classes extend their respective parent router and override
`getWidgets()` to add:

```php
return parent::getWidgets() + ['dkan_geo_widget' => 'handleGeoWidgetElement'];
```

`handleGeoWidgetElement($spec, $element)` runs the property through the parent's
`handleTextareaElement()` (so all the normal textarea handling — title, description, default
value — still applies), then sets `#type = 'dkan_geo_widget'`. It handles both the plain element
and the wrapped `$element['field']` shape used by grouped/composite fields.

## The render element

`src/Element/DkanGeoWidget.php` — `@FormElement("dkan_geo_widget")`, a subclass of core
`Drupal\Core\Render\Element\Textarea`:

```php
public function getInfo() {
  $info = parent::getInfo();
  $info['#theme_wrappers'][] = 'geowidget_leaflet_wrapper';
  return $info;
}
```

So it is a normal textarea whose markup is wrapped by the `geowidget_leaflet_wrapper` theme hook.

## Theme wrapper & template

`dkan_geo_widget_theme()` registers `geowidget_leaflet_wrapper` (`render element: element`).
`template_preprocess_geowidget_leaflet_wrapper()` only acts when
`$element['#type'] === 'dkan_geo_widget'` and sets:

- `mapid` = `Html::cleanCssIdentifier($element['#name'])` — the map container id.
- `geo_input` = `$element['#name']` — the textarea's `name`, used to pair the map to its field.

`templates/geowidget-leaflet-wrapper.html.twig`:

```twig
{{ element }}
<div id="{{ mapid }}" class="geo-widget" data-geoinput="{{ geo_input }}"></div>
{{ attach_library('dkan_geo_widget/dkan_geoman') }}
```

The values placed into markup (`mapid`, `geo_input`) are the element's own machine `#name`, not
end-user free text.

## Asset libraries (`dkan_geo_widget.libraries.yml`)

- **`leaflet`** — bundled Leaflet CSS/JS from `dist/leaflet/` (Leaflet ~1.9.4 per `package.json`).
- **`geoman`** — bundled Leaflet-Geoman-free from `dist/geoman/dist/` (~2.17.0), `dependencies:
  dkan_geo_widget/leaflet`.
- **`dkan_geoman`** — `css/leaflet_base.css` (gives `.leaflet-container` a 600px min-height) plus
  `js/dkanGeomanLeaflet.js`; `dependencies: dkan_geo_widget/geoman`, `core/jquery`, `core/once`.
  This is what the template attaches. All map JS is shipped locally under `dist/`; no external JS
  CDN is used.

## Behavior & GeoJSON round-trip (`js/dkanGeomanLeaflet.js`)

`Drupal.behaviors.dkan_geo_widget` iterates every `.geo-widget` div, reads its `data-geoinput`,
and (guarded by `once('dkan_geo_widget', …)`) constructs `new Drupal.dkan_geo_widget(name, mapid)`
for the matching `textarea[name=…]`.

`Drupal.dkan_geo_widget`:

- Creates an `L.FeatureGroup` (`drawnItems`) and an `L.map(mapid)`.
- `set_leaflet_map()` adds the tile layer
  `L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', { maxZoom: 19, attribution: … })`
  — **public OpenStreetMap tiles over HTTPS, no API key/account**. It then
  `map.pm.addControls({ position: 'topright' })` to enable the Geoman toolbar and wires
  `pm:create`, `pm:edit`, `pm:dragend`, `pm:remove`, `pm:cut` events.
- `update_text()` writes `JSON.stringify(this.drawnItems.toGeoJSON())` into the textarea whenever
  a feature is created, edited, dragged, cut or removed — this is what gets saved.
- `update_map()` runs on load and on textarea `change`: empty value clears layers and sets the
  default view `[50.179167, 9.458333]` zoom 13; otherwise it parses the value with
  `L.geoJSON(JSON.parse(value))` inside a try/catch (a parse error is logged to `console.error`
  and the map is left unchanged), re-adds the layers, and `fitBounds()`/`panTo()` to frame them.

## Notes / caveats

- **No configuration surface at all** — no settings route, no config object, no config schema,
  no permissions, no Drush. Everything is driven by the `.ui` schema `widget` key.
- The stored value is a GeoJSON **string** in the schema field; DKAN persists and serves it like
  any other metastore value. Invalid/hand-edited JSON simply fails to render (caught) rather than
  breaking the form.
- The default map center is hard-coded to central Germany; there is no setting to change it.
- The group router integration only activates when `dkan_group` is installed; otherwise the
  second decorator is ignored by design.
- Tiles require outbound HTTPS access to `tile.openstreetmap.org` from the editor's browser; on
  an isolated network the map controls still work but tiles will be blank.
