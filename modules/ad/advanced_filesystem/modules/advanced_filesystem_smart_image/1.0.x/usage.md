Advanced Filesystem: Smart Image generates on-demand, adaptive image derivatives from a single URL endpoint (`/adfs/image`), with a GD-based transform pipeline, HTTP caching, presets, optional signed URLs, Twig helpers and Drush tooling.

---

Smart Image is a submodule of Advanced FileSystem that turns Drupal into a self-hosted, Imgix/Cloudinary-style image service. Point an `<img>` at `/adfs/image?src=public://photo.jpg&w=800&fmt=webp` and it resizes, crops, formats and caches the result on the fly. Transformations are supplied as query parameters (or bundled into named presets) and executed by a weighted `ImageTransform` plugin pipeline: resize/crop with focal point and gravity, pad/border, rotate/flip, pixel filters (grayscale, sepia, brightness, contrast, blur, sharpen) and watermark overlay. Output can adapt to the browser's `Accept` header (`fmt=auto` → AVIF/WebP/JPEG) with per-format quality, and every derivative is written to a two-level cache directory and served with immutable `Cache-Control`, `ETag`/`Last-Modified` and `304 Not Modified` support. A Twig extension adds `|adfs_image`, `|adfs_srcset`, `|adfs_blurhash` and `|adfs_lqip` filters for responsive markup and low-quality placeholders. Cron prunes old derivatives, and Drush commands pre-build, warm up, purge, inspect and (when signing is enabled) sign derivative URLs. It requires the PHP GD extension and the `advanced_filesystem` base module.

---

- Serve a resized WebP hero image straight from a URL: `/adfs/image?src=public://hero.jpg&w=1920&fmt=webp`.
- Generate square, center-cropped avatars or thumbnails with `fit=crop` and `w=h`.
- Produce responsive `srcset` markup automatically in Twig with `{{ uri|adfs_srcset([400, 800, 1200], {fmt: 'webp'}) }}`.
- Emit modern formats (AVIF/WebP) with automatic fallback to JPEG based on the visitor's browser using `fmt=auto`.
- Add a compact inline BlurHash or base64 LQIP placeholder while the full image loads (`|adfs_blurhash`, `|adfs_lqip`).
- Crop around a subject using a normalized focal point (`fp_x`, `fp_y`) so faces or products stay in frame.
- Anchor crops to a compass gravity (`gravity=north`, `southeast`, etc.) instead of always centering.
- Letterbox product images to an exact canvas size with a background color using `fit=fill&bg=ffffff`.
- Overlay a brand logo watermark at a chosen corner, opacity and size (`wm`, `wm_pos`, `wm_opacity`, `wm_w`).
- Add a solid-color border or padding around an image with `pad` / `pad_x` / `pad_y` and `bg`.
- Apply artistic filters on the fly: grayscale, sepia, brightness, contrast, Gaussian blur and sharpen.
- Rotate or flip images (`rotate=90`, `flip=horizontal`) without pre-processing source files.
- Define reusable named presets (thumbnail, medium, hero) so templates reference `preset=thumbnail_small` instead of long parameter lists.
- Cache-warm an entire library ahead of a launch with `drush adfs:image:warmup --widths=400,800,1200 --fmt=webp`.
- Pre-generate a preset for all managed images with `drush adfs:image:prebuild --preset=thumbnail_small`.
- Inspect cache size and file count with `drush adfs:image:stats`.
- Invalidate derivatives for one file or a whole folder after replacing an image with `drush adfs:image:purge --src="public://old/*"`.
- Let cron automatically delete derivatives older than a configured number of days.
- Restrict which stream-wrapper schemes may be used as sources (e.g. `public`, `private`) from the settings form.
- Require HMAC-SHA256 signed URLs so only your application can request derivatives, minting tokens with `drush adfs:image:token`.
- Serve highly cacheable, CDN-friendly images with immutable caching headers and conditional-request (304) support.
- Cap the maximum input megapixels to guard against decompression-bomb source files.
- Replace multiple pre-baked core image styles with a single flexible endpoint that produces any size or format from one source file.
