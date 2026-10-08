<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field formatter — single-entity map

Plugin: `\Drupal\styled_google_map\Plugin\Field\FieldFormatter\StyledGoogleMapDefaultFormatter`
Formatter **id `styled_google_map_default`**, applies to field type **`geofield`** only.

Assign it on *Manage display* for any bundle that has a Geofield, or set it in the
`core.entity_view_display.<entity>.<bundle>.<mode>` config:

```yaml
content:
  field_location:
    type: styled_google_map_default
    label: hidden
    settings: { … see below … }
    weight: 0
```

## Settings (from `defaultSettings()`)

Top-level:
- `width`, `height` — CSS size, e.g. `450px` / `100%` (defaults `450px` / `400px`).
- `gestureHandling` — `cooperative` (default) | `greedy` | `none`.
- `maptypecontrol`, `scalecontrol`, `rotatecontrol`, `zoomcontrol`, `fullscreen`,
  `streetviewcontrol`, `draggable`, `mobile_draggable` — booleans toggling map controls.

`style` (map appearance):
- `maptype` — `ROADMAP` (default) | `SATELLITE` | `HYBRID` | `TERRAIN`.
- `style` — **raw Google Maps JSON style string** (default `'[]'`). Paste from Snazzy Maps
  or the Google styling wizard; invalid JSON makes the map grey.
- `pin`, `pin_width`, `pin_height` — custom marker image URI and size.

`map_center.center_coordinates` — optional fixed center (else fits to the point).

`zoom` — `default` (15), `max` (17), `min` (5).

`directions` — `enabled`, `type` (e.g. `DRIVING`), `steps` (show step list).

`popup` — an info bubble on the marker. Keys: `choice` (on/off), `default_state`
(open on load), `second_click`, `open_event` (`click`/`mouseover`), `view_mode` (render the
entity in this view mode as popup body) or `text`, plus styling: `border_color`,
`border_width`, `border_radius`, `background_color`, `padding`, `min_width`/`max_width`,
`min_height`/`max_height`, `arrow_style`/`arrow_size`/`arrow_position`, `shadow_style`,
`disable_autopan`, `hide_close_button`, `disable_animation`, `close_button_source`,
`label`, and CSS `classes` (`content_container`, `background`, `arrow`, `arrow_outer`,
`arrow_inner`).

Default pin constant: `module://styled_google_map/pin.png`. All defaults live as constants
on `StyledGoogleMapInterface`.
