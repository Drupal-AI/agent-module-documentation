Image Effects adds a large library of extra image-style effects and operations (watermark, text overlay, smart crop, rotate, blur, color manipulation and more) to Drupal's Image API, working with both the GD and ImageMagick toolkits.

---

Drupal core ships only a handful of image effects (scale, crop, resize, desaturate, rotate). Image Effects extends this with roughly two dozen additional effects that you add to image styles at Admin → Configuration → Media → Image styles, so derivatives are generated automatically wherever the style is used. Effects include watermarking, text overlay (with font, positioning and color control), smart crop and scale-and-smart-crop, background/mask compositing, auto-orient from EXIF, brightness/contrast/color-shift/invert/convolution filters, Gaussian blur, pixelate, mirror, set canvas, strip metadata, and an ImageMagick "raw arguments" effect. To keep effect forms consistent it defines three pluggable "selector" plugin types — Color, Image and Font selectors — configured once on the module settings form (e.g. use an HTML color picker, or pick fonts from the filesystem). It depends on the File Metadata Manager (`file_mdm`) submodules for EXIF and font metadata, and integrates with the ImageMagick and Textimage contrib modules for capabilities GD lacks. A Drush command helps convert legacy core Rotate effects to the module's version. Developers can add their own selector plugins and alter Text Overlay text via a hook.

---

- Add a watermark logo to every generated image derivative.
- Overlay dynamic text (e.g. a caption or copyright) onto images.
- Choose a font, size, and color for text overlays.
- Smart-crop images to keep the most important region.
- Scale and smart-crop to exact dimensions in one effect.
- Auto-rotate photos based on their EXIF orientation.
- Strip EXIF/metadata from derivatives for privacy or size.
- Apply a Gaussian blur to a thumbnail.
- Pixelate a region or whole image for redaction.
- Adjust brightness and contrast of derivatives.
- Shift or invert colors for stylistic effects.
- Sharpen images with a convolution sharpen effect.
- Apply arbitrary convolution matrices for custom filters.
- Mirror an image horizontally or vertically.
- Set a background behind a transparent image (PNG on a color).
- Mask one image with another for shaped crops.
- Set the canvas size with custom padding/anchor.
- Set a transparent color on an image.
- Change image opacity.
- Rotate by an arbitrary angle with a chosen background.
- Crop relative to a percentage of the image.
- Resize by percentage rather than fixed pixels.
- Switch effects based on portrait vs landscape aspect ratio.
- Set interlace/progressive rendering for web performance.
- Pass raw ImageMagick command arguments for advanced operations.
- Use an HTML color picker widget in effect configuration.
- Pick overlay/background images from the filesystem via a selector plugin.
- Convert legacy core Rotate effects to Image Effects with a Drush command.
- Add a custom color/image/font selector plugin for a bespoke UI.
- Alter overlay text programmatically before it is rendered.
