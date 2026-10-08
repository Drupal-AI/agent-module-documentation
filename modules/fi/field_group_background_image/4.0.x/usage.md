Field Group Background Image adds a "Background Image" field-group display formatter (for the Field Group module) that wraps the grouped fields in a `<div>` whose CSS background image is taken from an image or media field on the same entity.

---

The module provides a single `FieldGroupFormatter` plugin, `background_image`, available in the **view** context wherever Field Group is used (Manage display). When you set a field group's format to "Background Image", the group renders as a `container` `<div>` and the plugin's `preRender()` builds a `style` attribute: `background-image: url('…')` pointing at the selected image. The image source is chosen in the formatter settings from the entity/bundle's own image fields — either a core `image` field or an `entity_reference` field targeting `media` (in which case it walks the media entity's non-thumbnail image field to find the file URI). An optional image style can be applied (otherwise the original file is used), and URLs are made relative via the `file_url_generator` service. Additional settings let you set an HTML `id`, extra `inline_styles` appended verbatim to the style attribute, and — when the contrib **Color Field** module is present — a color field whose value is emitted as a `background-color` (supporting rgba opacity). A "Hide if missing image" option suppresses the whole group when the selected field has no image. It requires the Field Group module (and, optionally, Color Field for the background-color feature); it has no settings page, permissions, or Drush commands of its own — everything is configured per field group in the display settings.

---

- Turn a group of fields into a hero/banner section with a background image.
- Use a node's image field as the CSS background for a content region.
- Use a referenced media image as a field group's background.
- Apply an image style (e.g. a large/cropped derivative) to the background image.
- Render a full-width promotional block with text fields over an image background.
- Add a stable HTML `id` to the wrapping div for anchor links or custom CSS/JS.
- Append custom inline CSS (e.g. `background-size: cover; background-position: center;`).
- Overlay a semi-transparent background color from a Color Field over/with the image.
- Set a solid background color per entity via a color field (rgba with opacity).
- Hide the entire field group when no background image is provided.
- Build card layouts where each card's background comes from its own image field.
- Create per-node themed sections without writing a custom Twig template.
- Keep background images responsive by pairing an image style with inline `background-size`.
- Drive a landing-page section's look entirely from editorial fields (image + color).
- Reuse the same group across bundles, each supplying its own image field.
- Avoid hardcoding background images in theme CSS by making them content-editable.
- Combine grouped title/summary/CTA fields visually on top of an image.
- Switch a group between plain and image-backed presentation via display modes.
- Produce absolute-or-relative background URLs handled by Drupal's file URL generator.
