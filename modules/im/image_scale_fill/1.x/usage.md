<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Image Scale and Fill Background adds one configurable image-style effect, "Scale and fill background" (plugin id `scale_and_fill_background`), that scales the source image to fit inside a fixed WxH canvas and fills the leftover margins with a tiled copy, a blurred copy, the image's dominant color, or a color gradient — so every derivative comes out at exactly the configured size without cropping the subject.

---

The module ships a single Drupal image effect, `ScaleFillBackgroundEffect` (in `src/Plugin/ImageEffect/ScaleFillBackgroundEffect.php`), that extends core's `ConfigurableImageEffectBase` and works only with the GD toolkit. On each derivative build it allocates a true-color canvas of the configured width and height, centers the source image scaled to fit (`placeCenterImage()`), and paints the surrounding area according to a chosen **background type**: `tiled` (`applyTiledBackground()`, mirrored copies of the image tiled outward), `scaled` (`applyScaledBackground()`, the source scaled to cover the canvas and center-cropped), or `dominant_color` (`applyDominantColorBackground()` for a flat fill, or `applyGradientBackground()` for a vertical/horizontal gradient toward a darker shade). For the tiled and scaled types an optional **background style** post-processes the fill: `blurred` runs a pure-PHP Gaussian blur (`GdGaussianBlur`, adapted from the Image Effects module) at a configurable radius, sigma and resize ratio, while `transparent_overlay` lays a colored overlay at a configurable opacity. The dominant color is sampled from the opaque pixels of a 20x20 downscale (`getDominantColor()`). Images that already have a transparent background (logos, artwork) are detected by sampling a grid of the source (`measureSource()`) and, instead of a smeared tiled/blurred copy, are given a plain filled ground chosen by the **transparent source handling** setting — `none` (leave it, which comes out black), `auto` (a light or dark fill picked from the artwork's WCAG relative luminance), `fixed` (a set hex color), or `from_image` (a pale tint or dark shade mixed from the artwork's own color). Every numeric setting is clamped to a documented range at apply time (`clampSetting()`), the canvas is bounded to 10000 px per side and 40,000,000 px total (`getCanvasDimensions()`), and the blur working area is bounded to a fixed work budget (`getBlurWorkingSize()`), so an oversized or imported configuration cannot exhaust memory or CPU. The effect also implements `transformDimensions()` so the known output size is reported without loading the source, and `getSummary()` so the whole configuration is reviewable from the image-styles list. Configuration is stored per effect instance in the image style config entity, validated by `config/schema/image_scale_fill.schema.yml`, and the module provides no routes, permissions, services or Drush commands of its own — it is administered entirely through core's Image styles UI (`administer image styles`).

---

- Produce fixed-size thumbnails (e.g. a 1200x630 social card) from source images of any aspect ratio without cropping the subject.
- Give a gallery or teaser grid a uniform image box while showing each photo whole, letterboxed against a fill.
- Fill the letterbox margins with a blurred, enlarged copy of the same photo for a modern "blurred backdrop" look.
- Fill the margins with a tiled/mirrored copy of the image instead of a blur.
- Fill the margins with the image's dominant color so the frame blends into the photo.
- Fill the margins with a gradient running from the dominant color to a darker shade, vertically or horizontally.
- Present product photos with inconsistent dimensions in a consistent card size.
- Normalize user-uploaded avatars or logos to a single canvas size.
- Place transparent PNG logos on a chosen solid background instead of the default black that transparency produces.
- Auto-pick a light or dark background behind a logo based on whether the artwork itself is light or dark.
- Fill a transparent logo's background with a pale tint or dark shade derived from the logo's own color.
- Match a filled logo background to the page background color so no rectangle shows.
- Tune blur strength per image style via blur radius and sigma.
- Speed up blurred backgrounds by lowering the resize ratio (blur a smaller downscale, then upscale).
- Dim a background copy with a semi-transparent colored overlay so foreground text/UI stays readable.
- Build a hero-banner image style that always outputs the exact banner dimensions.
- Standardize open-graph / meta preview images to the size required by each platform.
- Add the effect as one step in a longer image-style pipeline in the Image styles UI.
- Keep derivative sizes predictable in responsive image mappings because `transformDimensions()` reports the fixed canvas size.
- Cap runaway configuration safely: oversized canvases are proportionally reduced and heavy blurs are bounded automatically.
- Review an image style's full effect configuration from the styles list without opening the form (`getSummary()`).
- Avoid pulling in a large image toolkit module when you only need scale-and-fill behavior on GD.
