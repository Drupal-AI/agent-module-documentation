<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DROWL Paragraphs for Bootstrap Type: Layout-Slideshow (drowl_paragraphs_bs_type_layout_slideshow) — agent index

Provides the 'Layout: Slideshow' Paragraphs container and Slick-based 1-6 column / custom slideshow layouts. Submodule of **drowl_paragraphs_bs** (version dir 4.2.x), package `Paragraphs`, core `^10.3 || ^11`, GPL-2.0-or-later.

- **The bundle(s), fields, preprocess, template and styling** -> [paragraph-types/layout_slideshow.md](paragraph-types/layout_slideshow.md)

## What it actually is

- Bundle(s): `layout_slideshow`. Fields: `field_background_media`, `field_resp_imagestyle`, `field_settings`. Layouts (`.layouts.yml`) and slideshow options (`.layout_options.yml`) are provided as layout_options plugins.
- Dependencies: `drowl_paragraphs_bs:drowl_paragraphs_bs`, `media_library:media_library`, `media_library_edit:media_library_edit`, `drupal:media`.
- Provides: no permissions, no routes, no services, no Drush, no config schema, no plugin types. Configuration is shipped `config/install` (paragraphs_type + fields + entity form/view displays + optional language content settings).
- Styling: UI Styles definitions (`*.ui_styles.yml`) whose classes are sorted onto sub-wrappers by `hook_preprocess_paragraph()`; the display template overrides `paragraph--drowl-paragraphs-bs--<bundle>.html.twig`, extending the base module template.
