<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views style — multi-location map

Plugin: `\Drupal\styled_google_map\Plugin\views\style\StyledGoogleMapStyle`,
**Views style id `styled_google_map`**. Also a Views **area** handler
`\Drupal\styled_google_map\Plugin\views\area\Control` (id `google_map_control`, extends the
core Text area) for placing a control/legend on the map.

## Wiring a map view

1. Create a View listing entities that have a Geofield.
2. Format → **Styled Google Map**.
3. In the style options set the **data source** to the Geofield and (optionally) the **pin
   source** to an image field, plus popup / cluster / center options.
4. Add the Geofield (and any popup/pin fields) as View fields so the style can read them.

Multiple map views can be exposed as blocks and placed independently on one page.

## Option keys (`defineOptions()`)

All prefixed `styled_google_map_view_*`. They mirror the field-formatter settings plus
multi-marker extras. Notable ones:

- Sizing/appearance: `styled_google_map_view_width`, `_height`, `_style` (JSON), `_maptype`.
- Zoom: `_zoom_default`, `_zoom_min`, `_zoom_max`, `_gesture_handling`.
- Controls: `_zoomcontrol`, `_fullscreen`, `_streetviewcontrol`, `_maptypecontrol`,
  `_scalecontrol`, `_rotatecontrol`, `_draggable`, `_mobile_draggable`.
- Pins: `styled_google_map_view_active_pin`, `_pin_width`, `_pin_height`.
- Popup styling: `_border_color`, `_border_width`, `_border_radius`, `_background_color`,
  `_padding`, `_min_width`/`_max_width`, `_min_height`/`_max_height`, `_arrow_style`/`_arrow_size`/
  `_arrow_position`, `_shadow_style`, `_content_container_class`, `_background_class`,
  `_arrow_class`/`_arrow_outer_class`/`_arrow_inner_class`, `_disable_animation`,
  `_disable_auto_pan`, `_hide_close_button`, `_auto_close`.

## Marker clustering / spiderfy / heatmap

These are extra JS libraries the style can attach (declared in `styled_google_map.libraries.yml`):

- `google-map-clusters` → js-marker-clusterer (groups nearby markers).
- `spiderfier` → OverlappingMarkerSpiderfier (fans out markers sharing a coordinate).
- `geolocation-marker` → shows the visitor's own position.
- Heatmaps use Google's always-loaded `visualization` library.

To change markers/settings in code right before render, implement
`hook_styled_google_map_views_style_alter()` — see [../hooks/alter.md](../hooks/alter.md).
