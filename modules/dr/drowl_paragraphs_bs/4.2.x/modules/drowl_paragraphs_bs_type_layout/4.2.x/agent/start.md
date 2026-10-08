<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DROWL Paragraphs for Bootstrap Type: Layout (drowl_paragraphs_bs_type_layout) — agent index

Provides the 'Layout: Grid' Paragraphs container bundle used by layout_paragraphs to group child paragraphs into Bootstrap grid regions. Submodule of **drowl_paragraphs_bs** (version dir 4.2.x), package `Paragraphs`, core `^10.3 || ^11`, GPL-2.0-or-later.

- **The bundle(s), fields, preprocess, template and styling** -> [paragraph-types/layout.md](paragraph-types/layout.md)

## What it actually is

- Bundle(s): `layout`. Fields: `field_background_media` (media), `field_resp_imagestyle`, `field_settings` (plus base fields `field_anchor_title`/`field_anchor_id`, `field_bgimage_classes`/`field_bgimage_options`, `field_link`, `field_paragraphs`).
- Dependencies: `drupal:media`, `drowl_paragraphs_bs:drowl_paragraphs_bs`, `media_library:media_library`, `fences:fences`.
- Provides: no permissions, no routes, no services, no Drush, no config schema, no plugin types. Configuration is shipped `config/install` (paragraphs_type + fields + entity form/view displays + optional language content settings).
- Styling: UI Styles definitions (`*.ui_styles.yml`) whose classes are sorted onto sub-wrappers by `hook_preprocess_paragraph()`; the display template overrides `paragraph--drowl-paragraphs-bs--<bundle>.html.twig`, extending the base module template.
