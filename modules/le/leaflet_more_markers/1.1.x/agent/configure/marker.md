# Configure — custom Leaflet markers

No admin settings page. Setup is per entity display, on top of a Geofield rendered by
Leaflet.

## 1. Add the marker field

On an entity bundle that already has a **Geofield** (the map coordinates), add a field of
type **Map marker** (`map_marker`). Conventionally named `field_map_marker`, cardinality 1.
It stores two properties:

- `icon` — an emoji, a single Unicode char, or a font-icon code (textfield, maxlength 32).
- `classes` — attributes + optional font-icon code (textfield, maxlength 60).

On *Manage form display* the widget (`map_marker_widget`) shows an emoji **Pick emoji**
button (bundled `fgEmojiPicker`) plus the two text inputs. On *Manage display* drag the
Map marker field into **Disabled** — its value is consumed by the map, not shown as text.

## 2. Point the Leaflet formatter at the marker

Edit the **Geofield**'s display, set its widget/formatter to **Leaflet Map**, and in the
*Map icon* panel choose **Field (Html DivIcon)**. In the *Html* box enter a template that
references the marker field via tokens, keeping the `lmm-icon` class:

```html
<div class="lmm-icon [node:field_map_marker:classes]">[node:field_map_marker:icon]</div>
```

Swap `node` for `user`, `taxonomy_term`, `paragraph`, etc. for other entity types. For
Views-based Leaflet maps, set the same HTML in the Leaflet Map style settings.

## 3. Attribute vocabulary (the `classes` field / template)

Space-separated tokens parsed from the rendered element's `class`:

- **Font icon code**: `bi bi-shop` (Bootstrap Icons), `fas fa-bed` (Font Awesome free),
  `la la-swimmer` (Line Awesome). The right CDN CSS library is auto-loaded by prefix.
- **Size**: `large`, `medium` (default), `small`.
- **Circle background**: `circle-black`, `circle-white`, `circle-red`.
- **Baseline**: `center`/`centre` (raise) or omit for `ground`; or `yoffset±N` for a manual
  pixel vertical offset.
- **Animation** (CSS classes): `pulse`, `jump`, `jump-5`, `flip-1`, `rock`, `bumpy-road`,
  `somersault`, `sky-drop`.

Leave `icon` empty to use a font icon; leave both empty to fall back to the default blue pin.

## How it renders (module internals)

- `hook_field_widget_..._form_alter` attaches the emoji-picker library and passes the data
  dir to JS.
- `hook_entity_display_build_alter` / `hook_views_post_render` /
  `hook_leaflet_formatter_feature_alter` / `hook_leaflet_views_feature_alter` run
  `\Drupal::token()->replace()` on the DivIcon HTML and call
  `_leaflet_more_markers_attach_required_libs()`, which lazy-attaches only the icon-font CSS
  the markup actually references.
- `_leaflet_more_markers_feature_alter()` regex-parses the `lmm-icon` element's classes and
  sets `iconAnchor`/`popupAnchor` offsets from the size/`yoffset` classes so icons and
  popups align at any zoom. If no class names are found it reverts to the default marker pin.

## Icon-font libraries (CDN)

Defined in `leaflet_more_markers.libraries.yml`: `font_icons_bootstrap` (jsdelivr
bootstrap-icons 1.3.0), `font_icons_fontawesome` (cloudflare Font Awesome 5.15.2),
`font_icons_lineawesome` (icons8 Line Awesome 1.3.0). Loaded only when the corresponding
prefix is detected in a marker's HTML.
