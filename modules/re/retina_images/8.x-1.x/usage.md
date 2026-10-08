Retina Images adds a "Retinafy" option to core's image-style effects so a style outputs high-resolution (2x/Nx) derivatives for high-DPI displays.

---

High-DPI ("retina") screens render standard-resolution images softly because one CSS pixel maps to several device pixels. Retina Images addresses this at the image-style level: it replaces core's four image-effect plugins (resize, scale, scale-and-crop, crop) with subclasses that add a "Retinafy" checkbox and a "Resolution multiplier" field to each effect's settings. When Retinafy is enabled, the effect multiplies the configured width and height by the multiplier (default 2) before generating the derivative, so the stored image file is physically larger and stays crisp on retina devices — for every visitor, since the same derivative is served to all. The module ships three ready-to-use example styles (thumbnail/medium/large retina) and an admin preview of any style. The practical trade-off is bandwidth and disk: 2x derivatives are larger, so the maintainers recommend enabling upscaling and lowering the image-style quality (about 25) to compensate; for per-viewport delivery, core Responsive Images remains the complementary tool.

---

- Serve crisp 2x images on retina and high-DPI displays.
- Add a "Retinafy" checkbox to a core resize image effect.
- Add a "Retinafy" checkbox to a core scale image effect.
- Add a "Retinafy" checkbox to a core scale-and-crop image effect.
- Add a "Retinafy" checkbox to a core crop image effect.
- Set a custom resolution multiplier (e.g. 1.5, 2, 3) per effect.
- Double the pixel dimensions of a generated image derivative.
- Use the shipped thumbnail_retina (100x100) example style.
- Use the shipped medium_retina (220x220) example style.
- Use the shipped large_retina (480x480) example style.
- Retinafy an existing custom image style by editing its effect.
- Combine Retinafy with allowed upscaling for small source images.
- Lower image-style quality (~25) to offset the larger 2x file size.
- Preview an image style's retina derivative in the admin UI.
- Grant the "Access preview page" permission to trusted reviewers.
- Apply high-resolution output to product or gallery thumbnails.
- Sharpen avatar or profile images on modern devices.
- Improve logo and icon crispness where a theme upscales them.
- Deploy the example styles via config so environments stay consistent.
- Pair with core Responsive Images for viewport-based delivery.
- Pair with the Image Style Quality module for per-style compression.
- Keep Retinafy off on styles where bandwidth matters more than sharpness.
- Test the generated derivative dimensions before rolling out to production.
- Document which styles are retinafied so editors understand output sizes.
