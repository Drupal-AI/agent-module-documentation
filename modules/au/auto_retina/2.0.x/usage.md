<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Auto Retina delivers a high-magnification (retina/2x) derivative of any core image style on demand, requested by appending a suffix such as `@2x` to the image-style URL.

---

Auto Retina intercepts Drupal core's image-style delivery routes and, when the requested filename carries a configured retina suffix (default `@2x`, before the extension), regenerates the same image style scaled by the magnification multiplier. It resolves the base source image, multiplies the width of each dimension-changing style effect, upscales as needed, and caps the result at the source image's real width so it never fabricates detail that isn't there — logging (and dispatching an event) when a source is too small for optimum retina quality. Multiple multipliers (`@.75x @1.5x @2x @3x`) and a JPEG quality multiplier for magnified images are configurable at `/admin/config/media/image-styles/auto-retina`. It reuses core's image-derivative token (`itok`), so a retina URL requires the same signed token as its base derivative. The module only produces derivative files; it does not sniff for retina devices or emit `<img>`/`srcset` markup — front-end selection stays with your theme or a picture/responsive-image setup.

---

- Serve a crisp 2x version of an existing image-style derivative to high-DPI displays.
- Add retina output to every image style at once, without cloning styles at doubled dimensions.
- Request a retina image by prepending `@2x` to the extension of a signed derivative URL.
- Support several magnifications on the same style, e.g. `@.75x`, `@1.5x`, `@2x`, `@3x`.
- Change the retina suffix from the default `@2x` to any token you prefer.
- Trim retina file size by lowering JPEG quality only for magnified images via the quality multiplier.
- Automatically cap upscaling so a small source is never blown up past its native width.
- Identify which uploaded images are too small for good retina quality via the recent-log-messages report.
- React programmatically to low-quality retina generation by subscribing to `auto_retina.low_quality_retina`.
- Expose the retina regex/suffix settings to JavaScript as `drupalSettings.autoRetina` for front-end scripts.
- Combine with the Image Style Quality module for per-style control of the retina quality basis.
- Run retina derivatives through an Image Optimize (imageapi_optimize) pipeline when that module is enabled.
- Keep working with both public (`public://`) and private (`private://`) file schemes.
- Flush retina derivatives automatically when a Crop entity changes (crop integration).
- Alter the effect calculation for a specific effect type via `hook_auto_retina_effect_EFFECT_NAME_alter()`.
- Alter every style before its retina derivative is built via `hook_auto_retina_create_derivative_alter()`.
- Alter the HTTP headers sent with a freshly generated retina image via `hook_auto_retina_image_style_deliver_alter()`.
- Provide 2x thumbnails in listings and teasers so images stay sharp when zoomed.
- Back a responsive `<picture>` element whose high-DPI sources point at `@2x` variants.
- Migrate Drupal 7 Auto Retina settings forward using the bundled `d7_auto_retina_settings` migration.
- Configure everything from the Image styles admin area under the "Auto Retina" secondary tab.
- Disable the low-quality log noise by setting the `log` config flag to false.
