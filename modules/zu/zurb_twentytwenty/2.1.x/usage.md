<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
TwentyTwenty wraps ZURB's jQuery TwentyTwenty plugin as a Drupal image-field formatter: point a two-value image field at it and the rendered field becomes a draggable before/after comparison slider.

---

The module is deliberately tiny — one field formatter, one theme hook, one library definition, and no configuration form. `twentytwenty_field_formatter` (`TwentyTwentyFieldFormatter`, extending core's `ImageFormatterBase`) accepts `image` fields; on render it builds an `image_formatter` element per file, renders them into a single markup blob and hands that to the `zurb_twentytwenty` theme hook, whose template wraps them in `<div class="twentytwenty-container">`. `template_preprocess_zurb_twentytwenty()` attaches the `zurb_twentytwenty/twentytwenty` library, which loads `/libraries/twentytwenty/css/twentytwenty.css`, `jquery.event.move.js` and `jquery.twentytwenty.js` from the site's `/libraries` directory plus the module's own `drupal.twentytwenty.js` behavior. The JS calls `.twentytwenty()` on every `.twentytwenty-container` (guarded by `once`) using values from `drupalSettings.twentytwenty`. The third-party library is **not** shipped or pulled by Composer — `hook_requirements()` checks for `/libraries/twentytwenty/js/jquery.twentytwenty.js` at install and runtime and reports a hard error if it is missing. Formatter settings cover the image style plus the plugin's own options: default offset percentage, orientation, before/after labels, no-overlay, move-on-hover, move-with-handle-only, and click-to-move. The formatter expects the field's cardinality to be exactly 2 and prints a warning in its settings summary when it is not.

---

- Show a before/after comparison of a retouched photo.
- Present renovation or construction progress shots side by side.
- Compare a medical or scientific scan before and after treatment.
- Illustrate a design refresh (old site vs. new site screenshots).
- Demonstrate a product's effect (cleaning, restoration, cosmetics).
- Show seasonal changes of the same landscape.
- Compare map or satellite imagery across two dates.
- Present a "with and without" view of an image filter or effect.
- Show damage vs. repair in an insurance or property portfolio.
- Compare two variants in a portfolio case study.
- Give editors an image-comparison option without writing front-end code.
- Reuse an existing image field by switching only its display formatter.
- Apply an image style so both comparison images render at one consistent size.
- Change the starting handle position so the "after" image is mostly visible.
- Switch the slider to vertical orientation for tall images.
- Relabel the two sides ("2019"/"2024" instead of Before/After).
- Turn off the label overlay for a cleaner presentation.
- Let the slider follow the cursor on hover instead of requiring a drag.
- Allow click-to-jump so the comparison works on touch devices.
- Add the comparison to a teaser view mode as well as the full node display.
