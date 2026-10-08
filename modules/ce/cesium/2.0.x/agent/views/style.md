<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Cesium 3D Map" Views style

Plots every Views result row's geofield point on a **single shared 3D globe**, with optional
title/description infoboxes and auto-fit camera.

Source: `src/Plugin/views/style/CesiumMap.php` (`#[ViewsStyle(id: 'cesium_map', …)]`, extends core
`StylePluginBase`), theme `views_view_cesium_map`
(`templates/views-view-cesium-map.html.twig`), schema `config/schema/views.style.cesium_map.schema.yml`.

## Set it up

1. Create a View of the entity that carries the geofield (`display_types: ['normal']`).
2. Add the **geofield** as a Views **field** (plus any title/description fields you want in the infobox).
3. Set *Format* → **Cesium 3D Map**, open its settings, and pick the fields.

`usesRowPlugin = TRUE`, `usesRowClass = FALSE`. If the display has **no fields**, the options form
shows an error message and stops (you must add at least one field).

## Options (`defineOptions()` / `buildOptionsForm()`)

| Key | Default | Meaning |
|---|---|---|
| `width` | `100%` | Map container width (required; e.g. `100%`, `800px`). |
| `height` | `500px` | Map container height (required; e.g. `500px`, `80vh`). |
| `auto_fit` | `TRUE` | After adding markers, fly the camera to fit all of them. |
| `geofield` | `''` | **Required.** The view field (from `getFieldLabels()`) holding the geospatial value. |
| `title_field` | `''` | Optional field used as the marker/infobox title (`- None -` allowed). |
| `description_field` | `''` | Optional field used as the infobox description (`- None -` allowed). |

## How rows become markers (`render()`)

For each `$this->view->result` row (when a `geofield` option is set):

1. Calls `$this->view->rowPlugin->preRender($this->view->result)` once.
2. Resolves the WKT value: first from `$row->_entity->get(<real field name>)->getValue()[0]['value']`
   (the real field name comes from `$this->view->field[$geofield]->field`); if empty, falls back to
   `trim(strip_tags((string) $this->view->field[$geofield]->advancedRender($row)))`.
3. If a WKT value exists, `title` and `description` are produced via
   `advancedRender($row)` on the chosen title/description fields (rendered, cast to string).
4. Appends `['wkt' => …, 'title' => …, 'description' => …]` to `$locations`.

The build returns:

```
#theme    => views_view_cesium_map
#view / #options / #rows
#attached:
  library       => cesium/cesium.formatter
  drupalSettings.cesium.locations => [ {wkt,title,description}, … ]
  drupalSettings.cesium.autoFit   => <auto_fit>
```

The template renders a wrapper `<div class="cesium-views-map" style="width:…;height:…">` (both
piped through Twig `clean_class`) containing an empty
`<div class="cesium-viewer-container cesium-views-container">`.

## Client behavior

In `js/cesium_formatter.js`, a container carrying `cesium-views-container` is treated as a Views map:
it iterates `drupalSettings.cesium.locations`, parses each `POINT (lon lat)` WKT, adds a red
point entity named with `location.title` and carrying `location.description`, and — when
`autoFit` is on — `viewer.flyTo(viewer.entities)` (or flies to the single entity at the zoom offset).

## Notes

- Only `POINT (lon lat)` WKT is parsed on the client; other geometries yield no marker.
- `title`/`description` are the **rendered output** of the selected view fields (already processed by
  their own field formatters) and are transported as JSON in `drupalSettings`; Cesium shows the
  description inside its default (sandboxed) InfoBox.
- The globe controls, terrain, Ion token and OSM buildings are the same globally-configured values as
  the single-field formatter — see [../config/settings.md](../config/settings.md).
