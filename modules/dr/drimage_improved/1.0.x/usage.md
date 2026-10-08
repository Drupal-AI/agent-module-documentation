Drimage (drimage_improved) is a "Dynamic Responsive Image" field formatter that generates image styles on the fly, sized to the exact space each image occupies in the browser, so you never have to configure or maintain responsive image styles by hand. It is a maintained fork/successor of the original `drimage` module.

---

Instead of pre-defining breakpoints, the `drimage_improved` image field formatter renders a placeholder whose real dimensions are measured client-side by `js/drimage_improved.js`; the JS then requests `/drimage/{width}/{height}/{fid}/{iwc_id}/{format}`. `DrImageController` (extending core's `ImageStyleDownloadController`) delegates to `DrimageManager`, which finds or **creates** an image style named `drimage_improved_<w>_<h>` (with `image_scale` for scale-only, or `image_scale_and_crop`/`focal_point_scale_and_crop` when a height is set), then delivers the derivative. Requested sizes are meant to be quantised by JS to a grid controlled by global settings at `/admin/config/media/drimage_improved`: `upscale` (min width, default 320), `downscale` (max width, default 3840), `threshold` (min px difference between generated styles, default 200), `ratio_distortion` (allowed aspect-ratio reuse), plus WebP conversion (`core_webp`, on by default), an optional `fallback_style`, a CSS placeholder colour/image, and cache max-age. The formatter offers image-handling modes (scale, fixed aspect-ratio crop, background image, container size, and — when `image_widget_crop` is present — IWC crop). Optional integrations: `focal_point` (focal-aware crops), `image_widget_crop` (named crop types via the `iwc_id` route arg), `automated_crop`, and `imageapi_optimize_webp`. Event subscribers handle config changes, stage_file_proxy, and redirect/path processing; a Drush command `drimage_improved:delete-styles` bulk-deletes generated styles; `hook_drimage_improved_image_style_alter()` and `hook_drimage_improved_proxy_cache_periods_alter()` are provided. A `drimage_s3fs` submodule adapts delivery for S3-stored files.

---

- Render an image field responsively without configuring any responsive image styles.
- Serve each image at (close to) the exact pixel size it occupies on the page.
- Automatically generate and reuse image styles per requested dimension.
- Cap generated widths with a max (`downscale`) and floor them with a min (`upscale`).
- Limit how many distinct image styles get created via the `threshold` px setting to save disk.
- Reuse a near-matching aspect ratio style within an allowed `ratio_distortion` instead of creating a new one.
- Deliver modern WebP derivatives automatically through core's image toolkit (`core_webp`).
- Lazy-load images with a configurable viewport `lazy_offset`.
- Show a solid-colour or image placeholder while the real image loads.
- Crop to a fixed aspect ratio (e.g. 16:9) chosen on the formatter settings form.
- Use an image as a CSS background sized to its container (background image handling mode).
- Size images to their container rather than the image's own ratio (container-size mode).
- Integrate focal_point so on-the-fly crops respect the focal point.
- Use image_widget_crop named crop types per image via the `iwc_id` route parameter.
- Apply automated_crop providers to on-the-fly crops.
- Provide a fallback image style for error / out-of-range cases.
- Serve device-pixel-ratio-aware images via the `multiplier` setting.
- Replace core's Responsive Image module with a zero-config alternative.
- Bulk-delete all generated drimage image styles with `drush drimage_improved:delete-styles`.
- Delete generated styles for a specific crop type only (`--crop-type`).
- Alter every auto-generated image style in code via `hook_drimage_improved_image_style_alter()`.
- Adjust proxy cache periods via `hook_drimage_improved_proxy_cache_periods_alter()`.
- Serve drimage derivatives for images stored on Amazon S3 via the `drimage_s3fs` submodule.
- Optimize WebP output through the imageapi_optimize_webp module.
- Link the rendered image to its content or file.
