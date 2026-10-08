<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DROWL Paragraphs for Bootstrap Type: Anchor (drowl_paragraphs_bs_type_anchor) — agent index

Provides the invisible 'Anchor' Paragraphs bundle whose only job is to place a linkable in-page HTML anchor. Submodule of **drowl_paragraphs_bs** (version dir 4.2.x), package `Paragraphs`, core `^10.3 || ^11`, GPL-2.0-or-later.

- **The bundle(s), fields, preprocess, template and styling** -> [paragraph-types/anchor.md](paragraph-types/anchor.md)

## What it actually is

- Bundle(s): `anchor`. Fields: `field_anchor_id` (string, id attribute) and `field_anchor_title` (string, menu/scrollspy title; storage shipped here).
- Dependencies: `drowl_paragraphs_bs:drowl_paragraphs_bs`, `fences:fences`.
- Provides: no permissions, no routes, no services, no Drush, no config schema, no plugin types. Configuration is shipped `config/install` (paragraphs_type + fields + entity form/view displays + optional language content settings).
- Styling: UI Styles definitions (`*.ui_styles.yml`) whose classes are sorted onto sub-wrappers by `hook_preprocess_paragraph()`; the display template overrides `paragraph--drowl-paragraphs-bs--<bundle>.html.twig`, extending the base module template.
