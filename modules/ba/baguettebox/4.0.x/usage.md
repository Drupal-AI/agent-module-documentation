<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
BaguetteBox is a core-image field formatter that renders each image as a link into a swipe/touch-enabled baguetteBox.js lightbox gallery.

---

The module adds a single field formatter (`baguettebox`, label "BaguetteBox") for the core `image` field type, subclassing core's own `ImageFormatter`. On **Manage display** you pick the formatter and set: a thumbnail **Image style**, a **default lightbox image style** (`baguette_image_style`), up to five **responsive lightbox breakpoints** (`baguette_image_style_responsive`, each a `width` + image style rendered into `data-at-{width}` attributes on the link so baguetteBox.js can swap sources by viewport), a CSS **selector** that decides which container becomes a gallery (default `.baguettebox`; change it to a field wrapper class to pool media-reference images into one gallery), an **animation** (`slideIn` / `fadeIn` / none), a **captions source** (`none` / image `title` / image `alt`), and booleans for **buttons**, **fullscreen**, **hide scrollbars** and **inline** display. Each rendered item is a `<a data-at-… href="{lightbox url}">{thumbnail image}</a>` (theme hook `baguettebox_formatter`, template `baguettebox-formatter.html.twig`, preprocessed by reusing core's image-formatter preprocess). The whole settings array is attached to `drupalSettings.baguettebox`, the `baguettebox/formatter` library is attached (which depends on the external `baguettebox/baguettebox` library — the `feimosi/baguetteBox.js` v1.11.1 files you must place at `/libraries/baguettebox.js/baguetteBox.min.js` and `.css`; a runtime requirements check errors if missing), and `js/baguettebox.js` calls `baguetteBox.run(selector, …)` in a `Drupal.behaviors` attach. Captions are passed through `Drupal.checkPlain()` before display. There is no admin settings route, no permissions, no Drush commands, no submodules — all configuration lives on the formatter instance. Core requirement is `^11.3 || ^12`; depends only on core `image`. A `post_update` hook backfills the `selector` setting (`.baguettebox`) onto existing displays.

---

- Open image-field images in a swipe/touch lightbox gallery.
- Add a jQuery-free, dependency-light lightbox to a site.
- Turn a multi-value image field into a click-to-enlarge gallery.
- Serve a small thumbnail but a larger derivative inside the lightbox.
- Swap the lightbox image by viewport using responsive width breakpoints.
- Pool all images of a media-reference field into one gallery via a custom selector.
- Show product photography large without leaving the page.
- Display a portfolio or exhibition of images.
- Show property-listing or real-estate photos at full size.
- Present press or media-kit images for full-size viewing.
- Add captions to lightbox images sourced from each image's alt or title.
- Choose slide, fade, or no open animation for the lightbox.
- Give the gallery next/prev buttons, fullscreen, and scrollbar hiding.
- Support mobile-first, touch-navigable image browsing.
- Replace a heavier lightbox module (Colorbox, PhotoSwipe) with a lighter one.
- Attach the lightbox to Views-rendered image fields via the `baguettebox` class.
- Render galleries inline (side-by-side thumbnails) with the inline option.
- Keep initial page weight low by loading full images only on open.
- Build a simple image viewer without writing custom JS.
- Use the same formatter across content types and view modes.
- Link each thumbnail to an original or styled derivative for the overlay.
