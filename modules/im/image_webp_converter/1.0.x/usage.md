<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Image WebP Converter converts images already stored on a site into WebP, rewriting each file's stored filename and MIME type and updating the references that point at it, using the `rosell-dk/webp-convert` library with a choice of GD, cwebp, or Imagick.

---

WebP is typically twenty-five to thirty-five percent smaller than an equivalent JPEG at the same visual quality, and images are the majority of most pages' weight, so converting an existing library is one of the larger performance wins available without a redesign. Drupal can already produce WebP **derivatives** through image styles, which covers rendered images and leaves the originals untouched — that is the right approach for most sites and is *not* what this module does. This converts the **source** files in place and updates references, which is heavier and **not reversible**. It offers three conversion paths. A **site-wide batch** (`/admin/config/media/image-webp-converter`, permission `convert images to webp`) queries every managed `image/jpeg` and `image/png` file, converts each, repoints the file entity's URI/filename/MIME to `.webp`, and rewrites image fields, CKEditor `text_with_summary` bodies, and media names that use it. A **per-node** mode (enabled on the settings form) adds a *Convert images to WebP* checkbox to node add/edit forms; on save `hook_entity_presave` walks the node's image fields, `text`/`text_long`/`text_with_summary` fields (rewriting `<img>` src for files under `public://`), and referenced media, converting each. A standalone **upload form** (`/admin/config/media/image-webp-uploader`) converts a single uploaded JPG/PNG and returns a download link. Conversion is done by `WebPConvert::convert()` — the module does **not** shell out to `cwebp` itself; the library handles the back-end. Settings: converter (default `gd`), quality (0–100, default 85), lossless (PNG only), and the per-node toggle; `administer image webp converter` is `restrict access: true`. Plan three things before running the batch: it **edits content** (back up and run on a copy — a missed reference is a broken image, a wrongly rewritten one is a wrong image); **originals are the archive** (converting rather than deriving discards the original permanently); and **external URLs do not update** (an email, PDF, other site, or search index that linked the old filename now points at a file that no longer exists). The module also auto-appends `webp` to the allowed extensions of any image/file field config form.

---

- Convert an existing image library to WebP site-wide.
- Reduce stored image size, not just delivered size.
- Batch-convert every managed JPEG and PNG file.
- Improve page weight on an established site.
- Convert images after a content migration.
- Give editors a per-node opt-in WebP checkbox.
- Convert a single node's image fields on save.
- Convert inline CKEditor body images to WebP.
- Convert images referenced by media entities.
- Offer a one-off upload-and-download WebP conversion tool.
- Choose the GD, cwebp, or Imagick back-end per server.
- Set a global WebP quality level.
- Use lossless WebP encoding for PNG sources.
- Reduce storage and backup size for images.
- Improve Core Web Vitals and Lighthouse image scores.
- Reduce CDN and bandwidth transfer volume.
- Convert product photography in bulk.
- Update stored filenames and MIME types to WebP.
- Rewrite image-field and CKEditor references after conversion.
- Auto-allow the webp extension on image and file fields.
- Modernise an older site's image assets.
- Improve mobile load times on an image-heavy site.
