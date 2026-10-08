# Configuration

Configuring Imagick is two steps: select the toolkit (and set its output
options), then add any extra effects to your image styles.

## Select the Imagick toolkit

1. Go to **Configuration → Media → Image toolkit**
   (`/admin/config/media/image-toolkit`).
2. Choose **Imagick image manipulation toolkit** and click **Save**.

If the Imagick option is missing or disabled, the Imagick PHP extension is not
loaded on the server — see [Installation](../installation/index.md).

## Toolkit settings

The same form carries a few options that control how generated image
derivatives are produced. These affect only the derivative‑generation path — your
original source files are never touched.

- **JPEG quality** (`jpeg_quality`, default **75**) — the quality, from 1 to 100,
  used for generated JPEG images. Lower values mean smaller files and more visible
  compression.
- **Resize filter** (`resize_filter`, default **22**) — the ImageMagick filter
  constant used when scaling images, controlling the resampling algorithm.
- **Optimize** (`optimize`, default **on**) — run optimization when images are
  saved, which helps meet Google PageSpeed image guidelines.
- **Strip metadata** (`strip_metadata`, default **on**) — remove EXIF and other
  metadata from generated images to reduce file size and protect privacy.

Click **Save configuration** to store these. They are held in the `imagick.config`
object, and can also be read or set with Drush:

```bash
drush cget imagick.config
drush cset imagick.config jpeg_quality 60 -y
```

## Add Imagick effects to an image style

Imagick's extra effects are ordinary image effects. Add them the same way you
would a core effect:

1. Go to **Configuration → Media → Image styles**
   (`/admin/config/media/image-styles`).
2. Edit an existing style or add a new one.
3. From the **Effect** drop‑down, choose one of the Imagick effects and click
   **Add**, then configure and save it.

Available effects include blur (normal, adaptive, Gaussian, motion, and radial),
charcoal, sketch, oil paint, emboss, polaroid frame, rounded corners, drop
shadow, watermark/composite, color overlay and color shift, vignette, frame
border, format conversion (for example to WebP), auto‑rotate by EXIF orientation,
trim whitespace, mirror, solarize, posterize, invert, modulate
(brightness/saturation/hue), noise, spread, swirl, wave, define canvas,
annotate, and more.

The extra effects only run while the active toolkit is Imagick. Your existing
resize, scale, crop, and rotate effects keep working — they are simply carried
out through ImageMagick instead of GD once the toolkit is switched.
