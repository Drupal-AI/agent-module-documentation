<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
TinyPNG integrates Drupal's image handling with the external TinyPNG/Tinify compression API, either compressing every image on upload or compressing the derivatives of image styles you flag for it.

---

TinyPNG uses the `tinify/tinify` PHP library to send images to the TinyPNG web service for smart lossy PNG/JPEG compression, then stores the smaller result back on the site. It is configured on one settings form (`/admin/config/tinypng`, route `tinypng.settings.form`, permission `administer tynipng`) writing the `tinypng.settings` config: an `api_key` (required — get it from tinypng.com/developers), an `on_upload` toggle to compress every uploaded image via `hook_entity_presave()`, an `upload_method` of `upload` (send the bytes — needed on localhost) or `download` (give TinyPNG a public URL to fetch — needs an internet-reachable site), and an `image_action` toggle. When `image_action` is on **and** an API key is set, the module adds a **"Compress with TinyPNG"** checkbox to each image style's edit form; enabling it stores a third-party setting `image.style.<name>.third_party.tinypng.tinypng_compress: true`, and a route subscriber replaces the image-style derivative download route so those derivatives are compressed through TinyPNG when generated. Services `tinypng.compress` (the `TinyPng` API wrapper) and `tinypng.image_handler` do the work. The module has no Drush commands and no plugin types; it depends on core `image` and a paid/free-tier TinyPNG API key (500 compressions/month free). Without a valid key nothing is compressed.

---

- Automatically compress every image a content editor uploads to the site.
- Shrink PNG file sizes with smart lossy compression to speed up page loads.
- Compress JPEG images through the TinyPNG/Tinify service.
- Flag a specific image style (e.g. a large hero style) so its derivatives are compressed.
- Reduce bandwidth and storage costs for image-heavy sites.
- Use the "upload" method to compress images while developing on localhost.
- Use the "download" method so TinyPNG fetches images by URL on a public production site.
- Set the TinyPNG API key once at /admin/config/tinypng and apply it site-wide.
- Enable compression only for chosen image styles rather than all uploads.
- Improve Core Web Vitals / Lighthouse image-weight scores.
- Compress responsive-image style derivatives to serve smaller variants.
- Gate access to the compression settings with the "administer tynipng" permission.
- Turn off on-upload compression but still compress selected image-style derivatives.
- Compress thumbnails generated for a media library.
- Optimize product images in a commerce catalog to reduce load time.
- Add TinyPNG compression to an existing image style without recreating it.
- Programmatically compress an image via the tinypng.compress service in custom code.
- Keep original uploads untouched while compressing only rendered style derivatives.
- Batch-optimize newly uploaded article images automatically on save.
- Compress user avatar images on upload.
- Lower CDN egress by shipping smaller image derivatives.
- Standardize image optimization across content types via image styles.
- Free-tier friendly: cap monthly compressions by only flagging high-traffic styles.
- Swap in TinyPNG compression as a step in an image-style pipeline.
- Reduce the size of images embedded in newsletters or exported PDFs.
