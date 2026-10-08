<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Juicebox integrates the Juicebox HTML5 responsive gallery library with Drupal, rendering image/file fields (and Views results) as a rich, swipeable, fullscreen-capable image gallery.

---

Juicebox exposes its gallery through two entry points: a **field formatter** (`juicebox_formatter`) you attach to an image, file, or media entity-reference field on any entity's display, and a **Views style** (`juicebox`) that turns a View's rows into a single gallery. On render, the module builds a gallery object, emits a Juicebox XML feed at `/juicebox/xml/...`, and attaches the Juicebox JavaScript that draws the responsive gallery client-side. Per-display settings pick the main-image and thumbnail image styles, choose caption/title sources (image alt, title, filename, file description), and expose common Juicebox library options (gallery width/height, colors, buttons, link behavior, incompatible-file handling, plus a manual-config escape hatch). A global settings form at `/admin/config/media/juicebox` controls markup filtering, CORS embedding, interface translation, and the multi-size image-style mapping. The module ships four ready-made image styles (`juicebox_small/medium/large/square_thumb`). The Juicebox JavaScript library itself is downloaded and licensed separately (Lite is free, Pro is paid) and must be placed under `/libraries/juicebox/` for a live gallery to display; config-level setup works without it.

---

- Turn a multi-value image field on an Article (or any content type) into a responsive photo gallery.
- Render a product's image field as a swipeable gallery on a commerce product display.
- Build a portfolio View of images and display all results as one Juicebox gallery via the Views style.
- Show an event's photo album as a fullscreen-capable gallery.
- Use image alt text as gallery captions for accessibility-friendly slideshows.
- Use the image title field as the per-slide title above each caption.
- Use the file filename as a fallback caption when alt/title are empty.
- Render a media entity-reference field (image media) as a gallery instead of a stacked image list.
- Present a real-estate listing's photos as a compact thumbnail-strip gallery.
- Configure separate image styles for the main image vs. the thumbnails to control bandwidth.
- Set a fixed gallery width/height (or 100% responsive) to fit a sidebar or hero region.
- Theme the gallery chrome (background color, text color, thumb frame color) to match a brand.
- Toggle the open/expand/thumbs buttons or render thumbnails as dots for a minimal UI.
- Make each slide link out to the original full-size image or a custom URL, opening in a new tab.
- Skip or icon-link non-image files (PDFs, etc.) mixed into a file field via the incompatible-file action.
- Paste raw Juicebox `config` name/value pairs through the "manual configuration" textarea for Pro-only options.
- Enable CORS so a gallery's XML/embed can be pulled into a remote site.
- Translate the Juicebox interface strings for a multilingual site.
- Add custom parent CSS classes to hook the gallery into a theme's layout.
- Preview a gallery on an unsaved entity using the built-in placeholder image.
- Alter every generated gallery programmatically with `hook_juicebox_gallery_alter()` (e.g. append copyright to captions).
- Swap the gallery-builder class for a future library version with `hook_juicebox_classes_alter()`.
- Drive galleries from Layout Builder blocks that expose an image field display.
- Use the square-thumb image style for a uniform grid of thumbnails regardless of source aspect ratio.
- Reduce per-slide markup by choosing "None (original image)" to serve unstyled source images.
