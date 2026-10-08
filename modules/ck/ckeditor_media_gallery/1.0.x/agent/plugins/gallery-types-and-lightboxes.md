<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Pluggable gallery types & lightboxes, and the render pipeline

## GalleryPluginManager (YAML discovery)

`src/GalleryPluginManager.php` is a lightweight, definition-only plugin manager built on
`Core\Plugin\Discovery\YamlDiscovery`. It is instantiated **twice** in `services.yml` with
different discovery names:

- `ckeditor_media_gallery.gallery_type_manager` → name `ckeditor_media_gallery_types`.
- `ckeditor_media_gallery.lightbox_manager` → name `ckeditor_media_gallery_lightboxes`.

Any module/theme provides definitions in `<module>.ckeditor_media_gallery_types.yml` /
`<module>.ckeditor_media_gallery_lightboxes.yml`. Each definition has at least `label` (translated
via `t()` in `getOptions()`) and an optional `library` (attached when the type/lightbox is used).
Definitions can be modified with `hook_ckeditor_media_gallery_types_alter()` /
`hook_ckeditor_media_gallery_lightboxes_alter()` (the discovery name doubles as the alter hook
name). Definitions are statically cached per request.

### Shipped definitions

- Types (`ckeditor_media_gallery.ckeditor_media_gallery_types.yml`): `featured` (large image +
  thumbnails), `masonry` (CSS-columns grid), `carousel` (scroll-snap slider), `grid` (uniform
  cropped grid). None of the shipped types declare a `library`.
- Lightboxes (`ckeditor_media_gallery.ckeditor_media_gallery_lightboxes.yml`): `glightbox` →
  library `ckeditor_media_gallery/glightbox`; `none` → link straight to the image file.

## GalleryBuilder — the shared renderer

`src/GalleryBuilder.php` (service `ckeditor_media_gallery.builder`) is used by BOTH the filter and
the preview controller, guaranteeing identical markup.

- `build($uuids, $settings, $type, $title)`: falls back to `featured` for an unknown type; loops
  UUIDs via `entityRepository->loadEntityByUuid('media', …)`, adds each media as a cacheable
  dependency, and **skips items whose `access('view')` is not allowed**. Empty result renders to
  `#markup => ''` but keeps cacheability. Chooses libraries (`gallery.frontend`, the type's
  library, the lightbox's library) via `BubbleableMetadata` before `applyTo()`.
- `buildItem()`: resolves the media source field; branches on video (`oembed` remote video uses the
  source-field value as `full_url`; local video uses the file URL; thumbnail from the media
  `thumbnail` field) vs. image (file URI → `full_url`, optionally through `lightbox_image_style`).
  Caption/copyright are read from the configured fields and **`strip_tags()`'d**.
- `buildDerivedImage()`: emits `#type responsive_image` for a `responsive:` style (when
  `responsive_image` is enabled and the style loads), else `#theme image_style` for a valid image
  style, else a plain `#theme image`; all with `loading="lazy"`.

## Template & front-end JS

- `templates/ckeditor-media-gallery.html.twig` renders per type; auto-escaped Twig output. Item
  data (`full_url`, `caption`, `copyright`, `alt`) is emitted into `data-*` attributes and the
  `href`. Per-type theme suggestions: `ckeditor_media_gallery__<type>`.
- `js/gallery.frontend.js`: `Drupal.behaviors.ckeditorMediaGallery` wires thumbnail swapping and
  carousel navigation, and drives the lightbox through a registry
  `Drupal.ckeditorMediaGallery.lightboxes` (GLightbox driver shipped; others can register their
  own before the behavior runs). Caption is emitted through `Drupal.checkPlain()` and copyright
  through `Drupal.t('Photo: @copyright', …)`, both of which escape (on top of the PHP-side
  `strip_tags`).

## Editor-side JS (build)

`js/ckeditor5_plugins/mediagallery/src/` (index → `MediaGallery`): `galleryediting.js` defines the
`drupalGallery` model element and up/down casts to `<drupal-gallery data-media-uuids …>`;
`gallerytoolbar.js`/`galleryui.js` provide the widget toolbar (switch type, reorder dialog, add
images); `insertgallerycommand.js`/`updategallerycommand.js`/`setgallerytypecommand.js` are the
commands. Built artifact: `js/build/mediagallery.js` (library `gallery`).
