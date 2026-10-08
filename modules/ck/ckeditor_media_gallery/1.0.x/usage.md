<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds an image-gallery button to CKEditor 5: editors multi-select images from the core Media Library and insert a gallery, stored inline as one `<drupal-gallery>` element and rendered on the front end by a text filter with switchable display types and a fullscreen lightbox.

---

CKEditor Media Gallery lets editors place photo galleries at any position inside body text without extra entities. Clicking the "Image gallery" toolbar button opens the core Media Library in multi-select mode (a custom `media_library.opener` that returns every selection, in order); the plugin writes the chosen media UUIDs, gallery type and optional heading into a single `<drupal-gallery data-media-uuids="…" data-gallery-type="…" data-gallery-caption="…">` element. The "Embed image galleries" text filter (`FilterGallery`) parses that element and replaces it with rendered markup via a shared `GalleryBuilder`; the same builder powers an in-editor preview endpoint so the widget looks like the finished page. Four display types ship — featured (large image + thumbnail strip), masonry, carousel, and uniform grid — switchable per gallery from the widget toolbar, and both the display types and the lightbox are YAML-discovered pluggable definitions other modules can extend. A fullscreen lightbox (GLightbox by default, loaded from the jsDelivr CDN) shows per-image captions and copyright pulled from configurable media fields; captions/copyright never appear inline. Everything is configured per text format (allowed media types, default type, image/responsive-image styles, view mode for the large image, lightbox behaviour, caption/copyright field names). Video media (remote oembed or local) is supported with an inline play badge and lightbox playback. The module adds no content types, entities, permissions, install hooks, or Drush commands.

---

- Insert a multi-image gallery inside CKEditor 5 at any point in the text, picking images from the Media Library.
- Store the gallery as a single portable `<drupal-gallery>` element rather than as separate entities.
- Preserve the editor's selection order when building the gallery.
- Switch a gallery's display type (featured / masonry / carousel / grid) from the widget toolbar per gallery.
- Reorder or remove images via a drag-and-drop dialog, and add more images to an existing gallery.
- Give a gallery an optional heading shown above it.
- Render an in-editor preview that uses the same template/CSS as the front end.
- Show a fullscreen lightbox (GLightbox) with captions and copyright drawn from configurable media fields.
- Serve GLightbox locally by overriding the `ckeditor_media_gallery/glightbox` library.
- Configure allowed media types, default gallery type, image styles (or responsive image styles), the large-image view mode, and lightbox loop/zoom per text format.
- Support video media (YouTube/Vimeo oembed and local files) with a play badge and lightbox playback.
- Register custom gallery display types via `<module>.ckeditor_media_gallery_types.yml` (+ `_alter` hook).
- Register custom lightbox integrations via `<module>.ckeditor_media_gallery_lightboxes.yml` (+ `_alter` hook).
- Override markup with `ckeditor-media-gallery.html.twig` or per-type suggestions `ckeditor_media_gallery__TYPE`.
- Restrict galleries to specific text formats by enabling the filter and adding the toolbar button only there.
