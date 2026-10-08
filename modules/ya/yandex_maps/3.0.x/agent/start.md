# Yandex.Maps — agent index

Integrates the Yandex.Maps JS API v2.1: a `yandex_map` render/form element, a `geofield_yandex_map`
widget + formatter, and a `yandex_map` Views style. No permissions of its own (settings use core
`administer site configuration`); no Drush. Provides a config schema. Depends on a `geofield` field for
the widget/formatter/Views style (geoPHP is used to convert WKT ⇄ GeoJSON).

- **Global settings (API key, presets file, default preset, debug) + how the JS library is built** →
  [configure/settings.md](configure/settings.md)
- **Geofield widget, formatter, and Views style settings (all the map_* keys)** →
  [configure/map-display.md](configure/map-display.md)
- **The `yandex_map` render/form element + theme hook, data-attributes, GeoJSON, custom-code usage** →
  [api/element.md](api/element.md)

Submodule (own docs):
- `yandex_maps_examples` → [../../modules/yandex_maps_examples/3.0.x/agent/start.md](../../modules/yandex_maps_examples/3.0.x/agent/start.md)

Key facts:
- Settings route `yandex_maps.settings` = `/admin/config/system/yandex-maps` (`administer site configuration`).
  Config `yandex_maps.settings`: `api_key`, `presets_file_path`, `objects_default_preset`, `debug_mode`.
- `hook_library_info_build()` builds `yandex_maps/main`: external Yandex API URL with
  `apikey`, `lang=ru_RU`, `coordorder=longlat`, `onload`; then the presets file; then `js/yandex-maps.js`;
  plus `drupalSettings.yandexMaps`.
- Geometry travels as GeoJSON in a `data-map-objects` attribute; the widget stores WKT via geoPHP.
  Field/formatter/element outputs are escaped by Drupal's Attribute rendering; the API key is a
  browser-side (public) JS key — no server-side secret is exposed by the map embed.
- Plugins: field widget `geofield_yandex_map`, field formatter `geofield_yandex_map`, Views style `yandex_map`.
