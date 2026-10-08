Responsive Background Image is a developer-only helper: a single static PHP method you call from a `hook_preprocess_HOOK()` to generate a `<style>` tag of CSS media queries that apply a Drupal Responsive Image Style as a responsive `background-image` on a chosen CSS selector.

---

There is no UI, no config, no permissions, and no admin routes — the module is meant for themers/developers. Its whole surface is `ResponsiveBackgroundImage::generateMediaQueries($css_selector, $entity, $field_machine_name, $responsive_image_style_machine_name, $media_entity_field_machine_name = 'field_media_image')`. You pass a unique CSS selector, an entity (a `ContentEntityBase` holding an Image or Media-image field, or a `File` directly), the image field's machine name, and the machine name of a Responsive Image Style. The method resolves the file uri, reads the Responsive Image Style's fallback + per-breakpoint image-style mappings (from the theme/Responsive Image breakpoint group), and builds `background-image: url(...)` rules — a base rule, one `@media` block per breakpoint at 1x, and matching `min-device-pixel-ratio: 1.5` blocks for 2x mappings. It returns a `#type => 'html_head'` style-tag render array (wrapped in `Markup::create()` so the `&` in image URLs is not escaped) plus a unique key; you assign that to `$vars['#attached']['html_head'][]`. It supports the classic Image field and Media image fields (via the `media` module), and only the Responsive Image Style "single image style per breakpoint" option (not the `sizes` attribute option). It returns `FALSE` and logs to the `responsive_background_image` channel when the field/target is empty or the field type is unsupported.

---

- Apply a responsive background image to a Paragraph's hero region that swaps image files by breakpoint.
- Serve a smaller background image on mobile and a larger one on desktop via Responsive Image Styles.
- Serve 2x (retina) background images using device-pixel-ratio media queries.
- Set a background image from a classic core Image field on a node or block.
- Set a background image from a Media (image) reference field.
- Set a background image directly from a `File` entity you already loaded.
- Use a per-entity unique CSS class (e.g. `.paragraph--id--21 .hero__image`) so multiple heroes on one page get different backgrounds.
- Generate the CSS entirely at render time from an existing Responsive Image Style — no extra config entity.
- Reuse your theme's Breakpoint Group to control the min/max-width and pixel-ratio of the generated queries.
- Provide a fallback background image (from the Responsive Image Style's fallback image style) for browsers without matching media queries.
- Attach the generated `<style>` tag into the HTML `<head>` from a preprocess hook.
- Add responsive backgrounds to Custom Blocks or Nodes, not just Paragraphs.
- Avoid inlining background images per element and instead centralize them in head media queries.
- Log and gracefully skip when a referenced media/file has been deleted (returns FALSE).
- Combine with `background-size: cover` CSS you write yourself to complete the effect.
- Build a hero/banner component in a custom theme without a heavier slider or media module.
