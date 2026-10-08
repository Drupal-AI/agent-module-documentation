Background Image Field adds a `bg_img_field` field type (extending core Image) that renders an uploaded image as a responsive CSS `background-image` on a CSS selector you choose, emitting a `<style>` block with media queries built from a responsive image style.

---

The module provides a full field-type trio built on core Image and the Responsive Image module: a field type (`bg_img_field`, extends `ImageItem`), a widget (`bg_img_field_widget`, extends `ImageWidget`), and a formatter (`bg_img_field_formatter`, extends `ResponsiveImageFormatter`). Beyond a normal image upload, each field item stores four CSS properties — `css_selector` (a text selector, token-aware), `css_repeat`, `css_background_size`, and `css_background_position` (each a fixed set of radio options). At display time the formatter loads the chosen responsive image style, walks its breakpoints/multipliers, and generates CSS of the form `<selector> { background-image: url(...); }` wrapped in `@media` queries, then injects it into the page `<head>` as a `<style>` tag (or via the `background_style` theme template on Layout Builder routes). Selector values support tokens for the host entity (replaced via the Token module). Defaults restrict uploads to `png jpg jpeg svg` and drop alt/title fields (background images are decorative). A `bg_img_media_field` media source is also provided so the field can back a Media type. There is no global settings page (`configure` is null) and no permissions of its own; you add the field via Field UI and configure the responsive image style on Manage display. Only responsive image styles that map to a single image style are offered in the formatter.

---

- Add a responsive background image to a node, block, paragraph, or custom entity via a field.
- Target a specific CSS selector (e.g. `.hero`, `#banner`) with a per-item background image.
- Serve different background image sizes per breakpoint using a responsive image style.
- Provide retina/2x background images via device-pixel-ratio media queries automatically.
- Let editors pick background-repeat (inherit / no-repeat / repeat) per image.
- Let editors pick background-size (cover, contain, auto, initial, inherit) per image.
- Let editors pick background-position (center center, left top, etc.) per image.
- Use entity tokens in the CSS selector (e.g. include a node ID) for per-entity targeting.
- Restrict allowed upload extensions per field (default `png jpg jpeg svg`, e.g. add `webp`).
- Back a Media type with the `bg_img_media_field` source for reusable background images.
- Render a full-bleed hero section whose image adapts to the viewport.
- Query background images in Views like any other field.
- Hide the CSS settings from content editors (widget "Hide CSS Settings") while keeping defaults.
- Set default CSS selector/repeat/size/position at the field-settings level.
- Apply a background image to a Layout Builder section (uses the `background_style` template branch).
- Avoid inline styles on markup by centralizing background CSS in a `<style>` block.
- Give each piece of content its own background without touching theme CSS.
- Provide art-directed background images (different crops per breakpoint) via image-style mappings.
- Use SVG background images where supported.
- Replace multiple bespoke image fields + theme CSS with one reusable field type.
