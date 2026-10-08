Background Image provides an integrated UI for attaching background images to a site — globally, per entity/bundle, per path/route, or per view — using the Media module for uploads and the Context module to decide which image shows where, with optional blur, full-viewport, and overlay-text effects.

---

The 3.x branch is a rewrite built on core Media and Responsive Image: you upload images as a "background_image" media type and configure image styles/breakpoints to control rendering, resizing, and effects. A `BackgroundImage` content entity (`background_image_field_data` table) holds the image (or a Media reference), a type (global / entity / bundle / path / route / view), a target, and a `settings` map (blur type + radius + speed, dark, full_viewport, preload background color, overlay text with a text format). The `background_image.manager` service resolves which background image applies to the current route/context and renders it; `hook_preprocess_html` adds `<base_class>-dark` / `<base_class>-full-viewport` body classes, and `hook_system_info_alter` injects a "Background Image" region into every theme. The Context module integration adds a **Background Image context reaction**, so you pick images via context conditions; two blocks (`background_image`, `background_image_text`) are also provided. CSS is generated from a `*.css.twig` template (overridable per theme, or via `hook_background_image_css_template_alter`), with retina media-query rules and preload/fallback/responsive image styles configured in `background_image.settings`. JavaScript (`scrolling.blur`, `runtime.css`) drives the scroll-triggered blur effect; a jscolor color picker (loaded from a CDN with a Subresource Integrity hash) powers color selection. The settings form at `/admin/config/media/background_image` currently only exposes the CSS `base_class`; most tuning happens on individual background image media items and via image styles. Admin actions are gated by `administer background image` (restrict access) and the settings form by core `administer site configuration`.

---

- Set a single site-wide (global) background image.
- Show different background images on different routes/paths using Context conditions.
- Attach a background image to a specific entity (e.g. one node) or to a whole bundle.
- Give a Views page its own background image.
- Add a blurred background that sharpens/blurs as the user scrolls.
- Render a full-viewport hero background behind page content.
- Overlay formatted text (heading/CTA) on top of a background image.
- Auto-add a `-dark` body class when the image is dark, to switch text colors.
- Serve responsive/retina background images via responsive image styles and DPR media queries.
- Preload the above-the-fold background image with a solid fallback color to avoid flashes.
- Manage background images as reusable Media entities (browse, reuse, permissions).
- Place a Background Image block or Background Image (text) block in a region.
- Use the auto-injected "Background Image" theme region for placement.
- Override the generated CSS by adding a `background_image.css.twig` to your theme.
- Alter the CSS template/variables programmatically via `hook_background_image_css_template_alter()`.
- Alter the rendered image element via `hook_background_image_build_alter()` (e.g. float a field over it).
- Inject or clean up overlay text via `hook_background_image_text_build_alter()` / `..._after_build_alter()`.
- Sample an uploaded image's average color to drive theming decisions.
- Pick colors in the admin UI with the bundled jscolor picker.
- Restrict who can manage background images with the `administer background image` permission.
- Choose per-image blur mode (none, on-scroll, on-scroll+full-viewport, always).
- Use tokens in background image configuration (module registers token support).
- Configure preload / fallback / responsive image styles centrally in settings.
- Provide a StageFileProxy-friendly setup for background images in non-prod environments.
