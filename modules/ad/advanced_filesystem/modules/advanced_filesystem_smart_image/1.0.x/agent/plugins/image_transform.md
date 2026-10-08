<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ImageTransform plugin type & built-ins

## Plugin type

- Annotation `Annotation\ImageTransform` (`id`, `label`, `weight`).
- Manager `ImageTransformPluginManager` — namespace `Plugin/ImageTransform`, discovery cache
  `cache.discovery`, annotation class as above (services.yml:
  `advanced_filesystem_smart_image.plugin_manager.image_transform`).
- Interface `Plugin\ImageTransform\ImageTransformInterface`; base
  `Plugin\ImageTransform\ImageTransformBase` (extends `PluginBase`) with GD canvas helpers
  `canvas()`, `coloredCanvas()`, `parseHex()`.
- `ImageProcessor::orderedPlugins($params)` loads all definitions, sorts by ascending `weight`,
  instantiates each, and keeps those whose `applies($params)` is TRUE; then calls
  `apply(\GdImage, $params)` in order. Each `apply()` returns a (possibly new) `\GdImage`.

To add a custom transform: create a class in `Plugin/ImageTransform/` with the `@ImageTransform`
annotation, extend `ImageTransformBase`, and implement `applies()` / `apply()`.

## Built-in transforms (weight order)

- **`resize_crop`** (weight 10, `ResizeCropTransform`) — applies when `w` or `h` is set.
  `fit`: `contain` (fit within, aspect preserved), `cover` (fill, may overflow edges), `crop`
  (cover then crop to exact size), `fill` (contain onto an exact `bg`-filled canvas). Missing
  dimension is computed proportionally. Crop origin from `fp_x`/`fp_y` (focal point, clamped 0–1) or
  `gravity` keyword (`north|south|east|west|north{east,west}|south{east,west}|center`). Uses
  `imagecopyresampled`.
- **`pad`** (weight 15, `PadTransform`) — applies when `pad`/`pad_x`/`pad_y` > 0. Adds a border of
  `bg` color (`pad_x`/`pad_y` override the uniform `pad`); new canvas = source + 2×pad each axis.
- **`rotate_flip`** (weight 20, `RotateFlipTransform`) — applies when `rotate != 0` or `flip` set.
  `rotate` degrees clockwise (negated for GD's CCW `imagerotate`), transparent fill; `flip` =
  `horizontal|vertical|both` via `imageflip`.
- **`filter`** (weight 30, `FilterTransform`) — grayscale, sepia (grayscale + warm colorize),
  `brightness`/`contrast` (-100..100, mapped/inverted for GD), `blur` (1–10 Gaussian passes),
  `sharpen` (1–100 mapped to 1–5 passes). Order: grayscale/sepia → brightness → contrast → blur →
  sharpen.
- **`watermark`** (weight 40, `WatermarkTransform`, container plugin) — applies when `wm` set. Loads
  the watermark URI through the **same scheme whitelist + traversal guard** as `src`
  (`resolveWatermarkPath()`: normalize bare path → `public://`, reject `..`/NUL/`:`, enforce
  `allowed_schemes`, `realpath`+readable check; on failure it logs a warning and returns the image
  unchanged). Optional `wm_w` resize; `wm_opacity` (0–100, default 80), `wm_pos`
  (`bottomright` default + 8 others), `wm_pad` (default 10). Blends via a cut-buffer + `imagecopy`/
  `imagecopymerge`; skips if the watermark is larger than the destination.

## Save & formats

`ImageProcessor::saveGdImage()` writes with `imagepng` (quality→compression), `imagegif`,
`imagewebp`, `imageavif` (falls back to `imagejpeg` if unavailable) or `imagejpeg`. Load supports
JPEG/PNG/GIF/WebP/AVIF/BMP via the matching `imagecreatefrom*`.
