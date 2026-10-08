<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GLightbox integrates the pure-JavaScript GLightbox library into Drupal, adding image field formatters that open images (and videos, via Plyr) in a responsive lightbox popup with optional galleries, captions, zoom, and transition effects. It is configured globally and per image field.

---

The module ships two image field formatters — **`glightbox`** and **`glightbox_responsive`** (the latter uses responsive image styles) — that render a thumbnail linking to the full image opened in a GLightbox modal. A global settings form at `/admin/config/media/glightbox` (route `glightbox.admin_settings`, permission `administer site configuration`) writes the `glightbox.settings` config object, grouped into `custom` (open/close/slide effects, width/height, loop, zoomable, draggable, "See more" caption threshold, description position…), `advanced` (unique gallery token, minified vs source assets), and `plyr` (video player controls and options). Per-formatter settings control the lightbox image style, gallery grouping (all items in one gallery or per-item, with a custom token), and caption/description sources. Galleries are grouped via `GalleryIdHelper` (token-aware). A lightbox can be suppressed on a given request with `?glightbox=no` (checked by the `glightbox.activation_check` service), and the library assets are attached by `glightbox.attachment`, preferring locally-installed libraries (in `/libraries`) over any CDN. The module requires the external GLightbox, DOM Purify, and Plyr JS libraries (declared in composer as `levmyshkin/*`) placed under `/libraries`, and core's Image module. Developers can override any GLightbox JS option with `hook_glightbox_settings_alter()`. A submodule, **GLightbox Inline**, opens arbitrary on-page elements, pages, videos, or images in the lightbox via a `glightbox-inline` link class.

---

- Open a content image in a responsive lightbox popup instead of navigating to the file.
- Build an image gallery from a multi-value image field, navigable inside the lightbox.
- Group all thumbnails of a field into one gallery so users can page through them.
- Play YouTube/Vimeo/MP4 videos in a Plyr-powered lightbox from an image or link field.
- Use responsive image styles in the lightbox via the `glightbox_responsive` formatter.
- Add captions and longer descriptions to lightbox images from other fields.
- Configure open/close/slide transition effects (zoom, fade, slide) site-wide.
- Set lightbox width/height (e.g. 98%) and enable zoom and drag globally.
- Truncate long captions with a "See more" toggle at a configurable character threshold.
- Disable the lightbox on a specific page/request by appending `?glightbox=no`.
- Prefer locally hosted GLightbox/Plyr assets over a CDN for privacy/performance.
- Configure Plyr video controls (play, progress, volume, fullscreen, captions, quality).
- Give each entity's images a unique gallery id so galleries don't merge across nodes.
- Apply a specific image style to the lightbox thumbnail and another to the opened image.
- Present a product photo gallery on commerce product pages.
- Show a portfolio grid where each item opens full-size in a modal.
- Override individual GLightbox options per page with `hook_glightbox_settings_alter()`.
- Sanitize lightbox captions with DOM Purify to strip unsafe markup.
- Open an existing on-page block or hidden div in a popup with GLightbox Inline.
- Load a node/page into the lightbox by URL using GLightbox Inline (`href="/node/42"`).
- Add lightbox behavior to media-reference or paragraph image fields.
- Provide an accessible, dependency-light (no jQuery) lightbox for image-heavy pages.
- Standardize modal image display across many content types via the shared formatters.
