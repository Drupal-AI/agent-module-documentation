<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DROWL Paragraphs for Bootstrap Type: Image in Text (drowl_paragraphs_bs_type_image_text) — agent index

Provides the 'Image in Text' Paragraphs bundle: a floated image that body text wraps around, with optional CSS shape. Submodule of **drowl_paragraphs_bs** (version dir 4.2.x), package `Paragraphs`, core `^10.3 || ^11`, GPL-2.0-or-later.

- **The bundle(s), fields, preprocess, template and styling** -> [paragraph-types/image_text.md](paragraph-types/image_text.md)

## What it actually is

- Bundle(s): `image_text`. Fields: `field_image` (media), `field_image_clip_path` (string_long; storage shipped here), `field_image_zoomable`, `field_link`, `field_resp_imagestyle`, `field_text`, and `field_settings`.
- Dependencies: `drowl_paragraphs_bs:drowl_paragraphs_bs`, `link_attributes:link_attributes`, `drupal:media`, `media_library:media_library`, `media_library_edit:media_library_edit`, `fences:fences`, `field_formatter:field_formatter`.
- Provides: no permissions, no routes, no services, no Drush, no config schema, no plugin types. Configuration is shipped `config/install` (paragraphs_type + fields + entity form/view displays + optional language content settings).
- Styling: UI Styles definitions (`*.ui_styles.yml`) whose classes are sorted onto sub-wrappers by `hook_preprocess_paragraph()`; the display template overrides `paragraph--drowl-paragraphs-bs--<bundle>.html.twig`, extending the base module template.
