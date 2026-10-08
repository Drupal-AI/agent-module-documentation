<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Easy Responsive Images auto-generates a ladder of image styles from a min/max width (and optional aspect ratios), a field formatter that emits a responsive `srcset` for image fields, and a Twig `image_url` filter for building style URLs in custom templates. JavaScript then loads the best-fitting derivative for the container.

---

From a single settings form (*Configuration > Media > Image styles > Generate image styles*, route `easy_responsive_images.generate`) you enter a minimum width, maximum width, a preferred pixel step, and optionally a list of aspect ratios; on save the module creates image styles named `responsive_<width>w` (flexible-height scale styles), `responsive_<w>_<h>_<width>w` (cropped aspect-ratio styles, using `focal_point_scale_and_crop` when Focal Point is installed, otherwise `image_scale_and_crop`), and `responsive_<height>h` (flexible-width styles). Styles are stored in config, obsolete `responsive_`-prefixed styles are pruned on save, and a "Delete generated image styles" button removes them all. Two ways to output them: the **Easy Responsive Images** field formatter (id `easy_responsive_images`, for image fields) which renders an `<img>` with a `data-srcset` of all matching derivatives plus `image_handling` (scale or aspect_ratio), `multiplier`, and `cover` options; or the **`image_url`** Twig filter (`uri|image_url('responsive_16_9_550w')`) for hand-built templates/view modes. The bundled `easy_responsive_images/resizer` JS reads the available container width and swaps in the best derivative, and integrates with WebP/Avif modules (`imageapi_optimize_webp`, `webp`, `avif`) to serve next-gen formats, and with `imagecache_external` for remote images. A `lazy_loading_threshold` config value (default 1250px) tunes native lazy-loading distance, and `hook_easy_responsive_images_image_style_alter()` lets modules add effects (e.g. WebP conversion) to each generated style.

---

- Generate a full set of responsive image styles from just a min/max width and a step size.
- Produce cropped derivatives for specific aspect ratios (e.g. 16:9, 4:3) across many widths.
- Output an image field with a proper `srcset` using the Easy Responsive Images field formatter.
- Build responsive image URLs in a custom Twig template with the `image_url` filter.
- Serve the smallest adequate image per container width via the bundled resizer JavaScript.
- Automatically serve WebP derivatives when ImageAPI Optimize WebP or WebP module is installed.
- Automatically serve Avif derivatives when the Avif module is installed.
- Crop responsive images around a focal point when Focal Point is installed.
- Create media view modes per aspect ratio and render each with the matching responsive styles.
- Tune native browser lazy-loading distance via the `lazy_loading_threshold` setting.
- Increase loaded image resolution on high-DPI screens with the formatter `multiplier` option.
- Use container height as well as width for selection (object-fit layouts) via the `cover` option.
- Bulk-delete all generated `responsive_*` image styles from the settings form.
- Regenerate/adjust the style ladder by changing the width range and re-saving (obsolete styles pruned).
- Add flexible-height styles (`responsive_<h>h`) for layouts that constrain by height.
- Add a WebP/Avif conversion effect to every generated style via `hook_easy_responsive_images_image_style_alter()`.
- Render remote images responsively together with the Imagecache External module.
- Standardise responsive image handling across a site without hand-crafting dozens of image styles.
- Provide art-directed responsive crops for hero images at a fixed aspect ratio.
- Get correct intrinsic width/height attributes on responsive images to reduce layout shift.
- Use the `easy_responsive_images.manager` service to fetch derivative URL sets by aspect ratio or scale.
- Deploy the generated styles and settings as exported configuration across environments.
- Replace a legacy Drimage-style setup with a simpler min/max-width driven approach.
