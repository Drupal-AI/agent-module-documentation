Adds fetchpriority and decoding attributes (plus a loading override for media images) to Drupal's Image and Rendered-entity field formatters through simple Manage-display and Views options.

---

Advanced Image Media Attributes Formatter improves image loading performance without code by extending the two formatters editors already use. Rather than adding new formatter plugins, it replaces the class behind core's "Image" formatter and the "Rendered entity" formatter (used for media reference fields) via `hook_field_formatter_info_alter()`, so extra settings appear inline wherever those formatters are configured. For direct Image fields you get `fetchpriority` (high/low/auto/none) and `decoding` (async/sync/auto/none). For media references rendered as entities you get an "Override image loading" checkbox that reveals the target image-field selector plus `loading` (lazy/eager), `fetchpriority` and `decoding`. Chosen values are applied through a trusted pre-render callback onto the image render arrays, so they reach the standard `image`, `image_style` and `image_formatter` output, including image styles and responsive images. It integrates with content displays, Views, Paragraphs and Layout Builder, and creates no configuration pages, permissions, routes or services.

---

- Mark an above-the-fold hero image `fetchpriority=high` to improve Largest Contentful Paint (LCP).
- Set `decoding=async` on content images so decoding does not block the main thread.
- Force a critical banner image to `loading=eager` when it must always render immediately.
- Lazy-load gallery or carousel images below the fold with `loading=lazy` and `fetchpriority=low`.
- Apply `fetchpriority`/`decoding` to a node's Image field directly from Manage display, no extra formatter to learn.
- Add loading/fetchpriority/decoding hints to media-library images rendered through a "Rendered entity" formatter.
- Pick which image field inside a media entity to override (e.g. `field_media_image`) when a bundle has more than one.
- Improve Google PageSpeed / Lighthouse Core Web Vitals scores site-wide by standardizing decoding=async.
- Configure the same attributes on an image field exposed in a Views display.
- Optimize responsive-image (picture element) output, since attributes flow into the image_style/image_formatter render.
- Tune per-view-mode performance: eager hero in the full view, lazy thumbnails in teasers.
- Prioritize product images on a commerce listing while deferring secondary thumbnails.
- Keep image markup semantics standard (native browser attributes) instead of relying on JavaScript lazy loaders.
- Apply attributes to images placed in Layout Builder blocks that use the Image or Rendered-entity formatter.
- Provide editors a no-code way to set performance hints they would otherwise need a developer or template override for.
- Set decoding hints on avatar/user-picture image fields.
- Differentiate loading strategy between first and subsequent items in a multi-value image field.
- Complement JavaScript lazy-loading modules (Blazy/Lazy) by covering native attribute output.
- Standardize image performance attributes across content types for consistent front-end behavior.
- Adjust attributes without touching Twig templates or writing a custom formatter plugin.
