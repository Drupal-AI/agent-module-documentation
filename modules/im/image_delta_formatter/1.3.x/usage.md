<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Image and Media Delta Formatter adds field formatters that display only specific deltas (positions) of a multi-value image, responsive image, or media field — for example "show just the first image" — instead of rendering every value.

---

The module provides a trio of field formatters that each extend a core image/media formatter and add a "Delta" setting: `image_delta_formatter` (label "Image delta", for `image` fields, extends core `ImageFormatter`), `responsive_image_delta_formatter` (label "Responsive image delta", for `image` fields, extends `ResponsiveImageFormatter`), and `media_delta_formatter` (label "Media delta", for `entity_reference` media fields, extends `MediaThumbnailFormatter`). Only `image_delta_formatter` is a normal annotated/attribute plugin; the responsive-image and media formatters are registered *conditionally* through `hook_field_formatter_info_alter()` in `image_delta_formatter.module`, appearing only when the core `responsive_image` or `media` module is enabled respectively (this is why they live under `src/OptionalPlugin/` without a plugin annotation). All three share `ImageDeltaTrait`, which adds two settings: `deltas` (a required text field taking a single delta or comma-separated list such as `0, 1, 4`) and `deltas_reversed` (a checkbox to count from the last value). At display time `getEntitiesToView()` unsets every item whose delta is not in the selected list, then optionally reverses the result. Deltas are stored as a normalized integer sequence (validated `>= 0`); the trait also tolerates legacy scalar/string values. You configure it entirely on the entity's *Manage display* page (choose the formatter, click the gear, enter the deltas) — there is no admin settings page, no permissions, and no dependencies beyond core Image.

---

- Show only the first image (delta `0`) of a multi-value image field in a teaser.
- Display the second and third images (`1, 2`) of a gallery field in a specific region.
- Render just the last uploaded image using the "Reversed" option with delta `0`.
- Pull a single "hero" image out of a multi-image field for the full node view.
- Show a specific slide from a multi-value media field on a landing page.
- Display image #4 of a product's photo set in a summary card.
- Use "Responsive image delta" to show one delta with responsive image styles.
- Show the first media thumbnail from a multi-value media reference field.
- Split one image field across two display regions by using different deltas per view mode.
- Render a cover image (delta `0`) separately from the rest of a gallery.
- Show only selected deltas (`0, 2, 4`) to create an every-other-image layout.
- Present the newest image first by reversing and taking delta `0`.
- Avoid a custom preprocess/Twig loop just to output one image from a multi-value field.
- Display a single representative media item in a search result row.
- Show the first responsive image of a multi-value field with art-directed styles.
- Feature one image in a Layout Builder block sourced from a multi-image field.
- Output a specific delta of a media:image field via the "Media delta" formatter.
- Keep a multi-image field but surface only its lead image in listings.
- Use different deltas of the same field in teaser vs full view modes.
- Show a fixed subset of images (e.g. first three) in a compact card.
- Reverse a chronologically appended image field to show the most recent images.
- Render a single thumbnail from a media gallery without installing a slideshow module.
- Configure per-display which image position appears, with no code.
- Link the chosen delta image to its content or file using the inherited image-link setting.
