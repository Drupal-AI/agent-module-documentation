<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — the "Embed image galleries" filter

All configuration lives on a **text format**, not in a global settings form. Enable the filter and
add the toolbar button at Administration » Configuration » Content authoring » Text formats and
editors. The `configure` route in `data.json` is null because there is no dedicated settings page.

- **Filter plugin**: `ckeditor_media_gallery` (`src/Plugin/Filter/FilterGallery.php`), title
  "Embed image galleries", `type = TYPE_TRANSFORM_REVERSIBLE`, weight 100.
- **Config schema**: `filter_settings.ckeditor_media_gallery`
  (`config/schema/ckeditor_media_gallery.schema.yml`).
- The CKEditor 5 plugin only appears in the toolbar when its `conditions.filter:
  ckeditor_media_gallery` is met (declared in `ckeditor_media_gallery.ckeditor5.yml`), i.e. the
  filter must be enabled on that format.

## Settings (defaults from the `@Filter` annotation)

| Setting | Default | Meaning |
|---|---|---|
| `media_types` | `{image}` | Media types editors may add. Checkboxes of all media types; video types get a play badge and play in the lightbox. |
| `default_gallery_type` | `featured` | Display type for newly inserted galleries (editors can switch per gallery). Options come from the gallery-type manager. |
| `main_view_mode` | `default` | Media **view mode** for the large image (featured/carousel). Use a view mode with a (responsive) image formatter for responsive output. |
| `thumbnail_image_style` | `thumbnail` | Image style (or `responsive:<id>`) for the thumbnail strip. |
| `masonry_image_style` | `large` | Image style (or `responsive:<id>`) for masonry/grid images. |
| `lightbox_image_style` | `''` | Image style for the fullscreen image; empty = original file. Responsive styles NOT offered here (`getStyleOptions(FALSE)`). |
| `lightbox` | `glightbox` | Lightbox integration id from the lightbox manager (`glightbox` or `none`). |
| `lightbox_loop` | `TRUE` | Loop the lightbox slideshow. |
| `lightbox_zoom` | `TRUE` | Allow zooming images in the lightbox. |
| `caption_field` | `field_caption` | Machine name of a media field used as the lightbox caption. Empty disables. |
| `copyright_field` | `field_copyright` | Machine name of a media field shown as "Photo: …" in the lightbox. Empty disables. |

## Notes for agents

- `getStyleOptions()` groups plain **image styles** and, when `responsive_image` is enabled,
  **responsive image styles** (value-prefixed `responsive:`) into optgroups. `GalleryBuilder`
  distinguishes them by the `RESPONSIVE_PREFIX` constant.
- `caption_field`/`copyright_field` are free-text machine names; the builder checks
  `hasField()` before reading, and **strips all HTML tags** from the value (caption uses
  `processed ?? value`, copyright uses `value`) before it is emitted. Captions/copyright are shown
  **only in the lightbox**, never inline (see the template docstring).
- Defaults are duplicated in `GalleryBuilder::DEFAULT_SETTINGS`; the builder does `$settings +=
  DEFAULT_SETTINGS` so missing keys fall back safely.
