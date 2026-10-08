# The `yandex_map` render/form element & theme hook

Use `#type => 'yandex_map'` (a `FormElement`, `YandexMapElement`) or `#theme => 'yandex_map'` to embed a
map in custom code. Both produce an empty `<div>` whose `data-*` attributes drive `js/yandex-maps.js`.

## As a render array (display only)

```php
$build['map'] = [
  '#theme' => 'yandex_map',
  '#map_center' => [37.61, 55.75],   // or '37.61,55.75'
  '#map_zoom' => 12,
  '#map_type' => 'yandex#satellite', // optional
  // GeoJSON string or array of features:
  '#map_objects' => '{"type":"Point","coordinates":[37.62,55.75]}',
];
```

## As a form element (editable)

```php
$form['location'] = [
  '#type' => 'yandex_map',
  '#map_center' => [37.61, 55.75],
  '#map_zoom' => 13,
  '#map_object_types' => ['point', 'line', 'polygon'],
  '#map_multiple' => TRUE,
  '#title' => $this->t('Location'),
];
```

`YandexMapElement::getInfo()` defaults: `#input = TRUE`, `#map_editable = TRUE`,
`#map_object_types = ['point']`, `#map_selected_control = 'point'`, `#theme = 'yandex_map'`,
`#theme_wrappers = ['form_element']`. `processYandexMap()` adds hidden `objects` (GeoJSON), `center`, and
`zoom` sub-inputs; the JS writes the user's drawn geometry back into `objects`.

## Theme / preprocess (`yandex_maps.theme.inc`)

`yandex_maps_preprocess_yandex_map()` turns each supported `#<setting>` into a `data-<setting>` attribute
(underscores → hyphens) **only when it differs from the default and is non-empty**, so the rendered
element is just `<div data-map-center="…" data-map-zoom="…" data-map-objects="…" class="yandex-map">`.
Array values (e.g. object types) are imploded with commas; `#map_objects` arrays are JSON-encoded
(`yandex_maps_encode_geojson()` → `JSON_UNESCAPED_UNICODE|JSON_UNESCAPED_SLASHES`). The `yandex_maps/main`
library is always attached; `core/jquery.cookie` is attached when `data-save-state` is set. Attribute
values are escaped by Drupal's `Attribute` rendering.

## Supported `#`-prefixed settings

`map_type`, `map_center`, `map_zoom`, `map_auto_centering`, `map_auto_zooming`, `map_editable`,
`map_multiple`, `map_clusterize`, `map_save_state`, `map_controls`, `map_behaviors`,
`map_selected_control`, `map_object_types`, `map_object_preset`, `map_without_objects`, `map_objects`,
`map_options` (see the `$default_settings` list in `yandex_maps_preprocess_yandex_map()`).

## Geometry helpers (`yandex_maps.module`)

- `yandex_maps_convert_geofield_items_to_geojson(FieldItemListInterface $items): array` — WKT items →
  GeoJSON FeatureCollection (splits Multi* geometries via `yandex_maps_split_objects()`).
- `yandex_maps_encode_geojson(array $geojson): string` — JSON encode for a data attribute.
