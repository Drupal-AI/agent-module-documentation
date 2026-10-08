<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Elevate Image Zoom" formatter

One field formatter, `ElevateImageZoomFormatter` (id **`elevate_image_zoom_formatter`**, label
*"Elevate Image Zoom"*), in
`src/Plugin/Field/FieldFormatter/ElevateImageZoomFormatter.php`. It **extends core
`Drupal\image\Plugin\Field\FieldFormatter\ImageFormatter`** and targets `field_types = { "image" }`
(core image fields only). No widget, no field type, no permissions, no routes, no services, no hooks
beyond `hook_theme()`/`hook_help()`/`hook_requirements()`.

## Install & enable

```bash
composer require drupal/elevate_image_zoom
drush en elevate_image_zoom -y
```

**Required third-party library (manual step):** download the ElevateZoom jQuery plugin and place it at
`/libraries/elevatezoom/jquery.elevatezoom.js`. `elevate_image_zoom.install`
(`elevate_image_zoom_requirements()`) checks
`file_exists(DRUPAL_ROOT . '/libraries/elevatezoom/jquery.elevatezoom.js')` on both `install` and
`runtime` phases and reports `REQUIREMENT_ERROR` (status report) until it is present. The module does
not bundle or download the library. `info.yml` declares no module deps, but the code needs core
**`image`** (extends `ImageFormatter`, calls `image_style_options()`).

## Enable it on a field

UI: *Structure → (bundle) → Manage display* → set the image field's format to **Elevate Image Zoom** →
click the gear to configure. For a **gallery**, make the image field multi-value and add several images
to one field; the formatter renders a main image + thumbnail strip automatically.

Config equivalent (view display):

```bash
drush cset core.entity_view_display.node.article.default \
  content.field_image.type elevate_image_zoom_formatter -y
drush cr
```

## Formatter settings

From `defaultSettings()` and `settingsForm()`:

| Setting key | Default | Meaning |
|---|---|---|
| `image_style` | `''` | Image style for the **on-page display** image (inherited from core `ImageFormatter`; `''` = original). |
| `elevate_zoom_image_style` | `''` | Image style for the **high-res zoom** image loaded into `data-zoom-image` (`''` = original). |
| `elevate_thumbnail` | `'thumbnail'` | Image style for **gallery thumbnails**. |
| `elevate_zoom_type` | `'basic_zoom'` | Effect: `basic_zoom`, `tint_zoom`, `inner_zoom`, `lens_zoom`, `mousewheel_zoom`. |
| `elevate_shadow_color` | `'#000000'` | Tint overlay colour (used by tint/mousewheel types); textfield, required, maxlength 15. |
| `elevate_window_position` | `1` | Zoom-window clock position, 1–16 (`number`, required). |
| `elevate_window_width` | `500` | Zoom-window width, 100–1000. |
| `elevate_window_height` | `500` | Zoom-window height, 100–1000. |
| `elevate_lens_size` | `100` | Lens diameter for lens zoom, 100–300. |

`settingsForm()` starts from `parent::settingsForm()` (core Image formatter) and **unsets
`image_link`**. `settingsSummary()` prints the display image style, zoom image style and zoom type.
Note: these keys have **no config schema** in the module, so strict schema validation may warn on the
view-display config; the values still save and apply.

## How it renders (`viewElements()`)

1. `getEntitiesToView($items, $langcode)` returns the image entities (so core file/display access is
   honoured); empty → no output.
2. Loads three image styles via `$this->imageStyleStorage->load(...)`: display (`image_style`), zoom
   (`elevate_zoom_image_style`), thumbnail (`elevate_thumbnail`).
3. Per image, builds three URLs from the file URI with `$style->buildUrl($uri)` (or, when no style,
   `file_url_generator->generateAbsoluteString($uri)`), each run through
   `file_url_generator->transformRelative(...)`: `images_url`, `zoom_image_url`, `thumbnail`.
4. Builds the CSS id `elevate_zoom--{elevate_zoom_type}`; if more than one image,
   appends `_gallery` and sets `elevate_has_gallery = 'yes'`.
5. Returns a render array `#theme => 'elevate_image_zoom_template'` with `#elevate_images`,
   `#elevate_class`, `#elevate_has_gallery`.
6. Attaches library `elevate_image_zoom/elevate_image_zoom_js` and five `drupalSettings` values:
   `elevate_tint_shadow_color`, `elevate_window_position`, `elevate_window_width`,
   `elevate_window_height`, `elevate_lens_size`.

## Theme & markup

`elevate_image_zoom_theme()` (in `elevate_image_zoom.module`) registers
`elevate_image_zoom_template` → `templates/elevate-image-zoom-template.html.twig` with variables
`elevate_images`, `elevate_class`, `elevate_has_gallery`.

- **Single image:** one `<img id="{class}" src="{images_url}" data-zoom-image="{zoom_image_url}">`.
- **Gallery** (`elevate_has_gallery == 'yes'`): the first image becomes the main
  `<img id="{class}">` followed by a `<div id="{class}_list">`; every image also emits
  `<a data-image=… data-zoom-image=…><img class="{class}" src="{thumbnail}"></a>`.

(The template uses the same value for the element `id` per zoom type, so multiple identical-type
displays on one page share an id — a markup caveat, not a config option.)

## JavaScript (`js/elevate_script.js`)

`Drupal.behaviors.easyzoom.attach()` reads the five `drupalSettings` values and calls
`$('#elevate_zoom--<type>').elevateZoom({...})` for each type / `_gallery` variant:

- `basic_zoom` → `zoomWindowPosition/Width/Height`.
- `tint_zoom` → adds `tint: true`, `tintColour: shadow_color`, `tintOpacity: 0.5`.
- `mousewheel_zoom` → tint options + `scrollZoom: true`.
- `lens_zoom` → `zoomType: 'lens'`, `lensShape: 'round'`, `lensSize`.
- `inner_zoom` → `zoomType: 'inner'`, `cursor: 'crosshair'`.
- `_gallery` variants add `gallery: '…_gallery_list'`, `cursor: 'pointer'`,
  `galleryActiveClass: 'active'`, `imageCrossfade: true`.

## Library (`elevate_image_zoom.libraries.yml`)

`elevate_image_zoom_js`: loads `js/elevate_script.js` (weight -1) and the manually installed
`/libraries/elevatezoom/jquery.elevatezoom.js` (weight -2); depends on `core/jquery`, `core/drupal`.

## Gotchas

- **Library not bundled** — the status report shows an error until `jquery.elevatezoom.js` is added to
  `/libraries/elevatezoom/`; the formatter renders `<img>` tags but no zoom fires without it.
- **Gallery is automatic** — driven purely by the field being multi-value; there is no per-display
  "gallery on/off" toggle.
- **No config schema** for the formatter settings (see above).
- `elevate_shadow_color` is a free-text field limited to 15 chars; it is exposed to JS via
  `drupalSettings` (JSON-encoded by Drupal) and consumed as the ElevateZoom `tintColour`.
