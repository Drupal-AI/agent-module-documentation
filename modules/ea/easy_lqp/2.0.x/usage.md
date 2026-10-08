<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Easy LQP auto-generates responsive image styles and renders images with an inline low-quality base64 placeholder that JavaScript swaps for the best-fit full derivative once it scrolls into view.

---

Easy LQP (Low Quality Placeholder) is a performance/media module for images. From one settings form it bulk-generates a family of core image styles (named `responsive_*`) — scale-by-width, scale-by-height, and cropped aspect-ratio variants — stepped between a configurable minimum and maximum size. Its field formatter, **Easy LQP Images**, renders an image field as a `<picture>` whose `<img>` `src` is a tiny inline `data:` base64 placeholder and whose `data-srcset` lists the generated derivatives; the bundled `resizer.js` behavior measures the container, picks the smallest derivative that is large enough, and fades it in. A Twig `image_url` filter lets themers build the same style URLs (with optional WebP variants) directly in media view-mode templates. Placeholders are cached in a dedicated `easy_lqp` database table, generated either lazily on first render or eagerly on file upload. It depends only on core Image and integrates with Focal Point, the ImageAPI Optimize family (for WebP), and Imagecache External. It is a fork of a feature originally proposed for Easy Responsive Images.

---

- Add blur-up / LQIP inline placeholders that display while the full image loads.
- Reduce the number of full-size images sent in the initial HTML payload.
- Auto-generate dozens of responsive image styles from one form instead of clicking through the image-styles UI.
- Generate width-based styles (`responsive_500w`, `responsive_600w`, …) that scale by width and keep aspect ratio.
- Generate height-based styles (`responsive_300h`, …) for fixed-height, flexible-width layouts.
- Generate cropped aspect-ratio styles (`responsive_16_9_500w`, `responsive_4_3_600w`, …) from a list like `16:9` and `4:3`.
- Serve lazy-loaded, container-aware responsive images without a hand-written `srcset`.
- Pick the best derivative for the actual container width at runtime via IntersectionObserver + ResizeObserver.
- Upscale loaded images with a quality multiplier (1x–4x) tied to device pixel ratio.
- Use container height to choose the image when using CSS `object-fit: cover`.
- Emit WebP derivatives automatically when ImageAPI Optimize WebP (or webp) is installed.
- Integrate Focal Point so aspect-ratio crops honor the configured focal point.
- Build image-style URLs inside Twig templates with the `image_url` filter for custom media view modes.
- Support external images through Imagecache External in the Twig filter.
- Generate placeholders eagerly at upload time, or lazily on first page render.
- Cache generated placeholders in the `easy_lqp` table and invalidate them automatically when a file is updated or deleted.
- Migrate a site from Easy Responsive Images by copying its settings and switching the display formatter.
- Configure minimum/maximum sizes and the pixel step between generated styles to control how many styles are produced.
- Clean up obsolete `responsive_*` styles automatically when the settings form is re-saved.
- Provide a "Generate image styles" local task on the Image styles admin listing.
