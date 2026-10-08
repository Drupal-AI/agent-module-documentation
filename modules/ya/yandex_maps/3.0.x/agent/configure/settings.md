# Global settings & library build

## Settings form

Route `yandex_maps.settings` → `/admin/config/system/yandex-maps`, permission
`administer site configuration` (`YandexMapsSettingsForm`, config object `yandex_maps.settings`).

| Key | Type | Meaning |
|---|---|---|
| `api_key` | string | Yandex.Maps API key (public browser-side JS key). |
| `presets_file_path` | string | Optional path (relative to site root) to a JS file defining reusable presets, e.g. `modules/contrib/yandex_maps/js/yandex-maps-presets.example.js`. |
| `objects_default_preset` | string | Default placemark preset name, e.g. `islands#blueDotIcon`, exposed via `drupalSettings`. |
| `debug_mode` | bool | Load the unpacked Yandex API (`mode=debug`); not for production. |

Saving the form calls `drupal_flush_all_caches()` (the library is rebuilt from config).

Drush set-up example:

```bash
ddev drush cset yandex_maps.settings api_key 'YOUR-KEY' -y
ddev drush cset yandex_maps.settings objects_default_preset 'islands#blueDotIcon' -y
```

## How the library is assembled (`hook_library_info_build()`)

The `yandex_maps/main` library is built dynamically from config (`yandex_maps.module`):

1. External Yandex API script:
   `https://api-maps.yandex.ru/2.1/?` + `http_build_query([apikey, lang=ru_RU, coordorder=longlat,
   onload=Drupal.behaviors.yandexMaps.attach])`; `mode=debug` is added when `debug_mode` is on.
2. If `presets_file_path` is set: `base_path() . presets_file_path` is added as a JS asset.
3. `js/yandex-maps.js` is added last.
4. `css/yandex_maps.css` (theme) is attached.
5. `drupalSettings.yandexMaps` gets `modulePath` and `objectsDefaultPreset`.
6. Dependencies: `core/jquery`, `core/once`, `core/drupal`. (`core/jquery.cookie` is added by the theme
   preprocess when a map's save-state option is on.)

Note the API is loaded with `lang=ru_RU` and `coordorder=longlat` hardcoded in the library build; change
these by altering the library if you need a different locale/coordinate order.
