<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DROWL Paragraphs for Bootstrap Type: Icon (drowl_paragraphs_bs_type_icon) — agent index

Provides the 'Icon' Paragraphs bundle: a Micon vector symbol combined with optional title, subtitle, text and link. Submodule of **drowl_paragraphs_bs** (version dir 4.2.x), package `Paragraphs`, core `^10.3 || ^11`, GPL-2.0-or-later.

- **The bundle(s), fields, preprocess, template and styling** -> [paragraph-types/icon.md](paragraph-types/icon.md)

## What it actually is

- Bundle(s): `icon`. Fields: `field_icon` (Micon icon), `field_link`, `field_subtitle`, `field_text`, `field_title`, and `field_settings`.
- Dependencies: `drowl_paragraphs_bs:drowl_paragraphs_bs`, `link_attributes:link_attributes`, `micon:micon`.
- Provides: no permissions, no routes, no services, no Drush, no config schema, no plugin types. Configuration is shipped `config/install` (paragraphs_type + fields + entity form/view displays + optional language content settings).
- Styling: UI Styles definitions (`*.ui_styles.yml`) whose classes are sorted onto sub-wrappers by `hook_preprocess_paragraph()`; the display template overrides `paragraph--drowl-paragraphs-bs--<bundle>.html.twig`, extending the base module template.
