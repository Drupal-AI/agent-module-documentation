<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DROWL Paragraphs for Bootstrap Type: Button (drowl_paragraphs_bs_type_button) — agent index

Provides the 'Button' Paragraphs bundle: a single link rendered as a Bootstrap call-to-action button. Submodule of **drowl_paragraphs_bs** (version dir 4.2.x), package `Paragraphs`, core `^10.3 || ^11`, GPL-2.0-or-later.

- **The bundle(s), fields, preprocess, template and styling** -> [paragraph-types/button.md](paragraph-types/button.md)

## What it actually is

- Bundle(s): `button`. Fields: `field_link` (link) and `field_settings`.
- Dependencies: `drowl_paragraphs_bs:drowl_paragraphs_bs`, `micon:micon_link`, `fences:fences`.
- Provides: no permissions, no routes, no services, no Drush, no config schema, no plugin types. Configuration is shipped `config/install` (paragraphs_type + fields + entity form/view displays + optional language content settings).
- Styling: UI Styles definitions (`*.ui_styles.yml`) whose classes are sorted onto sub-wrappers by `hook_preprocess_paragraph()`; the display template overrides `paragraph--drowl-paragraphs-bs--<bundle>.html.twig`, extending the base module template.
