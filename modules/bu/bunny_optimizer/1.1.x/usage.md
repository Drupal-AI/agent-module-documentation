Serve Drupal image-style derivatives through Bunny.net's real-time image optimizer by rewriting derivative URLs with edge query parameters instead of processing image files on the server.

---

Bunny Optimizer registers a Drupal **image toolkit** (`bunny_optimizer`) that you select at *Configuration > Media > Image toolkit*. Once it is the default toolkit, image styles no longer generate files on disk: `BunnyOptimizerImageStyle::buildUrl()` returns the original file URL (optionally re-pointed at a configured **CDN hostname**) with a query string built from the style's effects — `?width=…&height=…&quality=…&class=…` — which Bunny's optimizer applies at the edge and caches. The standard Crop, Desaturate, Resize, Scale and Scale-and-crop effects are re-implemented as toolkit **operations** that merely set query parameters, and the module adds Bunny-specific effects (Automatically optimize, Blur, Brightness, Contrast, Flip, Flop, Hue, Quality, Saturation, Sepia, Sharpen, Smart Face Crop) plus an *Apply a Bunny Optimizer image class* preset effect. It requires a Bunny CDN account with a pull zone that serves your images; the only site configuration is the CDN hostname, and the module makes no server-side calls to Bunny and stores no API credentials. Depends on core File and Image plus the File MDM module (used to read source image dimensions/mime).

---

- Offload image-derivative generation from your web server to Bunny.net's edge optimizer.
- Keep your existing Drupal image styles unchanged while serving them through the CDN.
- Select Bunny Optimizer as the default image toolkit at Configuration > Media > Image toolkit.
- Serve resized images by adding the core Resize/Scale effects, which become `width`/`height` query params.
- Crop images at the edge using the Crop / Scale-and-crop effects.
- Convert image format on the fly (WebP, etc.) via the Convert operation, handled entirely by Bunny.
- Desaturate images through the CDN instead of GD/ImageMagick.
- Automatically optimize images (low/medium/high) with the Automatically optimize effect.
- Apply a Gaussian blur to derivatives with the Blur effect.
- Adjust brightness, contrast, hue, saturation of served images with the matching effects.
- Flip (vertical) or flop (horizontal) images at the edge.
- Apply sepia or sharpen filters via query parameters.
- Use Bunny's Smart Face Crop to crop around detected faces.
- Bundle many parameters into a single reusable preset with the *Apply a Bunny Optimizer image class* effect.
- Point derivative URLs at a dedicated Bunny pull-zone hostname via the CDN hostname setting.
- Leave the CDN hostname empty when the site's own hostname is already fronted by Bunny CDN for full-page caching.
- Reduce origin CPU and disk usage by never writing derivative files locally.
- Serve modern formats and responsive image variants without local toolkit binaries.
- Combine with the Bunny CDN module when the pull zone caches full page responses.
- Support JPG, JPEG, WebP, GIF, PNG, TGA, BMP, PBM, TIFF, HEIC and HEIF source images.
- Avoid storing image derivatives, so flushing an image style leaves the original untouched.
