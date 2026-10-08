<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
lightGallery integrates the lightGallery 2.x JavaScript lightbox library with Drupal image and media fields, providing thumbnail-grid field formatters that open a swipeable lightbox gallery.

---

lightGallery integrates the lightGallery 2.x JavaScript lightbox library with Drupal image and media fields. It ships an image field formatter (`image_lightgallery_thumbnail`) and a media entity-reference formatter (`media_lightgallery_thumbnail`) that render a clickable thumbnail grid opening a lightbox, each with configurable thumbnail and gallery image styles, lazy/eager loading, optional inline display, captions (image title or a media view mode), and a raw JSON field for any lightGallery setting or plugin. A reusable `lightgallery` theme hook plus asset libraries let developers build custom galleries, and a settings form stores the required lightGallery license key.

---

- Add a lightbox gallery to an image field.
- Show a media gallery of images and videos in a lightbox.
- Build a photo gallery from a multi-value image field.
- Display product images as a clickable thumbnail grid.
- Open article media in a full-screen lightbox.
- Present a portfolio with swipe navigation on mobile.
- Use image styles for both thumbnails and the full lightbox image.
- Lazy-load gallery thumbnails for performance.
- Show image titles as lightbox captions.
- Render a media view mode as a gallery caption.
- Include YouTube/Vimeo/oEmbed videos in a media gallery.
- Play uploaded video files inside the lightbox.
- Render an inline (always-open) gallery on a page.
- Enable lightGallery plugins like thumbnails, zoom, autoplay, fullscreen, share, or rotate.
- Pass arbitrary lightGallery settings as JSON per display.
- Set the site-wide lightGallery license key.
- Restrict who can change lightGallery configuration with a dedicated permission.
- Build a bespoke gallery from a render array via the `lightgallery` theme hook.
- Reuse the initialised lightGallery instance from custom JavaScript.
- Auto-open an inline gallery for a slideshow-style display.
- Add captions to gallery images.
- Provide a gallery formatter without writing JavaScript.
- Attach only the lightGallery plugin libraries a display actually needs.
- Style thumbnails with the module's thumbnail CSS.
- Show responsive image-styled galleries across breakpoints.
