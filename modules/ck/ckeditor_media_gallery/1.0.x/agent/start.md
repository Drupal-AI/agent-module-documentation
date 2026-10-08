<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Media Gallery (ckeditor_media_gallery) — agent index

A CKEditor 5 plugin that adds an **image-gallery button** to the editor. Editors multi-select
images (and, optionally, videos) from the **core Media Library**; the plugin stores the whole
gallery as a single `<drupal-gallery data-media-uuids="…" data-gallery-type="…"
data-gallery-caption="…">` element, and a **text filter** renders it on the front end with a chosen
display type and a fullscreen lightbox. No new entities, content types, or permissions are added.
Package `CKEditor 5`. Core `^10.5 || ^11`. License GPL-2.0-or-later. Installed as **1.0.0-alpha1**
(version dir `1.0.x`).

## Dependencies

- Drupal core modules only (from `.info.yml`): **`ckeditor5`**, **`editor`**, **`filter`**,
  **`media`**, **`media_library`**.
- No PHP libraries. The GLightbox JS/CSS (MIT, v3.3.0) is loaded from the **jsDelivr CDN** by
  default (`gallery.libraries.yml`); override the `ckeditor_media_gallery/glightbox` library to
  serve it locally. Optional core **`responsive_image`** unlocks responsive-image-style options.

## Architecture (from source)

The gallery is stored inline and rendered in two mirrored paths that share one builder:

- **Editor side** — CKEditor 5 plugin `ckeditor_media_gallery_gallery` (`ckeditor_media_gallery.ckeditor5.yml`),
  PHP class `Plugin/CKEditor5Plugin/Gallery` (`@internal`). `getDynamicPluginConfig()` hands the JS
  the media-library URL (multi-select, unlimited cardinality, custom opener), the edit-dialog URL,
  the preview URL, the list of gallery types, and the default type. JS source lives under
  `js/ckeditor5_plugins/mediagallery/src/` (built to `js/build/mediagallery.js`).
- **Front-end side** — text filter `ckeditor_media_gallery` ("Embed image galleries",
  `Plugin/Filter/FilterGallery`, `TYPE_TRANSFORM_REVERSIBLE`, weight 100) parses `<drupal-gallery>`
  nodes and replaces each with rendered markup. `js/gallery.frontend.js` wires up featured/carousel
  interactivity and the pluggable lightbox drivers.
- **Shared renderer** — `GalleryBuilder` (service `ckeditor_media_gallery.builder`) builds the render
  array (`#theme ckeditor_media_gallery`) used by BOTH the filter and the in-editor preview, so the
  editor preview matches the page. Template: `templates/ckeditor-media-gallery.html.twig` with
  per-type suggestions `ckeditor_media_gallery__TYPE`.

## Routes, controllers, opener

- `ckeditor_media_gallery.dialog` → `/ckeditor-media-gallery/dialog/{filter_format}`
  (`Form/GalleryDialogForm`): drag-to-reorder / remove-images / edit-heading dialog; access
  `_entity_access: filter_format.use`.
- `ckeditor_media_gallery.preview` → GET `/ckeditor-media-gallery/preview/{filter_format}`
  (`Controller/GalleryPreviewController::preview`): server-rendered widget preview; access
  `_entity_access: filter_format.use` + custom check that the format actually enables the gallery
  filter.
- `CKEditorMediaGalleryOpener` (service tagged `media_library.opener`): returns **all** selected
  media UUIDs (order preserved) instead of a single item; `checkAccess()` requires `filter_format`
  `use` access AND the gallery filter enabled.

See [api/routes-and-controllers.md](api/routes-and-controllers.md).

## Pluggable definitions

Two YAML-discovery managers (both instances of `GalleryPluginManager`, service ids
`…gallery_type_manager` / `…lightbox_manager`) load definition-only plugins from
`<module>.ckeditor_media_gallery_types.yml` and `<module>.ckeditor_media_gallery_lightboxes.yml`,
alterable via `hook_ckeditor_media_gallery_types_alter()` /
`hook_ckeditor_media_gallery_lightboxes_alter()`. Shipped types: `featured`, `masonry`, `carousel`,
`grid`. Shipped lightboxes: `glightbox`, `none`. See
[plugins/gallery-types-and-lightboxes.md](plugins/gallery-types-and-lightboxes.md).

## Configuration

All configuration is per-text-format filter settings (no admin permission of its own beyond
`administer filters`). Config schema `filter_settings.ckeditor_media_gallery`. See
[config/filter-settings.md](config/filter-settings.md).

## Hooks / install

- `hook_theme()`, `hook_theme_suggestions_HOOK()`, `hook_help()` in `.module`.
- **No** `.install`, **no** `.permissions.yml`, no Drush commands.
- Tests: `tests/src/Kernel/FilterGalleryTest.php`, `tests/src/FunctionalJavascript/GalleryEditorTest.php`.
