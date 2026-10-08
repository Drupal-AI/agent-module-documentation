<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DROWL Paragraphs for Bootstrap Type: Card (drowl_paragraphs_bs_type_card) — agent index

Provides the 'Card / Tile' Paragraphs bundle: image + title + subtitle + text + link as a Bootstrap card or image-overlay tile. Submodule of **drowl_paragraphs_bs** (version dir 4.2.x), package `Paragraphs`, core `^10.3 || ^11`, GPL-2.0-or-later.

- **The bundle(s), fields, preprocess, template and styling** -> [paragraph-types/card.md](paragraph-types/card.md)

## What it actually is

- Bundle(s): `card`. Fields: `field_image` (media ref), `field_image_zoomable` (bool), `field_link` (link), `field_resp_imagestyle`, `field_subtitle`, `field_text`, `field_title`, and `field_settings`.
- Dependencies: `drowl_paragraphs_bs:drowl_paragraphs_bs`, `link_attributes:link_attributes`, `media_library:media_library`, `media_library_edit:media_library_edit`, `fences:fences`, `field_formatter:field_formatter`, `drupal:media`.
- Provides: no permissions, no routes, no services, no Drush, no config schema, no plugin types. Configuration is shipped `config/install` (paragraphs_type + fields + entity form/view displays + optional language content settings).
- Styling: UI Styles definitions (`*.ui_styles.yml`) whose classes are sorted onto sub-wrappers by `hook_preprocess_paragraph()`; the display template overrides `paragraph--drowl-paragraphs-bs--<bundle>.html.twig`, extending the base module template.
