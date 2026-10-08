<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SynMap settings, page attachment & libraries

Grounds: `src/Form/Settings.php`, `src/Hook/PageAttachments.php`, `synmap.module`,
`synmap.routing.yml`, `synmap.services.yml`, `synmap.libraries.yml`,
`config/install/synmap.settings.yml`, `config/schema/synmap.schema.yml`,
`synmap.links.menu.yml`, `synmap.links.task.yml`, `synmap.config_translation.yml`.

## Install / enable

`drush en synmap -y`. No dependencies declared in `synmap.info.yml` (`core_version_requirement:
^11 || ^12`, `package: Synapse`, `configure: synmap.settings`). On install, `config/install/
synmap.settings.yml` seeds defaults. Then visit **`/admin/config/synmap`** (link added under
*Configuration › System* via `synmap.links.menu.yml`; local task "Settings" via
`synmap.links.task.yml`).

## Route & access

- `synmap.settings` — path `/admin/config/synmap`, `_form: \Drupal\synmap\Form\Settings`,
  requirement `_permission: 'administer site configuration'`. This is the module's **only**
  route. There is no front-end/AJAX/render route — the map is emitted through page attachments,
  not a controller.

## Config object `synmap.settings` (form id `synmap_settings`)

Keys written by `Settings::submitForm()` (grouped in the form as *Map main* `yamap` and *Map
extra* `geo` details):

| Key | Meaning | Default (install) |
|---|---|---|
| `yamap-name` | Marker label shown on click (required, maxlength 255) | `''` |
| `yamap-type` | Provider: `standart` (Yandex) or `google` | `standart` |
| `yamap-enable` | Where to show: `enable` / `enable_front` / `enable_contact` / `disable_contact` / `disable` | `enable_contact` |
| `yamap-path` | Path/alias for the contact-page modes (e.g. `/contacts`) | `/contacts` |
| `yamap-attach` | CSS selector the map is injected next to (e.g. `.footer`) | `.footer` |
| `map-latitude` | Latitude | `59.214189` |
| `map-longitude` | Longitude | `39.858191` |
| `map-zoom` | Zoom level | `16` |
| `map-offset_x` | Center offset X (added to latitude) | `''` |
| `map-offset_y` | Center offset Y (added to longitude) | `''` |
| `map-apikey` | Yandex Maps API key | (unset) |
| `map-apikey-google` | Google Maps API key | (unset) |
| `yamap-method` | jQuery insert method: `before` / `after` / `append` / `prepend` | `before` |

Note the install default swaps the usual lat/long numbers (`map-latitude: 59.214189`,
`map-longitude: 39.858191`) relative to the form's placeholders — set your real coordinates.

**Config schema is partial** (`config/schema/synmap.schema.yml` types only `yamap-name`,
`map-latitude`, `map-longitude`, `map-zoom`). `yamap-type`, `yamap-enable`, `yamap-path`,
`yamap-attach`, `map-offset_x/y`, `map-apikey`, `map-apikey-google`, `yamap-method` are stored
but untyped — fine for `drush cget`, but they won't be validated/translated as typed data.
`synmap.config_translation.yml` exposes the object for the Config Translation UI.

## Page attachment logic — `PageAttachments::hook(&$page)`

Service `synmap.page_attachments` (args: `config.factory`, `path.current`, `path_alias.manager`,
`language_manager`, `path.matcher`, `module_handler`), called from `synmap_page_attachments()`.

1. Computes `$display` from `yamap-enable`:
   - `enable` → true on any path **not** starting with `/admin/`.
   - `enable_front` → `pathMatcher->isFrontPage()`.
   - `enable_contact` → true only when `yamap-path` equals the current internal path **or** its
     alias.
   - `disable_contact` → true on non-admin pages **except** `yamap-path`.
   - `disable` (or anything else) → false.
2. `moduleHandler->alter('synmap_display', $display, $attach)` — a custom module may implement
   **`hook_synmap_display_alter(bool &$display, string &$attach)`** to force the map on/off or
   change the target selector.
3. If `$display`: attaches `synmap/map`; and if current language ≠ `ru` **and**
   `yamap-type == 'standart'`, also attaches `synmap/osm_map` (Leaflet fallback for non-Russian
   locales).
4. Always sets `drupalSettings['synmap']` with a `map` block (type, `gApikey`, longitude,
   latitude, offsetX/Y, zoom, attach selector, insert method, center-auto flags) and a
   `data.contact` block (name, coordinates, marker icon spec). Client JS reads
   `drupalSettings.synmapReplace` first if present, else `drupalSettings.synmap`, so a theme/module
   can fully override the rendered map by setting `synmapReplace`.

## Libraries (`synmap.libraries.yml`) & JS

- `synmap/form` — `assets/js/form.js` + `assets/css/synmap.css`; depends on
  `core/drupalSettings`. Drives the coordinate-picker map on the admin form (loads Yandex API,
  drag marker writes lat/long back into the form fields).
- `synmap/map` — `assets/js/map.js`; the front-end renderer. Lazy-loads the provider script when
  the user scrolls near the target element, then draws the marker/SVG pin.
- `synmap/osm_map` — `assets/js/leaflet.js` + `assets/css/leaflet.css`; OpenStreetMap/Leaflet
  path used for non-`ru` standart maps.
- `synmap/yandexmap` — external `https://api-maps.yandex.ru/2.1/...` script (declared but the
  active JS builds the Yandex/Google script `src` itself, appending `map-apikey` /
  `map-apikey-google`). Provider keys are Maps **browser** API keys and are emitted to the client
  in `drupalSettings` by design; restrict them by HTTP-referrer in the provider console.

## Operating notes

- To place the map: set `yamap-attach` to a selector that exists in your theme (default `.footer`)
  and pick `yamap-method`. If the selector isn't found, `map.js` returns without rendering.
- Google provider currently initialises only when the interface language is `ru` (see the
  `lang == 'ru'` branch in `map.js`); otherwise standart+Leaflet is used.
- All config is server-side in `synmap.settings`; export with `drush cget synmap.settings`.
