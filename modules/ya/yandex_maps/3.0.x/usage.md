Yandex.Maps integrates the Yandex.Maps JS API (v2.1) into Drupal, providing a `yandex_map` render/form element, a geofield widget and formatter, and a Views style that plot geofield geometry as points/lines/polygons on a Yandex map with clustering, balloons and presets.

---

A global settings form (`/admin/config/system/yandex-maps`, permission `administer site configuration`)
stores the Yandex API key, an optional presets JS file path, a default objects preset, and a debug-mode
flag. `hook_library_info_build()` assembles the `yandex_maps/main` library on the fly: it builds the
external Yandex API script URL (`https://api-maps.yandex.ru/2.1/?apikey=…&lang=ru_RU&coordorder=longlat…`),
optionally the presets file, then `js/yandex-maps.js`, and passes the default preset via
`drupalSettings.yandexMaps`. The `yandex_map` render element (`YandexMapElement`) and its `yandex_map`
theme hook output an empty `<div>` whose `data-*` attributes (map type/center/zoom/controls/behaviors/
objects, etc.) are read by the JS to instantiate the map; map objects are carried as GeoJSON. A geofield
widget (`geofield_yandex_map`, multi-value) lets editors draw point/line/polygon geometry on an editable
map and stores it back as WKT via geoPHP; the matching formatter (`geofield_yandex_map`) renders a
geofield read-only, with optional token-replaced hint/balloon content. A Views style plugin (`yandex_map`)
plots a chosen geofield column from each row, with per-row id/hint/icon/cluster-caption/preset fields,
clustering, balloons (rendered row output), and extra object options as JSON. Coordinates and object
GeoJSON are emitted as escaped HTML `data-*` attributes (via Drupal's Attribute rendering) and the API
key is a public browser-side JS key. Ships a `yandex_maps_examples` submodule with demo routes/forms.

---

- Show a Yandex map of a geofield's location(s) on an entity display.
- Let editors place a marker by clicking a map in the node edit form (geofield widget).
- Let editors draw lines and polygons, not just points, and store them as geometry.
- Store map-drawn geometry as WKT in a geofield for reuse elsewhere.
- Plot many entities' locations on a single Yandex map with a Views map style.
- Cluster large numbers of placemarks on a Views map.
- Show a balloon with the rendered Views row when a placemark is clicked.
- Add per-marker hint (tooltip) text from a Views field.
- Set custom marker icons/presets per row via a preset field.
- Choose the map type: roadmap, satellite, hybrid, public map, or hybrid public map.
- Center and zoom the map to fixed coordinates, or auto-center/auto-zoom to the data.
- Configure which Yandex map controls (search, fullscreen, zoom, etc.) are shown.
- Enable or disable map behaviors (drag, scroll-zoom) per map instance.
- Use token replacement in balloon/hint content for a geofield formatter.
- Embed an interactive map in a custom form or render array via `#type => 'yandex_map'`.
- Provide a click-to-add / double-click-to-remove multi-object editing map.
- Save the user's chosen zoom/center across visits (save-state option).
- Supply a custom presets JS file to define reusable marker styles.
- Localize/parameterize the API load (language, coordinate order) through the library build.
- Set a site-wide default objects preset for all maps.
- Toggle Yandex API debug (unpacked) mode for troubleshooting.
- Apply additional Yandex GeoObject options (icon layout, image href/size/offset) as JSON.
- Hide the map entirely when a geofield/View has no geometry (hide-empty option).
- Learn the API from the bundled examples submodule (theme, clusterize, and form demos).
