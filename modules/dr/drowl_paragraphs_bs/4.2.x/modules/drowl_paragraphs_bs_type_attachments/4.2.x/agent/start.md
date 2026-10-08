<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DROWL Paragraphs for Bootstrap Type: Attachments (drowl_paragraphs_bs_type_attachments) — agent index

Provides the 'Files / Downloads' Paragraphs bundle that references media documents and lists them for download. Submodule of **drowl_paragraphs_bs** (version dir 4.2.x), package `Paragraphs`, core `^10.3 || ^11`, GPL-2.0-or-later.

- **The bundle(s), fields, preprocess, template and styling** -> [paragraph-types/attachments.md](paragraph-types/attachments.md)

## What it actually is

- Bundle(s): `attachments`. Fields: `field_attachments` (multi-value media entity reference; storage shipped here), `field_nodeentityrefvm` (embedded view-mode selector) and `field_settings`.
- Dependencies: `entity_reference_display:entity_reference_display`, `drowl_paragraphs_bs:drowl_paragraphs_bs`, `media_library:media_library`, `media_library_edit:media_library_edit`, `fences:fences`, `drupal:media`.
- Provides: no permissions, no routes, no services, no Drush, no config schema, no plugin types. Configuration is shipped `config/install` (paragraphs_type + fields + entity form/view displays + optional language content settings).
- Styling: UI Styles definitions (`*.ui_styles.yml`) whose classes are sorted onto sub-wrappers by `hook_preprocess_paragraph()`; the display template overrides `paragraph--drowl-paragraphs-bs--<bundle>.html.twig`, extending the base module template.
