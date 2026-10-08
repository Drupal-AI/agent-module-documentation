Bootstrap Simple Carousel provides a single "Bootstrap simple carousel block" that renders a Bootstrap 5 carousel from a list of admin-managed image items, each with alt/title, an optional link, and a caption.

---

The module defines a `bootstrap_simple_carousel` content entity (base table, no bundles) whose items hold an uploaded image file id, image alt/title, an image link, a caption title, caption text, a weight, and an active/inactive status. Items are managed through plain admin forms at `/admin/structure/bootstrap_simple_carousel` (list, add, edit, delete) — not the standard entity UI — behind the module's own `access bootstrap simple carousel` permission; note that images cannot be re-edited, only removed and recreated. Global carousel behavior lives in the `bootstrap_simple_carousel.settings` config (interval, wrap, pause-on-hover, indicators, controls, an "assets" toggle that loads Bootstrap 5.3.3 from a CDN, a Bootstrap image type class, and an image style) edited at `/admin/config/media/bootstrap_simple_carousel` behind core `administer site configuration`. The `CarouselBlock` block plugin renders only active items (ordered by weight desc) through the `bootstrap--simple--carousel--block.html.twig` template, applying the chosen image style and resolving each item link with `Url::fromUri()`; the block is visible to anyone with `access content`. If the "assets" setting is on, the block attaches the module's `bootstrap` library (Bootstrap JS+CSS from jsDelivr CDN); otherwise you must supply Bootstrap 5 yourself via a theme. All item text (alt, title, caption) is output through Twig autoescaping.

---

- Add a rotating image carousel/slideshow to a site region via the "Bootstrap simple carousel block".
- Build a homepage hero slider from a handful of uploaded images.
- Give each slide a caption title and caption text overlaid on the image.
- Link each slide to an internal path (e.g. `node/1`, `about`) or an external URL.
- Set custom alt and title text per slide for accessibility.
- Control the auto-advance interval (ms) between slides, or disable auto-cycling.
- Toggle continuous wrap-around vs. hard stops at the last slide.
- Pause slide cycling when the mouse hovers over the carousel.
- Show or hide the slide indicator dots.
- Show or hide the previous/next arrow controls.
- Apply a Drupal image style to all carousel images for consistent sizing.
- Choose a Bootstrap image type class (none, img-fluid, img-circle) for the slide images.
- Let the module load Bootstrap 5.3.3 assets from a CDN when the theme does not already provide Bootstrap.
- Reorder slides by setting per-item weights.
- Temporarily hide a slide by setting its status to Inactive without deleting it.
- Delegate carousel-item management to non-admin editors via the `access bootstrap simple carousel` permission.
- Place multiple instances of the carousel block in different regions through Block layout.
- Restrict where the carousel appears using core block visibility conditions.
- Provide a lightweight image slider without adding Views or a heavier slideshow module.
- Override the carousel markup by overriding the `bootstrap_simple_carousel_block` theme template in a custom theme.
- Upload GIF/PNG/JPG/JPEG images (up to ~25 MB each) into `public://bootstrap_simple_carousel/`.
