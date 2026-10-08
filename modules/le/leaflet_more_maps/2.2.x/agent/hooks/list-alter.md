<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hook: `hook_leaflet_more_maps_list_alter()`

Declared in `leaflet_more_maps.api.php`. This is the module's own extension point — separate
from core Leaflet's `hook_leaflet_map_info()`/`hook_leaflet_map_info_alter()`, which
`leaflet_more_maps` itself implements to *build* the catalog in the first place.

## When it fires

At the end of `leaflet_more_maps_leaflet_map_info()` (which runs as leaflet_more_maps'
implementation of core Leaflet's `hook_leaflet_map_info()`):

```php
\Drupal::moduleHandler()->invokeAll('leaflet_more_maps_list_alter', [&$map_info]);
```

— i.e. after the ~40 built-in maps and any configured custom maps have been assembled, but
**before** `leaflet_more_maps_leaflet_map_info_alter()` re-sorts the whole array alphabetically
(so key order in your implementation doesn't matter).

## Signature

```php
/**
 * @param array $map_info
 *   The map info array; add/modify/remove entries by reference.
 */
function hook_leaflet_more_maps_list_alter(array &$map_info) {
  $map_info['my_provider'] = [
    'label' => t('My Provider'),
    'description' => t('My Provider basemap'),
    'settings' => $default_settings, // see below
    'layers' => [
      'layer' => [
        'urlTemplate' => 'https://tiles.example.com/{z}/{x}/{y}.png',
        'options' => ['attribution' => 'My Provider'],
      ],
    ],
  ];
}
```

Each map entry needs `label`, `description`, `settings` (a Leaflet map-settings array — copy the
module's `$default_settings` block: `attributionControl`, `closePopupOnClick`, `doubleClickZoom`,
`dragging`, `fadeAnimation`, `layerControl`, `maxZoom`, `minZoom`, `scrollWheelZoom`, `touchZoom`,
`trackResize`, `zoomAnimation`, `zoomControl`), and `layers` (one or more named tile layers, each
with `urlTemplate` + `options.attribution`, and optionally `type` — `'quad'` for Bing's
quadtree addressing or `'google'` for Google's retina handling, both implemented in
`leaflet_more_maps.js`).

## Uses

- Add an in-house or private tile server as a selectable map style.
- Remove specific styles from the catalog site-wide (`unset($map_info['navionics']);`).
- Relabel or re-describe an existing entry.
- Change a shipped map's `settings` (e.g. force a fixed `zoom` instead of auto-box) — same
  pattern as core Leaflet's own `hook_leaflet_map_info_alter()`, but scoped to run alongside
  this module's own list assembly.

The result is cached by core Leaflet under the `leaflet_map_info` cache key — run `drush cr`
after enabling/changing a module implementing this hook.
