<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ImageAPI Optimize WebP adds a "WebP Deriver" processor to the ImageAPI Optimize (Image Optimize) module: when added to an image optimize pipeline, it creates a `.webp` copy of each styled image derivative and serves it to browsers that support WebP.

---

The module provides an `ImageAPIOptimizeProcessor` plugin with id `imageapi_optimize_webp` (label "WebP Deriver") that clones a styled image to a `.webp` file using PHP's `imagewebp()` at a configurable `quality` (default 75). You add this processor to an ImageAPI Optimize pipeline, then assign that pipeline to individual image styles or as the site-wide default. To make the derivatives usable, the module overrides the pipeline entity class (so the generated `.webp` is copied to the right directory), overrides the `image.style_public` / `image.style_private` route controller (so a request for `<derivative>.webp` finds the source image, generates the normal derivative, and returns the `.webp` version when it exists), and deletes the `.webp` alongside the normal derivative on `hook_image_style_flush()`. It requires the ImageAPI Optimize module and has no settings page of its own — all configuration is done through Image Optimize pipelines. The optional **ImageAPI Optimize WebP Responsive** submodule extends this to core Responsive Image fields by adding `<source type="image/webp">` entries. Note the WebP file is generated as an extra file next to the original derivative (e.g. `image.jpg.webp`); the theme/browser negotiates which to use.

---

- Serve smaller WebP versions of styled images to modern browsers for faster pages.
- Add a "WebP Deriver" processor to an existing Image Optimize pipeline.
- Set a site-wide default pipeline that produces WebP for every image style.
- Assign a WebP-producing pipeline to a specific image style only.
- Control WebP compression by setting the processor's quality (1–100, default 75).
- Reduce image payload / improve Core Web Vitals (LCP) without changing markup manually.
- Generate `.webp` derivatives on the fly the first time a styled image is requested.
- Automatically clean up `.webp` files when an image style is flushed.
- Combine WebP with other Image Optimize processors (resmush.it, binaries) in one pipeline.
- Provide WebP sources for responsive images via the WebP Responsive submodule.
- Keep original JPEG/PNG derivatives as fallbacks while adding WebP.
- Improve bandwidth costs on image-heavy catalogs or galleries.
- Deliver WebP from both public and private file schemes (route controller override).
- Roll out next-gen image formats site-wide with a single pipeline configuration.
- Test different WebP quality settings per pipeline for size/quality trade-offs.
- Optimize hero and banner images to WebP for landing pages.
- Support WebP for media image fields that use image styles.
- Add WebP output to an existing optimization workflow without custom code.
- Ensure WebP derivatives live in the correct style directory via the pipeline wrapper.
- Serve WebP transparently through Drupal's image derivative URLs.
- Lower CDN and storage transfer for frequently viewed images.
