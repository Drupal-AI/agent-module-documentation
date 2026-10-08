<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DROWL Paragraphs for Bootstrap Type: Tabs & Accordion (drowl_paragraphs_bs_type_tabs_accordion) — agent index

Provides the 'Tabs / Accordion' container Paragraphs bundle (and its subtab child) that renders nested paragraphs as Bootstrap tabs or an accordion. Submodule of **drowl_paragraphs_bs** (version dir 4.2.x), package `Paragraphs`, core `^10.3 || ^11`, GPL-2.0-or-later.

- **The bundle(s), fields, preprocess, template and styling** -> [paragraph-types/tabs_accordion.md](paragraph-types/tabs_accordion.md)

## What it actually is

- Bundle(s): `container_tabs_accordion`, `container_tabs_accordion_subtab`. Fields: container: `field_paragraphs` (nested paragraphs), `field_settings`. subtab: `field_title`, `field_icon`, `field_anchor_id`, `field_paragraphs`.
- Dependencies: `drowl_paragraphs_bs:drowl_paragraphs_bs`, `fences:fences`, `micon:micon`.
- Provides: no permissions, no routes, no services, no Drush, no config schema, no plugin types. Configuration is shipped `config/install` (paragraphs_type + fields + entity form/view displays + optional language content settings).
- Styling: UI Styles definitions (`*.ui_styles.yml`) whose classes are sorted onto sub-wrappers by `hook_preprocess_paragraph()`; the display template overrides `paragraph--drowl-paragraphs-bs--<bundle>.html.twig`, extending the base module template.
