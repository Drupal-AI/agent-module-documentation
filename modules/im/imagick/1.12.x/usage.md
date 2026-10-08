<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Imagick provides an image toolkit for Drupal backed by the PHP **Imagick** (ImageMagick) extension, and adds ~35 extra image-style effects that GD cannot do.

---

Drupal core ships a GD image toolkit; Imagick registers an alternative toolkit (id `imagick`) that processes images through the `Imagick` PHP extension instead of shelling out to the `convert` binary (as the ImageMagick module does). Because it works on in-memory image data it can offer effects GD has no equivalent for — blur, charcoal, emboss, oil-paint, polaroid, vignette, watermark/composite, color overlay, format conversion, and many more. You switch the site's active toolkit to Imagick at *Configuration → Media → Image toolkit* (`system.image_toolkit_settings`), where a small settings form (stored in the `imagick.config` object) controls default JPEG quality, the resize filter, whether output is optimized, and whether metadata is stripped. Each extra effect is a normal `ImageEffect` plugin, so you add it to any image style at *Configuration → Media → Image styles* exactly like a core effect; behind the scenes each effect maps to an ImageMagick toolkit **operation** (ids `imagick_*`). Enabling the module does not change how images are rendered until you select the Imagick toolkit and/or add its effects to an image style. It requires the Imagick PHP extension to be installed on the server.

---

- Switch a site's image processing from GD to the Imagick (ImageMagick) toolkit.
- Set a site-wide default JPEG quality for generated image derivatives.
- Strip EXIF/metadata from generated images to reduce size and protect privacy.
- Enable output optimization to meet Google PageSpeed image guidelines.
- Choose the resize/resampling filter used when scaling images.
- Apply a Gaussian, motion, radial, or adaptive blur effect in an image style.
- Add a charcoal, sketch, oil-paint, or emboss artistic effect to a style.
- Give thumbnails a polaroid frame or rounded corners.
- Add a drop shadow to an image derivative.
- Composite a watermark/logo image over generated images (`image_composite`).
- Overlay a solid color or color-shift tint on images.
- Add a vignette or frame border to an image style.
- Convert generated images to a different format (`image_convert`, e.g. to WebP).
- Auto-rotate images based on EXIF orientation before other effects.
- Trim surrounding whitespace from an image (`image_trim`).
- Mirror, solarize, posterize, or invert an image via a style effect.
- Adjust brightness/saturation/hue with the modulate effect.
- Add noise, spread, swirl, or wave distortion effects.
- Define a fixed canvas size / letterbox background around an image.
- Annotate generated images with text.
- Encipher/decipher image data for obfuscated derivatives.
- Set a transparent background on converted images.
- Use image-data-aware effects (e.g. Smart Crop via the smartcrop module) that GD can't support.
- Keep image styles portable — effects are standard config that export/import like any other.
