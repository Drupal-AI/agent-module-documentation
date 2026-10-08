<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ImageAPI Optimize GD adds a "GD" processor to the ImageAPI Optimize (Image Optimize) module that re-compresses JPEG and WebP derivative images at a configurable quality percentage using PHP's built-in GD library — no external binaries required.

---

The module ships a single `ImageAPIOptimizeProcessor` plugin (`id: imageapi_optimize_gd`, label "GD") that you add to an Image Optimize *pipeline* (`imageapi_optimize_pipeline` config entity). When an image style generates a derivative, the pipeline runs its processors in weight order; the GD processor re-opens the derivative through Drupal's `image.factory` with the `gd` toolkit and re-saves it via PHP's native `imagejpeg()` / `imagewebp()` at the quality you set. It only touches files whose MIME type is in its configured `file_types` list (JPEG and/or WebP) and silently skips everything else; if PHP is compiled without GD (`imagegd2()` missing) it logs a notice and does nothing. The processor is configurable: `quality` (1–100, default 75) and `file_types` (default `['image/jpeg']`). The recommended pattern is to set the sitewide GD toolkit to 100% quality and let ImageAPI Optimize pipelines own per-style quality, so crop/scale/overlay effects stay separate from compression. The module has no admin route, no permissions, no Drush commands, and no schema of its own — all configuration lives on the pipeline entity it plugs into.

---

- Re-compress JPEG image-style derivatives to a smaller file size at a chosen quality (e.g. 75%).
- Add WebP quality control to a pipeline so generated `.webp` derivatives are compressed consistently.
- Separate image compression from crop/scale/overlay by keeping the GD toolkit at 100% and letting pipelines handle quality.
- Build a "high quality" pipeline (quality 90) for hero images and a "thumbnail" pipeline (quality 60) for small teasers.
- Apply a sitewide default Image Optimize pipeline that compresses every image style with GD.
- Attach a specific pipeline to a single image style so only that style is re-compressed.
- Reduce page weight and improve Core Web Vitals by shrinking JPEG derivatives without installing jpegoptim/optipng binaries.
- Provide image optimization on managed hosting where you cannot install command-line optimizer binaries.
- Standardise JPEG quality across a multisite platform via exported pipeline config.
- Combine GD compression with other ImageAPI Optimize processors (e.g. reSmush.it, WebP) in one pipeline.
- Lower storage and CDN egress costs by serving lighter derivative images.
- Tune quality per environment by overriding the pipeline's processor `data.quality` in settings.
- Compress both JPEG and WebP in a single processor instance by enabling both file types.
- Recompress existing derivatives by flushing image styles after changing the quality.
- Give editors predictable output sizes regardless of the quality of the originals they upload.
- Ensure retina/2x responsive image variants are compressed the same way as their 1x counterparts.
- Deploy a pure-PHP optimizer as a fallback when binary-based optimizers are unavailable.
- Keep image optimization entirely in-process (no shell-out) for security-restricted hosts.
- Migrate legacy sites to pipeline-based optimization without changing their image styles.
- Cap the quality of user-uploaded JPEGs shown on the site while leaving the originals untouched.
