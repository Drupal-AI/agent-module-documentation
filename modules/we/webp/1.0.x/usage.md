WebP generates WebP copies of Drupal image-style derivatives and serves them to supporting browsers via `<picture>`/responsive-image sources, falling back to the original format elsewhere.

---

WebP is a modern image format that is substantially smaller than JPEG/PNG at equivalent quality, improving page-load performance. This module hooks into Drupal's image system so that whenever an image style derivative is created, a matching `.webp` copy is produced (using the GD image toolkit) at a configurable quality. It integrates with core's Responsive Image module by preprocessing `responsive_image` output: for each existing `srcset` source it clones the source, points it at the WebP URL, and marks it `type="image/webp"`, adding those WebP sources at the top of the `<picture>` element so capable browsers pick them and others fall back. A route subscriber routes image-style requests through the module's own download controllers so the WebP derivative is generated on demand. It is also aware of the Blazy module's `data-srcset` lazy-loading attribute. When entities are inserted or updated, outdated WebP derivatives are flushed so stale images are not served. Global image quality is set at Admin → Configuration → Media → WebP settings. The module additionally ships an ImageAPI Optimize processor (`webp_webp`) so it can participate in an ImageAPI Optimize pipeline. It requires the PHP GD extension.

---

- Serve smaller WebP images to browsers that support the format.
- Automatically generate a `.webp` copy of every image style derivative.
- Improve Core Web Vitals / LCP by shrinking image payloads.
- Add WebP sources to responsive-image `<picture>` elements automatically.
- Fall back to JPEG/PNG for browsers without WebP support.
- Set a global WebP compression quality (1–100).
- Work alongside the Blazy module's lazy-loaded `data-srcset` images.
- Reduce bandwidth costs on image-heavy sites.
- Generate WebP derivatives on demand via the module's download controllers.
- Flush stale WebP derivatives when an entity's image changes.
- Regenerate WebP copies after re-saving content.
- Speed up mobile page loads with lighter images.
- Use GD (no extra binaries) to produce WebP output.
- Plug WebP into an ImageAPI Optimize pipeline via the `webp_webp` processor.
- Keep existing image styles unchanged while adding WebP variants.
- Optimize product photos in a Commerce catalog.
- Deliver lighter hero and banner images.
- Lower CDN egress by serving WebP where possible.
- Improve SEO indirectly through faster page speed.
- Trade quality vs. size by tuning the quality setting.
- Convert thumbnails and teasers to WebP across listings.
- Avoid manually creating WebP assets during content authoring.
- Support WebP delivery without changing theme templates.
- Clean up orphaned WebP files automatically on content update.
- Apply WebP consistently across all configured image styles.
