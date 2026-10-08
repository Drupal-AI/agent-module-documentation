<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Background Image Formatter adds field formatters that render an image (or media image) as a CSS `background-image` instead of an `<img>` tag. You pick it on *Manage display*, choose an image style and whether to write the background as an inline `style` attribute or as a generated CSS rule for a selector.

---

The module ships two field formatters. `background_image_formatter` (id `background_image_formatter`, extends core `ImageFormatter`) applies to plain **image** fields; `background_media_image_formatter` (extends `EntityReferenceEntityFormatter`) applies to **entity_reference** fields that target **media** (it reads the media entity's `thumbnail`). Both share the same settings: `image_style` (an image style machine name, or empty for the original), `background_image_output_type` (`inline` or `css`), `background_image_selector` (a CSS selector/class), `background_image_link` (bool, wrap the div in a link — inline mode only) and `background_image_link_custom` (a link URL, which supports tokens when the Token module is enabled). In **inline** mode it renders the `background_image_formatter_inline` theme (a `<div class="…" style="background-image:url('…')">`), optionally wrapped in an `<a>`; the selector gets `_<entity id>` appended so each item is unique. In **css** mode it emits a `<style>` element into `html_head` of the form `<selector> {background-image: url("…");}`. Settings are stored in the `entity_view_display` config under `content.<field>.settings`. The formatter integrates with core image styles (generating derivatives as needed) and provides granular theme suggestions per entity type, bundle, field and entity id. It has no admin settings page, no route, no permission and no Drush — it is configured entirely on the field's *Manage display*.

---

- Render a content type's hero image field as a full-bleed CSS background instead of an `<img>`.
- Output an inline `style="background-image:url(...)"` div for a banner image field.
- Generate a `<style>` rule targeting a CSS selector so a section background comes from a field.
- Apply an image style (e.g. a large/cropped derivative) to the background image.
- Use a Media reference field as the background image source via `background_media_image_formatter`.
- Build card components where each card's background image comes from its image field.
- Wrap the background-image div in a link to the host entity (inline mode).
- Link the background image to a custom URL, using tokens for dynamic destinations.
- Drive a slideshow/hero region background from a multi-value image field (one div per item).
- Set a per-entity unique selector so multiple backgrounds on a page do not collide.
- Provide theme-suggestion hooks to customise the background markup per bundle or field.
- Show a background image in a View by choosing the formatter on the View's field.
- Replace theme-level background CSS with editor-managed background images.
- Keep the original image (no image style) as the background when full resolution is wanted.
- Attach a `background-image` to an arbitrary selector shared by several page elements.
- Let editors change a section's background by uploading a new image to a field.
- Render responsive-ish backgrounds by pairing an image style with the formatter.
- Produce a print-friendly `<style>`-based background rather than inline attributes.
- Use tokens (with the Token module) to compute the wrapping link per rendered entity.
- Avoid writing a custom formatter plugin just to move an image into `background-image`.
- Theme a landing page's masthead from a Media library image reference.
- Standardise background-image markup across many content types with one formatter.
