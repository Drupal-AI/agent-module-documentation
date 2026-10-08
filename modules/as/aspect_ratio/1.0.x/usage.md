<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a decimal `field_aspect_ratio` to the core image media type and auto-fills it with each image's width/height ratio on save.

---

Image Aspect Ratio Tagging attaches a numeric aspect-ratio value to every image media item. On installation it creates a decimal field (`field_aspect_ratio`, precision 10 / scale 2) on the `media.image` bundle. A `hook_entity_presave` recomputes the value for any media entity on save: it loads the source file, checks the MIME type is `image/*`, calls PHP's `getimagesize()` on the file URI, and stores `width / height` (e.g. 16:9 → 1.78, 9:16 → 0.56, square → 1.00). An admin batch form at `/admin/config/media/aspect_ratio/recalculate` (permission `administer media`) recalculates the ratio for all existing image media at once. Storing the ratio as structured data makes it possible to sort, filter, and query images by shape and to drive responsive layout that reserves space (reducing layout shift). The value is a plain decimal; the module ships no formatter, widget, or CSS of its own.

---

- Auto-tag every image media item with its aspect ratio (width ÷ height) on save.
- Backfill the ratio for a whole existing image library via the recalculate batch form.
- Sort or filter media in a View by aspect ratio (landscape > 1, portrait < 1, square = 1).
- Find all landscape images by querying `field_aspect_ratio` > 1.
- Find all portrait images by querying `field_aspect_ratio` < 1.
- Find (near-)square images by querying `field_aspect_ratio` between ~0.98 and ~1.02.
- Expose the stored ratio to a theme/template to set a CSS `aspect-ratio` and reserve layout space.
- Reduce cumulative layout shift by knowing image proportions before render.
- Feed the ratio into responsive image / art-direction logic.
- Group media in the library by orientation using the numeric value.
- Drive masonry/grid layouts that need per-item proportions.
- Populate the ratio automatically when editors upload new images (no manual entry).
- Recompute ratios after a bulk image re-import or file replacement.
- Add the ratio to a media reference field's rendered display via standard decimal field formatters.
- Build a Views filter/facet for "orientation" from the decimal value.
- Query the ratio over JSON:API / REST like any other media field.
- Use the value in migrations or custom code by reading `field_aspect_ratio`.
- Call `aspect_ratio_calculate($media)` from custom code to (re)compute without saving.
- Call `aspect_ratio_calculate_and_save_by_id($id)` to recompute and persist one item.
- Audit which media are missing a ratio (empty field = non-image source or never saved since install).
- Provide a data source for image-shape reporting or content-quality dashboards.
