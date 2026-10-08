<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Scale and fill background" image effect

## Install & enable

```bash
composer require drupal/image_scale_fill
drush en image_scale_fill -y
```

Only dependency is core **`image`**. No submodules, no permissions of its own, no Drush commands,
no services. Requires the **GD** image toolkit (the effect refuses and logs an error on any other
toolkit).

## Add it to an image style

The effect is `ScaleFillBackgroundEffect` (plugin id **`scale_and_fill_background`**, label *"Scale
and fill background"*), declared with the `#[ImageEffect(...)]` attribute in
`src/Plugin/ImageEffect/ScaleFillBackgroundEffect.php`. It is added like any core image effect:

UI: *Configuration → Media → Image styles* (`/admin/config/media/image-styles`, permission
**`administer image styles`**) → open or create a style → **Add effect** → *Scale and fill
background* → set the options below. There is **no dedicated settings route** (`configure` is
null); the effect is configured per instance inside the image-style config entity.

Config-entity shape (an effect entry inside `image.style.<name>`):

```yaml
effects:
  <uuid>:
    id: scale_and_fill_background
    weight: 1
    data:
      width: 1200
      height: 630
      background_type: scaled        # tiled | scaled | dominant_color
      background_style: blurred      # blurred | transparent_overlay (tiled/scaled only)
      background_style_dominant: single_color  # single_color | gradient (dominant_color only)
      radius: 9
      sigma: 6
      resize_ratio: 0.3
      gradient_direction: vertical   # vertical | horizontal
      transparency: 60
      transparent_handling: auto     # none | auto | fixed | from_image
      transparent_light_color: '#FFFFFF'
      transparent_dark_color: '#000000'
      transparent_color: '#FFFFFF'
```

## Settings (from `defaultConfiguration()` / `buildConfigurationForm()`)

| Key | Default | Range / choices | Meaning |
|---|---|---|---|
| `width` | null (required) | 1–10000 | Output canvas width in px. |
| `height` | null (required) | 1–10000 | Output canvas height in px. Also `width*height` ≤ 40,000,000. |
| `background_type` | `scaled` | `tiled`, `scaled`, `dominant_color` | How the margins around the centered image are filled. |
| `background_style` | `blurred` | `blurred`, `transparent_overlay` | Post-process for **tiled/scaled** only (form label "Colored overlay"). |
| `background_style_dominant` | `single_color` | `single_color`, `gradient` | For **dominant_color** only. |
| `radius` | 9 | 1–50 | Gaussian blur radius (blurred style). |
| `sigma` | 6 | 0.1–50, and ≤ radius | Blur spread (blurred style). |
| `resize_ratio` | 0.3 | 0.1–1.0 | Fraction the fill is downscaled to before blurring (smaller = faster). |
| `gradient_direction` | `vertical` | `vertical`, `horizontal` | Gradient direction (dominant_color + gradient). |
| `transparency` | 60 | 0–100 | Overlay opacity (0 transparent … 100 opaque) for the colored overlay. |
| `transparent_handling` | `auto` | `none`, `auto`, `fixed`, `from_image` | Fill strategy for sources that already have a transparent background. |
| `transparent_light_color` | `#FFFFFF` | `#RRGGBB` | Light fill (used behind dark artwork when `auto`). |
| `transparent_dark_color` | `#000000` | `#RRGGBB` | Dark fill (used behind light artwork when `auto`). |
| `transparent_color` | `#FFFFFF` | `#RRGGBB` | Fixed fill color when `fixed`. |

The form groups the dependent fields in `#states`-controlled fieldsets ("Image background",
"Dominant color background", "Fill color"). `validateConfigurationForm()` re-checks each value
against the ranges above (and `sigma` ≤ `radius`, and `width*height` ≤ MAX_PIXELS); a hidden field
left empty is stored as its default in `submitConfigurationForm()`. Config schema:
`config/schema/image_scale_fill.schema.yml` (`image.effect.scale_and_fill_background`, marked
`FullyValidatable`; the `transparent_*_color` keys are `Regex`-constrained to `/^#[0-9A-Fa-f]{6}$/`).

## What each background type produces

- **scaled** (`applyScaledBackground()`): the source is scaled to *cover* the canvas and
  center-cropped in source coordinates (so GD's work stays bounded by the canvas, not the source
  aspect ratio), giving a full-bleed background of the same photo.
- **tiled** (`applyTiledBackground()`): the source is scaled to fit one dimension, then mirrored
  copies are tiled symmetrically into the top/bottom and left/right margins.
- **dominant_color**: `single_color` fills the whole canvas with the dominant color
  (`applyDominantColorBackground()`); `gradient` runs the dominant color to a shade 50 lower per
  channel across the canvas (`applyGradientBackground()` → `applyGradient()` /
  `interpolateColor()`), vertically or horizontally.

For **tiled** and **scaled** only, the `background_style` post-process runs:

- `blurred` (`applyBlurredBackground()`): downscales the fill by `resize_ratio`, blurs it with
  `GdGaussianBlur::gaussianCoeffs()` + two `applyCoeffs()` passes (horizontal then vertical), then
  upscales it to cover the canvas.
- `transparent_overlay` (`applyTransparentOverlayBackground()`): fills the canvas with a black
  rectangle at the alpha derived from `transparency`, dimming the fill in one blend pass.

In all cases `placeCenterImage()` finally composites the source, scaled to fit inside the canvas,
centered on top.

## Transparent-source (logo) handling

Detected in `getTransparentBackgroundColor()` + `measureSource()`: the source is sampled on a grid
(`SAMPLE_GRID = 60` per axis); if at least 5% of samples are transparent (`MIN_TRANSPARENT_SHARE`),
the image is treated as a logo/artwork and the **configured background type is skipped** in favor
of a plain fill, because a tiled/blurred copy of a logo is just a smeared logo:

- `none` → no fill (the transparent area renders black).
- `auto` → light or dark fill, chosen from the artwork's WCAG relative luminance
  (`getRelativeLuminance()`); if more than 70% of ink pixels are light (`AUTO_LIGHT_SHARE`) the
  artwork is "light" and gets the dark color, else the light color.
- `fixed` → `transparent_color`.
- `from_image` → the artwork's average color mixed 85% (`DERIVED_MIX`) toward white (dark artwork)
  or black (light artwork) via `mixColor()`.

The source's own transparency is left intact so the centered image composites cleanly onto the
fill. `getDominantColor()` (and `measureSource()`) ignore near-transparent pixels when sampling.

## Robustness / bounds (why this stays cheap)

- `getCanvasDimensions()` caps the canvas to `MAX_DIMENSION = 10000` px/side and
  `MAX_PIXELS = 40,000,000` total, reducing proportionally (and logging a warning) rather than
  allocating an oversized buffer.
- `getBlurWorkingSize()` caps blur cost to `MAX_BLUR_WORK = 12,000,000` (pixels × coefficients),
  shrinking the blurred area if needed — a big radius on a big canvas cannot run for minutes.
- `clampSetting()` clamps `radius`/`sigma`/`resize_ratio`/`transparency` to range at apply time, so
  config imported around the form (which would otherwise bypass validation) is still safe.
- `parseHexColor()` regex-validates every color and falls back to white on anything unusable.
- `applyEffect()` verifies the toolkit exposes a `\GdImage`, and that width/height and the source
  size are positive, before doing any work; failures log and return FALSE.

## Output size & summary

- `transformDimensions()` sets the derivative size to the (capped) canvas width/height without
  loading the source, so responsive-image mappings and `<img>` dimensions are correct.
- `getSummary()` renders the full effective configuration (dimensions, type, style, blur params,
  transparent-handling) on the Image styles list, so a style can be reviewed without opening the
  form. Values it prints are schema/`Choice`-constrained or run through the same hex parser the
  effect uses.

## Upgrade note

`image_scale_fill.post_update.php` provides two updates run by `drush updatedb`:
`..._cast_numeric_settings` re-saves styles so stored values match their schema types (and warns
about styles above the new size caps), and `..._add_transparent_background` writes
`transparent_handling: none` onto styles created by 1.0.0 so their output does not change (new
effects default to `auto`).
