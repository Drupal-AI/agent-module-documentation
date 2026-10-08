<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DROWL Paragraphs for Bootstrap Type: Score (drowl_paragraphs_bs_type_score) — agent index

Provides the 'Score' Paragraphs bundle: numeric values rendered as an animated line / circle / semicircle gauge via progressbar.js. Submodule of **drowl_paragraphs_bs** (version dir 4.2.x), package `Paragraphs`, core `^10.3 || ^11`, GPL-2.0-or-later.

- **The bundle(s), fields, preprocess, template and styling** -> [paragraph-types/score.md](paragraph-types/score.md)

## What it actually is

- Bundle(s): `score`. Fields: `field_score_start`, `field_score_end`, `field_score_max` (decimals; storages shipped here), `field_score_prefix`/`_suffix`/`_max_prefix`/`_max_suffix` (strings; storages shipped here), `field_icon`, `field_text`, and `field_settings`.
- Dependencies: `drowl_paragraphs_bs:drowl_paragraphs_bs`, `micon:micon`.
- Provides: no permissions, no routes, no services, no Drush, no config schema, no plugin types. Configuration is shipped `config/install` (paragraphs_type + fields + entity form/view displays + optional language content settings).
- Styling: UI Styles definitions (`*.ui_styles.yml`) whose classes are sorted onto sub-wrappers by `hook_preprocess_paragraph()`; the display template overrides `paragraph--drowl-paragraphs-bs--<bundle>.html.twig`, extending the base module template.
