<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Cesium Globe" geofield formatter

## Install & enable

```bash
composer require drupal/cesium
drush en cesium -y
```

The only module dependency is **`geofield`**. The CesiumJS library must exist at
`web/libraries/cesium/Build/Cesium/Cesium.js` — installed via the `npm-asset/cesium` Asset
Packagist package (see README for the root-`composer.json` repository + `installer-paths` setup).
Without the library on disk the globe silently does nothing (`js/cesium_formatter.js` returns early
when `window.Cesium` is undefined).

## Enable it on a field

Plugin id **`cesium_geofield_formatter`**, label *"Cesium Globe"*,
`field_types = { "geofield" }` — it applies only to **Geofield** fields
(`src/Plugin/Field/FieldFormatter/CesiumGeofieldFormatter.php`, extends core `FormatterBase`).

UI: add a **Geofield** to a bundle → *Structure → (bundle) → Manage display* → set that field's
format to **Cesium Globe** → gear icon to set the zoom altitude.

Config/Drush equivalent (view display):

```bash
drush cset core.entity_view_display.node.article.default \
  content.field_location.type cesium_geofield_formatter -y
drush cr
```

## Settings

From `defaultSettings()`:

| Key | Default | Meaning |
|---|---|---|
| `zoom` | `1000` | Camera altitude in **meters** to fly to when viewing the point (`settingsForm()` `#type number`, `#min 1`, required). |

`settingsSummary()` shows `Zoom altitude: @zoom m` on the Manage-display line.

## How it renders (from `viewElements()`)

For each geofield item it builds one render element:

```
#type => html_tag, #tag => div
#attributes:
  class    => ['cesium-viewer-container']
  data-wkt => $item->value          # e.g. "POINT (29 41)"
  data-lat => $item->lat
  data-lon => $item->lon
  data-zoom => <zoom setting>
  id       => 'cesium-viewer-<fieldname>-<delta>'
#attached => library cesium/cesium.formatter
```

The `data-*` values are placed as **HTML attributes on an `html_tag` render element**, so Drupal's
renderer escapes them — they are attribute data, not raw markup. There is no `#markup` and no
`drupalSettings` payload from the formatter itself; coordinates travel purely as escaped attributes.

## Client behavior (`js/cesium_formatter.js`)

`Drupal.behaviors.cesiumFormatter` processes each `.cesium-viewer-container:not(.cesium-processed)`:

1. Bails out if `window.Cesium` is undefined.
2. Applies global `drupalSettings.cesium` (base URL, Ion token, terrain/buildings — set site-wide by
   `cesium_page_attachments()`, see [../config/settings.md](../config/settings.md)).
3. Instantiates `new Cesium.Viewer(element, {...})` with the full control set (baseLayerPicker,
   fullscreenButton, geocoder, homeButton, infoBox, sceneModePicker, selectionIndicator,
   navigationHelpButton; animation + timeline off).
4. Parses coordinates: prefers `data-lat`/`data-lon`; otherwise parses `data-wkt` — a `POINT (lon lat)`
   string, or a `lat,lon` comma pair.
5. Adds a red point entity and `camera.flyTo` the point at the configured zoom altitude, pitch -90°.

The library `cesium/cesium.formatter` (`cesium.libraries.yml`) pulls in `core/drupal`,
`core/drupalSettings`, `cesium/cesium` (the minified CesiumJS build + `widgets.css`) plus this
module's `js/cesium_formatter.js` and `css/cesium_formatter.css`.

## Gotchas

- The library is **not** bundled with the module; a missing `/libraries/cesium` means an empty
  container, not an error.
- The formatter always attaches the **minified** `cesium/cesium` library (via `cesium.formatter`);
  the production/development choice in site settings only changes `CESIUM_BASE_URL` (worker/asset
  path), not which `Cesium.js` file the formatter library loads.
- WKT parsing in JS is minimal — only `POINT (lon lat)` and `lat,lon`; polygons/lines are not drawn.
