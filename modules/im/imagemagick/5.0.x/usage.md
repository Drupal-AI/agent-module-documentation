ImageMagick provides an image toolkit that lets Drupal process images (image styles, derivatives, uploads) by shelling out to the ImageMagick or GraphicsMagick command-line binaries instead of PHP's built-in GD library.

---

Drupal's Image API is toolkit-based; by default it uses the GD extension. This module registers an alternative `imagemagick` toolkit that delegates image operations to the `convert`/`identify` (ImageMagick) or `gm` (GraphicsMagick) executables installed on the server, which typically produce higher-quality output and support many more formats than GD. You select and configure it at Admin → Configuration → Media → Image toolkit: choose the package (ImageMagick v6/v7 or GraphicsMagick), the path to the binaries, default quality, and which image formats are enabled (PNG, JPEG, GIF, WEBP, AVIF, plus optional TIFF, PDF, HEIC, PSD, SVG and more via the `sophron`/MIME mapping). It depends on `file_mdm` for cached image metadata (an `imagemagick_identify` file-metadata plugin reads dimensions/format via `identify`) and on `sophron` for format/MIME mapping. Standard image style effects (scale, crop, resize, rotate, desaturate, convert, scale-and-crop) are implemented as ImageToolkit operation plugins that build up the command line. Developers extend or customize the emitted CLI arguments through a rich event system (`ImagemagickExecutionEvent`) — e.g. to add sharpening, color profiles, or coalesce animated GIFs. The module also exposes services (`ImagemagickExecManager`, `ImagemagickExecArguments`, `ImagemagickFormatMapper`) for building and running commands programmatically, and adds a runtime requirements check.

---

- Use ImageMagick/GraphicsMagick instead of GD for image style derivatives.
- Produce higher-quality thumbnails and resized images.
- Enable output formats GD can't handle well (WEBP, AVIF, TIFF, etc.).
- Convert uploaded images to a preferred web format via image styles.
- Set a global JPEG/output quality for all derivatives.
- Point Drupal at a custom binaries path (e.g. `/usr/bin/`).
- Switch between ImageMagick v6, v7, and GraphicsMagick.
- Restrict which image formats the site will process.
- Read accurate image dimensions/metadata via `identify` (file_mdm).
- Generate responsive image style variants at higher fidelity.
- Handle animated GIFs correctly (coalesce frames).
- Apply color profiles or density settings via advanced options.
- Add custom `convert` arguments (e.g. sharpening) through events.
- Alter the command line before conversion with an event subscriber.
- Process multi-frame formats like PDF/TIFF (identify a specific frame).
- Build and run ImageMagick commands programmatically from custom code.
- Map file extensions to ImageMagick formats and MIME types.
- Check server support/requirements for rotate effects at runtime.
- Integrate with Image Effects module for extra operations.
- Convert PDFs to image previews where the binary supports it.
- Debug the exact CLI commands Drupal runs (debug logging).
- Enforce a colorspace (e.g. sRGB) on generated images.
- Support HEIC/PSD/BMP/ICO inputs where enabled.
- Improve crop/scale quality over GD for print-style output.
- Log ImageMagick warnings for troubleshooting.
