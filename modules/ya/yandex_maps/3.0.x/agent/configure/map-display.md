# Geofield widget, formatter & Views style

All three work on `geofield` geometry. The widget and formatter share the settings form
`yandex_maps_map_settings_form()` (in `yandex_maps.module`); the Views style has its own but overlapping
option set. geoPHP converts geometry between WKT (geofield storage) and GeoJSON (map objects).

## Widget `geofield_yandex_map` (multi-value, editable)

Draws point/line/polygon geometry on an editable map; `massageFormValues()` loads the submitted GeoJSON
(`objects` hidden input) via `geoPHP::load(...,'geojson')`, reduces it, and stores each object as WKT.

Settings (`defaultSettings()`): `map_type` (default `yandex#map`), `map_center` (`37.61,55.75`),
`map_zoom` (10), `map_auto_centering`/`map_auto_zooming` (TRUE), `map_controls` (`default`),
`map_object_types` (`['point']` — which of point/line/polygon the user may add),
`map_selected_control` (`point`), `map_object_preset` (`''`).

## Formatter `geofield_yandex_map` (read-only display)

Renders a geofield as a map. If empty and `map_hide_empty` is on, renders nothing. When
`map_object_hint_content` / `map_object_balloon_content` are set, they are run through the **token**
service (`\Drupal::token()->replace(..., [entity_type => entity], ['clear' => TRUE])`) per feature and
attached to the GeoJSON as `hintContent` / `balloonContent`.

Settings: `map_type`, `map_center`, `map_zoom` (12), `map_auto_centering`/`map_auto_zooming` (TRUE),
`map_controls` (`default`), `map_behaviors` (`default`), `map_object_preset`, `map_object_hint_content`,
`map_object_balloon_content`, `map_hide_empty` (TRUE).

## Shared settings-form keys (`yandex_maps_map_settings_form`)

| Key | Widget | Formatter | Meaning |
|---|---|---|---|
| `map_type` | ✓ | ✓ | `yandex#map`/`satellite`/`hybrid`/`publicMap`/`publicMapHybrid`. |
| `map_center` | ✓ | ✓ | `Lng,Lat` (e.g. `37.62,55.75`); empty → auto center. |
| `map_zoom` | ✓ | ✓ | 1–16. |
| `map_auto_centering` / `map_auto_zooming` | ✓ | ✓ | Fit view to objects. |
| `map_controls` | ✓ | ✓ | Comma list or set name; `<none>` hides all. |
| `map_behaviors` | — | ✓ | Comma list; `<none>` disables all. Default `default`. |
| `map_object_preset` | ✓ | ✓ | Yandex preset name, e.g. `islands#blackDotIcon`. |
| `map_object_types` | ✓ (editable only) | — | Which geometry types the editor may add. |
| `map_selected_control` | ✓ (editable only) | — | Initially selected draw control. |

## Views style `yandex_map`

`usesRowPlugin`/`usesFields` = TRUE. Requires a `geofield_field` (excluded from output). Per-row option
fields: `id_field`, `hint_content_field`, `icon_content_field`, `cluster_caption_field`, `preset_field`;
plus `show_balloon` (renders the row as the balloon), `map_clusterize`, `map_save_state`,
`map_hide_empty`, `map_type`, `map_center` (`37.61,55.75`), `map_zoom` (10), auto center/zoom,
`map_controls`, `map_behaviors`, `map_object_preset`, and `additional_settings.object_options` (JSON GeoObject
options, with an unused `object_options_use_tokens` toggle). `render()` builds a GeoJSON FeatureCollection
from the rows and hands it to the `yandex_map` theme.
