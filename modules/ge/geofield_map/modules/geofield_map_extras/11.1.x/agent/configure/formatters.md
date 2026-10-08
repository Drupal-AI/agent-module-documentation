# Formatters (geofield_map_extras)

Two extra field formatters for the `geofield` field type. Both support **Points only**
(no polylines/polygons) and reuse the Google Maps API key from `geofield_map.settings`.
Select them under **Manage display**. No admin settings form of its own.

## Geofield Google Map (static) — `geofield_static_google_map`

Renders the point as a static image via the Google Maps Static API (no controls/zoom/pan;
cheaper than a dynamic map). Schema: `field.formatter.settings.geofield_static_map`.

Settings (defaults):

| Key | Default | Notes |
|---|---|---|
| `width` | `200` | Image width in px. |
| `height` | `200` | Image height in px. |
| `scale` | `2` | Image scale (e.g. 2x). |
| `zoom` | `13` | Static map zoom level. |
| `langcode` | `en` | Two-letter language code for labels. |
| `static_map_type` | `roadmap` | roadmap / satellite / etc. |
| `marker_color` | `#ff0000` | Marker color. |
| `marker_size` | `normal` | Marker size. |

## Geofield Google Map (embed) — `geofield_embed_google_map`

Renders the map in an `<iframe>` via the Google Maps Embed API — **no JavaScript**; basic
"places" mode is free. Schema: `field.formatter.settings.geofield_embed_map`.

Settings: `width`, `height` (px).
