Image Sizes swaps a responsive image to the image-style derivative that matches its parent element's rendered width, chosen client-side, so pictures fit their container instead of the viewport.

---

Image Sizes provides a `image_sizes_preset_entity` config entity (a "preset") that groups a set of core image styles, plus a preload/placeholder style and a fallback style. A field formatter (`image_sizes_preset_formatter`, label "Image sizes presets") renders image and media-reference fields as an `<img>` carrying a `data-src` JSON map of derivative-width to derivative-URL, a low-res or inline base64 placeholder, and a `data-src-fallback`. A small vanilla-JS behavior (`js/image-sizes.es.js`) uses a `ResizeObserver` and `IntersectionObserver` to measure the parent container width, multiply by `devicePixelRatio`, and load the smallest listed derivative that is at least that wide — updating on resize and only when the image is visible (unless "load always" is set). Two Drush commands (`image-sizes:generate` / `isg` and `image-sizes:add-format` / `isaf`) scaffold the image styles and a matching preset, optionally with an aspect ratio, focal-point or manual crop, a blurred thumbnail, and a WebP/other format conversion. The optional `image_sizes_defaults` submodule ships ready-made Default/Landscape/Portrait presets and their styles. Everything is display-side and admin-configured; there is no runtime data collection.

---

- Serve container-sized images (sidebar vs. main column) instead of one viewport-based size, cutting bytes and improving Core Web Vitals / PageSpeed.
- Build a preset at `/admin/config/media/image_sizes_preset_entity` that bundles several width-based image styles.
- Set a low-resolution or blurred preload style so a lightweight placeholder shows before the full image loads.
- Inline the placeholder as a base64 data URI so no extra request is needed before the JS swaps in the real derivative.
- Choose a fallback style (or "original") used when no listed derivative is wide enough.
- Apply the "Image sizes presets" formatter to a core image field on Manage display.
- Apply the same formatter to an entity-reference field that targets media (image media types).
- Lazy-load images: by default a derivative loads only once the `<img>` scrolls into the viewport.
- Force eager loading for above-the-fold images with the formatter's "Load this image even is not visible" option (adds the `load-always` class).
- Automatically upgrade to a larger derivative when the container grows (responsive layouts, resized panels) via the `ResizeObserver`.
- Honor high-DPI/retina screens by scaling the required width by `devicePixelRatio`.
- Generate a full ladder of scale styles plus a preset in one command: `drush isg "Default" 100 1400 100`.
- Generate aspect-ratio-constrained styles: `drush isg "Default" 100 1400 100 --ratio=4x3`.
- Use focal-point crops for ratio styles when the focal_point module is present: `--use-focal-point`.
- Use manual (image_widget_crop) crops for ratio styles: `--use-manual-crop` (also creates a matching crop_type).
- Add a blurred low-res placeholder style with `--generate-thumbnail` (needs image_effects).
- Convert generated derivatives to WebP (default), PNG, JPEG or GIF with `--format=webp`.
- Bulk-append an `image_convert` effect (e.g. WebP) to every existing image style with `drush isaf webp`.
- Enable `image_sizes_defaults` to get pre-built Default, Landscape and Portrait presets without hand-building styles.
- Reuse one preset across many fields and bundles to keep responsive behavior consistent site-wide.
- Reduce origin bandwidth on image-heavy listing/grid pages where each card is much smaller than the viewport.
- Ship modern formats (WebP) from the preset's styles while keeping an original-image fallback.
