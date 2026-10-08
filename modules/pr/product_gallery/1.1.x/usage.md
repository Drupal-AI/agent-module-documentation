<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Product Gallery provides field formatters that turn an image field, or a media (entity reference) field, into an interactive product-style gallery: a main image with a thumbnail strip, mouse-wheel zoom, and a hover magnifier.

---

Two formatters are shipped — `product_gallery_field_formatter` for core `image` fields and `product_gallery_mfield_formatter` (Media Product Gallery) for `entity_reference` fields pointing at Remote-video-style media (it resolves the media source file and only renders MIME types beginning `image/`). Both build a `product_gallery` theme element, attach the `product_gallery` library (jQuery/Drupal/drupalSettings/once) and an `xzoom`-based JS layer, and pass generated image-style URLs plus a large set of display options through `drupalSettings`. The formatter settings form exposes responsive image styles (large/medium/small + thumbnail), thumbnail border shape/width/colour, overlap behaviour and threshold, mouse-wheel zoom toggle, default zoom scale, magnifier toggle, custom image and wrapper classes, and a container max-width with unit. The image-style select elements are only shown to users with `administer image styles`.

It's a pure display/formatter module: no routes, permissions, services, or config entities of its own; settings live on the field display config. Note the code emits image paths (via `parse_url(...)['path']` and image-style `buildUrl`) into markup and drupalSettings; there is no server-side fetching of remote URLs and no user-supplied URL is dereferenced, so there is no SSRF surface. Setup: place images/media on a content type, then on Manage display choose the Product Gallery (or Media Product Gallery) formatter and configure image styles, thumbnails, zoom and magnifier options.
---
- Turn a multi-value image field into a product gallery with thumbnails
- Render a media reference field as an image gallery
- Enable mouse-wheel zoom on product photos
- Show a hover magnifier lens over the main image
- Set the default zoom scale for the loaded image
- Pick separate image styles for large, medium and small screens
- Apply a dedicated thumbnail image style
- Choose round or square thumbnail borders
- Set thumbnail width from 20px to 140px
- Set a custom thumbnail border colour (hex/rgb/hsl/named)
- Enable an overlapping thumbnail layout for dense galleries
- Only overlap thumbnails past a configurable count threshold
- Add a custom CSS class to the gallery image
- Add a custom CSS class to the image wrapper
- Constrain the gallery container width with px/em/rem/% units
- Build an e-commerce style product image viewer
- Restrict image-style selection to users with administer image styles
- Serve responsive styled derivatives per breakpoint
- Filter a media gallery to image MIME types only
- Present a main-image-plus-thumbnails viewer on product pages
