<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Lets editors add their own DSFR pictograms as media entities and exposes them in the picker.

---

`dsfr4drupal_picker_media` is a submodule of DSFR for Drupal - Picker. It turns the picker's pictogram catalogue into editable content: installing it creates a **Pictogram** media type (an SVG image source, backed by the `svg_image` module), a **Pictograms custom categories** taxonomy vocabulary, an optional category reference field on the media type, and the matching default and Media Library form/view displays (imported as optional config). Its hook class (`Dsfr4drupalPickerMediaHooks`) then lists every `pictogram` media entity as picker pictograms — grouping them by their category term (or a `custom` group when uncategorised) — resolves each entry to the uploaded SVG file's URL, and relabels category groups with the translated taxonomy term name. Editors manage pictograms through the normal media UI instead of writing code.

---

- Let non-developers add new DSFR pictograms by uploading SVGs as media.
- Organise custom pictograms into categories using the dedicated taxonomy vocabulary.
- Surface every uploaded pictogram automatically in the icon/pictogram picker.
- Reuse the same pictogram media across many fields and CKEditor insertions.
- Group pictograms in the picker under human-readable, translatable category labels.
- Add or rename pictogram categories without a deployment.
- Store pictograms as first-class media with alt text and revisions.
- Pick custom pictograms from the Media Library (dedicated media_library form/view display).
- Translate pictogram category labels per language via taxonomy term translation.
- Keep the built-in code-provided pictograms and add site-specific ones alongside them.
- Replace a pictogram's artwork by editing its media entity, updating everywhere it is used.
- Curate an approved set of brand pictograms editors can choose from.
- Migrate existing SVG assets into the Pictogram media type for reuse in the picker.
- Auto-create category terms on the fly while editing a pictogram (auto_create reference).
- Restrict pictogram files to SVG uploads via the media type's source field settings.
- Run `dsfr4drupal_picker_media_update_10001()` to import the category config on an existing install.
