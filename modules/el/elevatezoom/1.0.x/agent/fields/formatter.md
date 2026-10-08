<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Elevate Image Zoom" formatter

Source: `src/Plugin/Field/FieldFormatter/ImageElevateZoomFormatter.php`,
`templates/elevate-image-zoom-template.html.twig`, `elevatezoom.module` (`hook_theme`).

## Install & enable

```bash
composer require drupal/elevatezoom
drush en elevatezoom -y
```

Requires the core **`image`** module (the plugin extends `Drupal\image\...\ImageFormatter`). No
sub-modules, no permissions, no Drush commands, no config entities.

## Enable it on a field

Plugin: `ImageElevateZoomFormatter`, `@FieldFormatter(id = "elevatezoom_formatter", label =
"Elevate Image Zoom", field_types = { "image" })`. It targets **core image fields only**.

UI: *Structure → (bundle) → Manage display* → set an image field's format to **Elevate Image
Zoom** → click the gear to set the options below. `settingsForm()` starts from the core image
formatter's form and **removes `image_link`** (`unset($element['image_link'])`).

Drush / config equivalent (view display):

```bash
drush cset core.entity_view_display.node.article.default \
  content.field_image.type elevatezoom_formatter -y
drush cr
```

## Formatter settings (`defaultSettings()`)

| Setting key | Default | Meaning |
|---|---|---|
| `cdn` | `TRUE` | Load ElevateZoom Plus + Fancybox-Plus from the jsDelivr **CDN**; if off, load the self-hosted copy at `/libraries/elevatezoom/jquery.elevatezoom.js`. See [setup/libraries.md](../setup/libraries.md). |
| `image_style` | `''` | Image style for the **displayed** image (empty = original). Inherited from core `ImageFormatter`. |
| `elevate_zoom_image_style` | `''` | Image style for the **high-resolution zoom** image (empty = original). Rendered on the settings form as *"Elevate Image Zoom Style"*. |
| `elevate_thumbnail` | `'thumbnail'` | Image style for gallery **thumbnails**. |
| `elevate_zoom_type` | `'basic_zoom'` | Zoom effect: `basic_zoom`, `tint_zoom`, `inner_zoom`, `lens_zoom`, `mousewheel_zoom`, or `lightbox` (label *"Lightbox & Gallery"*). |
| `elevate_shadow_color` | `'#000000'` | `#type = color` overlay / tint colour. |
| `elevate_window_position` | `1` | Zoom-window position, clockwise, `range(1, 16)`. |
| `elevate_window_width` | `500` | Zoom-window width (required; `#min 0`, `#max 1000`). |
| `elevate_window_height` | `500` | Zoom-window height (required; `#min 0`, `#max 1000`). |
| `elevate_lens_size` | `100` | Lens size (required; `#min 0`, `#max 300`). |

`defaultSettings()` merges the above `+ parent::defaultSettings()` (so core image-formatter keys
also apply). `settingsSummary()` prints the chosen display image style, zoom image style and zoom
type on the Manage-display line.

There is **no `config/schema/`** for these keys (the module ships no config directory), so strict
config-schema tooling may flag the view-display settings; they still save and work.

## How it renders (`viewElements()`)

1. `getEntitiesToView($items, $langcode)` — honours core file/image access; returns early with no
   images.
2. For each image it loads the three image styles via `$this->imageStyleStorage->load(...)` and
   builds absolute-then-relative URLs with `$this->fileUrlGenerator` (`generateAbsoluteString()` +
   `transformRelative()`, or the style's `buildUrl()`): `images_url` (display), `zoom_image_url`
   (zoom), `thumbnail`.
3. Copies each image's `alt` and `title` (`$item->get('alt')/('title')->getValue()`) and the
   formatter settings (`shadow_color`, `window_position`, `window_width`, `window_height`,
   `lens_size`, `zoom_type`) into a per-delta array.
4. **Gallery switch:** if more than one image, it appends `_gallery` to the zoom type and sets
   `has_gallery = 'yes'`; the wrapper class is `elevate_zoom--<type>` (plus `_gallery`).
5. Returns a single render element `#theme => 'elevate_image_zoom_template'` with
   `#elevate_images`, `#elevate_class`, `#elevate_id` (the entity id), `#elevate_has_gallery`, and
   an `Attribute` object carrying classes `elevatezoom <classes> entity-<id>` and `data-entity`.
6. Attaches `elevatezoom/elevate_image_zoom_js` always, then — based on the `cdn` setting truthiness
   — either `elevatezoom/elevate_image_zoom_cdn` **or** `elevatezoom/elevate_image_zoom_libraries`.

> Note: the attach uses `if ($this->getSetting('elevate_shadow_color'))` to pick CDN vs local. Since
> `elevate_shadow_color` defaults to `#000000` (always truthy), the CDN library is chosen in
> practice; the local branch is effectively only reached if that colour setting is emptied. The UI
> "Use CDN" checkbox (`cdn`) is the intended switch and is what documentation/README describe.

## The template

`templates/elevate-image-zoom-template.html.twig` (registered by `elevatezoom_theme()` with
variables `elevate_images`, `elevate_class`, `elevate_id`, `elevate_has_gallery`, `attributes`).

- **Single image** (`elevate_has_gallery != 'yes'`): a Bootstrap-grid `<figure>` per image with an
  `<img class="… elevatezoom entity-<id>">` carrying `data-zoom-type`, `data-zoom-image`,
  `data-shadow-color`, `data-window-position`, `data-window-width`, `data-window-height`,
  `data-lens-size`, plus an optional `<figcaption>` from `title`.
- **Gallery** (`yes`): a main `<figure class="main-zoom">` zoom image plus a thumbnail
  `gallery-list` (`id="elevate_zoom--gallery_list-<id>"`); thumbnails carry
  `class="elevate_zoom_gallery"` and `data-image` / `data-zoom-image`.

All dynamic values are emitted through Twig's default auto-escaping into HTML attributes.

## JavaScript behaviour

`js/elevate_script.js` — `Drupal.behaviors.elevatezoom` binds once per `.elevatezoom` element
(`core/once`). It reads `$(this).data()`, then a `switch` on `zoomType` merges ElevateZoom Plus
options per type (fade timings, `tint`/`tintOpacity`, `scrollZoom`, `lensShape`, `zoomType`,
gallery id, etc.). For `lightbox`/`lightbox_gallery` it calls `$(this).ezPlus(config)` and, on
click, opens `$.fancyboxPlus(ez.getGalleryList())`; otherwise it uses a `window` zoom via
`ezPlus`. Thumbnail clicks swap the main image's `alt`/`title`/caption. The gallery id it targets is
`elevate_zoom--gallery_list-<entity id>`, matching the template.

## Zoom types (quick reference)

`basic_zoom` (window zoom + fades), `tint_zoom` (tinted overlay), `mousewheel_zoom` (scroll to vary
zoom + tint), `lens_zoom` (round lens), `inner_zoom` (in-frame magnify — the JS default branch),
`lightbox` (Fancybox-Plus overlay gallery). Each gains a `_gallery` variant automatically for
multi-value image fields.
