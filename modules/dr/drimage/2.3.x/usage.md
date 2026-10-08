Drimage (Dynamic Responsive Image) is a field formatter for image fields that generates image styles on the fly, sized to the actual rendered width in the browser, so you never have to configure or maintain responsive image styles by hand.

---

Drimage ships two field formatters — `drimage` (for core `image` fields) and `drimage_uri` (URI variant) — that render an image with front-end JavaScript (`js/drimage.js`) which measures the element's real pixel width, snaps it to a threshold grid, and requests `/drimage/{width}/{height}/{fid}/{iwc_id}/{format}`. That route (`DrImageController::image`, permission `access content`) validates the requested width against the global settings (`upscale` ≤ width ≤ `downscale`, and width must sit on a `threshold` multiplier), then finds or **creates** a matching `ImageStyle` config entity named `drimage_<w>_<h>` (or `drimage_focal_*` / `drimage_<w>_<h>_<croptype>`) and delivers the derivative via core's `ImageStyleDownloadController::deliver()`. Because it does not use `itok` in URLs, it recomputes the derivative token server-side. A path processor (`PathProcessorImageStyles`) turns the trailing file path into a query parameter so an optional `.htaccess` rewrite (`htaccess.prepend.txt`) can serve already-generated derivatives straight from disk without bootstrapping Drupal. The formatter supports four handling modes — scale, fixed aspect-ratio crop, CSS background image, and Image Widget Crop — and integrates with `focal_point`, `crop`/`image_widget_crop`, `automated_crop`, and WebP (core GD or `imageapi_optimize_webp`). Global behavior is tuned at `/admin/config/media/drimage` (`administer image styles`); a Drush command `drimage:delete-styles` clears the auto-generated styles. Auto-generated styles are also pruned on config import and on relevant module install/uninstall.

---

- Render image fields responsively without building any core Responsive Image styles.
- Serve each image at the exact width it is displayed, snapped to a configurable pixel threshold.
- Replace the core "Responsive image" formatter with a zero-config alternative.
- Fixed aspect-ratio crop of an image field to an exact width:height (e.g. 16:9) at the display size.
- Output an image as a CSS `background-image` with configurable attachment/position/size.
- Lazy-load images as they scroll into the viewport (configurable `lazy_offset`).
- Detect the device pixel ratio and serve higher-resolution derivatives on retina/HiDPI screens.
- Serve WebP derivatives through core GD (`core_webp`) when the browser requests them.
- Serve WebP through the `imageapi_optimize_webp` pipeline instead of core GD.
- Integrate focal-point cropping so on-the-fly crops respect the focal point (`focal_point`).
- Crop via an Image Widget Crop crop type chosen per formatter (`image_widget_crop`).
- Use an `automated_crop` provider for smart cropping of generated styles.
- Cap the largest generated width to control disk usage (`downscale`).
- Set the smallest generated width so tiny thumbnails aren't over-generated (`upscale`).
- Limit how many distinct styles get created by widening the `threshold` step.
- Reuse a near-matching style within an allowed ratio distortion instead of generating a new one.
- Provide a fallback image style to serve when dimensions are invalid or generation fails.
- Set browser cache max-age for delivered derivatives.
- Serve already-generated derivatives directly from disk via the optional `.htaccess` rewrite (Apache).
- Render an image URI field (`drimage_uri` formatter) responsively.
- Bulk-delete every auto-generated drimage image style with `drush drimage:delete-styles`.
- Delete only the styles for a specific crop type with `drush drimage:delete-styles --crop-type=<id>`.
- Alter each generated image style in code via `hook_drimage_image_style_alter()`.
- Customize the proxy cache periods via `hook_drimage_proxy_cache_periods_alter()`.
- Automatically clean up generated styles on config import and on module install/uninstall.
