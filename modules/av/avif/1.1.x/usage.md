<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Avif serves AVIF copies of core image-style derivatives to browsers that accept the format, while every other browser keeps the original derivative — a smaller download for supporting clients with no change to your image styles.

---

Drupal's image system produces one derivative per image style, in the source format. This module bolts AVIF onto that pipeline in two places. An event subscriber (`avif.route_subscriber`) repoints the core `image.style_public` route at its own `ImageStyleDownloadController`, which wraps the core controller and only diverges when the requested `?file=` ends in `.avif` and the request `Accept`s `image/avif`; in that case it lets the unmodified core controller resolve, access-check, and generate the source derivative, then produces an AVIF copy next to it (`<derivative>.avif`) and returns it. A responsive-image preprocess (`avif_preprocess_responsive_image`) injects an extra `<source type="image/avif">` ahead of each existing source, with the srcset URLs rewritten by `Avif::getAvifSrcset()`, so a `<picture>` element offers AVIF first and falls back automatically. Encoding is pluggable through the `AvifProcessor` plugin type (manager `plugin.manager.avif_processor`); the one shipped plugin, `imagemagick`, delegates to the contrib `drupal/imagemagick` toolkit's `convert` operation — GD and CAVIF are named on the project page but not shipped. A settings form at `/admin/config/media/avif` chooses the `processor` and `quality` (config object `avif.settings`, quality default 60). Because AVIF is delivered through responsive-image styles, fields must use a Responsive image formatter to benefit; a plain Image formatter emits a single `<img>` and no AVIF source. A per-URI lock avoids double-encoding, returning HTTP 503 while a copy is being generated. The dependency is core `image` alone, plus a runtime toolkit that can encode AVIF; core requirement is `^10.3 || ^11` and the newest release on this branch is 1.1.0-rc1.

---

- Serve smaller images to browsers that support AVIF.
- Cut page weight without changing existing image styles.
- Improve Core Web Vitals / Largest Contentful Paint.
- Generate an AVIF variant alongside each responsive-image derivative.
- Reduce bandwidth costs on an image-heavy site.
- Keep JPEG/PNG fallbacks for Safari and other non-AVIF clients.
- Pick the encoder backend via the AvifProcessor plugin type.
- Encode through the ImageMagick toolkit already on the server.
- Add a custom encoder plugin (e.g. a CLI encoder) for your host.
- Tune AVIF quality centrally from one settings form.
- Apply AVIF to selected responsive image styles.
- Speed up a gallery or media-listing page.
- Improve mobile load times on slow connections.
- Compress hero images more aggressively than JPEG allows.
- Add modern-format delivery without a third-party CDN image service.
- Serve AVIF from Drupal itself rather than an edge transform.
- Complement existing responsive image breakpoints.
- Reduce storage/transfer pressure from large derivatives.
- Warm derivatives ahead of traffic to avoid request-time encode cost.
- Roll AVIF out per display without touching content types' data.
- Integrate with Blazy (its `data-srcset` sources are rewritten too).
