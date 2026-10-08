# Configure PhotoSwipe — formatter & global settings

## Apply the formatter (Manage display)

The module provides two field formatters (defined in
`src/Plugin/Field/FieldFormatter/`):

| Formatter id | Label | Applies to |
|---|---|---|
| `photoswipe_field_formatter` | Photoswipe | `image` fields, and `entity_reference` fields targeting **media** |
| `photoswipe_responsive_field_formatter` | Photoswipe Responsive | same; **requires** the core `responsive_image` module |

Set it at **Structure → Content types → *type* → Manage display** (or any entity's
Manage display) by choosing *Photoswipe* / *Photoswipe Responsive* as the field's format.
Also usable on a media/image field in a View.

### Formatter settings (per display)

Config schema: `field.formatter.settings.photoswipe_field_formatter`
(the responsive formatter inherits the same schema). Keys and defaults:

| Setting key | Form label | Default | Meaning |
|---|---|---|---|
| `photoswipe_thumbnail_style` | Thumbnail image style | `''` (Original) | Image style for the on-page thumbnail that opens the lightbox. Special option `hide` = do not display the image. |
| `photoswipe_thumbnail_style_first` | Override first image thumbnail style | `''` (no override) | Optional different style for the first image (e.g. larger). |
| `photoswipe_image_style` | Photoswipe modal image style | `''` (Original) | Image style used for the large image shown **inside** the PhotoSwipe lightbox. |
| `photoswipe_reference_image_field` | Image field of the referenced entity | `''` | For entity_reference/media fields: which image field of the referenced entity to render. |
| `image_loading` → `attribute` | Image loading | `lazy` | Native `loading` attribute: `lazy` or `eager`. |
| `photoswipe_remove_gallery_wrapper_class` | Remove photoswipe-gallery wrapper class | `false` | Removes the auto-added `photoswipe-gallery` wrapper so you can merge multiple fields into one shared gallery yourself. |
| `photoswipe_show_download_button` | Show download button | `false` | Adds a download button to the toolbar (`data-show-download-button="true"` on the wrapper). Only available when the wrapper class is kept. |
| `photoswipe_view_mode` | (hidden) | current view mode | Internal. |

Chosen image styles are registered as config dependencies of the display
(`calculateDependencies()`), so they export together.

## Gallery grouping

- A multi-value field is grouped into **one** gallery automatically: the formatter's
  `view()` adds the `photoswipe-gallery` CSS class to the field wrapper.
- In **Views** the formatter opens **single** images by default. To make a gallery, add
  the `photoswipe-gallery` class to a wrapper (field wrapper for one multi-value field, or
  the row/inner wrapper to combine multiple fields).
- To combine several fields/paragraphs into one gallery, enable **Remove photoswipe-gallery
  wrapper class** on each field and add your own `<div class="photoswipe-gallery">` (via
  Twig, Views row class, or the Fences module). If none is present,
  `js/prepare-galleries.js` adds a fallback wrapper around each image.

## The PhotoSwipe JavaScript library (required)

The module's `composer require` is empty — the PhotoSwipe 5 library is a **third-party
asset you must provide**. Either:

- **Local:** `composer require npm-asset/photoswipe:^5` (or `bower-asset/photoswipe:^5`)
  so files land at `/libraries/photoswipe/dist/…` (library `photoswipe.local`), or
- **CDN:** enable *Load PhotoSwipe library from CDN* on the settings form (library
  `photoswipe.cdn`, loads photoswipe 5.4.4 from cdnjs).

Check the status report for library errors. The Responsive formatter additionally needs the
core **Responsive Image** module enabled.

## Global settings — `photoswipe.settings`

Route `photoswipe.settings` at **`/admin/config/media/photoswipe`**
(permission `administer site configuration`). Edit via the form or
`drush cset photoswipe.settings <key> <value>`.

| Key | Default | Meaning |
|---|---|---|
| `enable_cdn` | `false` | Load the PhotoSwipe (and caption) library from CDN instead of `/libraries`. |
| `photoswipe_always_load_non_admin` | `false` | Always attach the library on non-admin pages. |
| `options` | (mapping) | Options passed straight to the PhotoSwipe JS library. |

`options` mirrors the PhotoSwipe JS API — e.g. `showHideAnimationType` (`zoom`),
`bgOpacity` (`0.8`), `initialZoomLevel` (`fit`), `secondaryZoomLevel`, `maxZoomLevel`,
`loop`, `wheelToZoom`, `pinchToClose`, `arrowKeys`/`escKey`, click/tap actions, and the
translatable tooltips `closeTitle`/`zoomTitle`/`arrowPrevTitle`/`arrowNextTitle`/
`downloadTitle`. Full defaults live in `config/install/photoswipe.settings.yml`; schema in
`config/schema/photoswipe.schema.yml`. Settings are a config object, so they
export/deploy with `drush config:export`.

To change options in code instead of config, use
`hook_photoswipe_js_options_alter()` — see [../api/photoswipe.md](../api/photoswipe.md).
