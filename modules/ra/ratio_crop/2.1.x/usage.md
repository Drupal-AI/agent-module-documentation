Ratio Crop adds a configurable **"Ratio crop"** image effect that crops any image to a fixed aspect ratio (e.g. `16:9`), always keeping the largest possible area and cropping only the longer dimension.

---

The module registers a single configurable core Image effect, `image_crop_ratio` ("Ratio crop"), that you add to an image style on `/admin/config/media/image-styles`. It takes two settings: an `aspect_ratio` string in `W:H` form (validated against `^[0-9]+:[0-9]+$`, default `1:1`) and an `anchor` (a 3×3 grid position such as `center-center` or `left-top`, default `center-center`) that decides which part of the image is kept. At apply time it computes the largest sub-rectangle of the source that matches the ratio, then delegates the actual pixel crop to a bundled GD toolkit operation, `gd_crop_ratio` (`crop_ratio`), which subclasses core's GD `Crop`. Because it also implements `transformDimensions()`, derivative dimensions are known before the image is generated, so `<img>` width/height and responsive image sources stay correct. Unlike the core "Scale and crop" effect you give a *ratio* rather than fixed pixels, so one style adapts to source images of any size. It depends only on core's `image` module, defines no routes, permissions, services or settings form of its own — all configuration lives inside the image style config entity.

---

- Crop all article teaser images to a uniform `16:9` widescreen ratio regardless of the uploaded size.
- Produce square (`1:1`) avatars or thumbnails from arbitrarily shaped source images.
- Build a `4:3` gallery thumbnail style that always keeps the centre of the photo.
- Create a `3:1` banner/hero style that crops tall uploads down to a wide strip.
- Keep the top of portrait photos (anchor `center-top`) so faces are not cut off in a `1:1` crop.
- Keep the bottom-right of an image (anchor `right-bottom`) for a design that overlays text top-left.
- Enforce a consistent card aspect ratio across a Views listing without editing each image.
- Feed a responsive image style/mapping with ratio-correct derivatives whose dimensions are known up front.
- Normalise product photos to a fixed shop ratio (e.g. `5:4`) for a tidy catalogue grid.
- Generate Open Graph / social-share images at the required `1.91:1`-style ratio (e.g. `191:100`).
- Crop map or screenshot uploads to a fixed panoramic ratio.
- Combine with a subsequent "Scale" effect to first ratio-crop then resize to exact pixels.
- Replace ad-hoc manual cropping by letting editors upload any size and get a consistent result.
- Provide multiple ratio styles (`1:1`, `4:3`, `16:9`) selectable per view mode.
- Keep the largest possible image area — the effect never upscales, it only trims the longer side.
- Ensure derivative width/height are emitted in markup so the browser reserves layout space (less CLS).
- Crop hero images differently on mobile vs desktop by attaching different ratio styles per breakpoint.
- Standardise editor-uploaded logos to a fixed ratio placeholder.
- Apply a fixed ratio to media-library thumbnails.
- Crop user-submitted event photos to a consistent listing ratio.
- Use with the GD toolkit (the bundled `gd_crop_ratio` operation) on a stock Drupal install with no extra libraries.
- Create print-ready ratio crops (e.g. `3:2` photographic) for downloadable derivatives.
- Deploy the effect entirely through exported image-style config (`effects[].id: image_crop_ratio`).
