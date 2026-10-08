<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extra Paragraph Types (EPT): Text (ept_text) — agent index

One ready-made **Paragraph type** (`ept_text`, label "EPT Text"): an optional title plus a WYSIWYG
rich-text body, carrying the **Extra Paragraph Types** family's shared design options. Dependencies:
`ept_core:ept_core`, `paragraphs:paragraphs`. Core `^10.1 || ^11 || ^12` (already declares Drupal 12).
Package "Extra Paragraph Types". Version `2.0.1` (row `2.0.x`).

Key facts:
- **Almost pure configuration.** No `src/`, no routes, no permissions, no services, no `.module`, no
  drush, no plugin types, no own config schema. The module is `config/install` (paragraph type + three
  fields + form/view displays) plus one Twig template.
- Fields on the `ept_text` bundle: `field_ept_title` (`text_long`, "Title"), `field_ept_text`
  (`text_long`, "Text" — the WYSIWYG body), and `field_ept_settings` (`ept_settings`, the design field
  whose type/widget/formatter are **owned by `ept_core`**).
- Access control comes entirely from Paragraphs and the host entity — this module adds none.
- The family design is *one module per component*, all sharing `ept_core` for the common design options
  (margin, padding, border, background color/image/video, edge-to-edge, container width). EPT is the
  **paragraph** family; EBT is the parallel **block** family.
- Rendering/styling machinery lives in `ept_core`, not here: `ept_core`'s `preprocess_paragraph`
  (`EptCoreHooks::preprocessParagraph` → `ept_core.generate_css`) sets the `styles` variable that this
  module's template emits.

## What you'd do → where

- **Understand the paragraph type — its three fields, the two displays, the Field Group tabs, and the
  shared design options + the EPT Core settings form** → [configure/paragraph-type.md](configure/paragraph-type.md)
- **The template, the CSS classes it adds, how the inline `styles` block is produced, and how to
  override the markup** → [theming/template.md](theming/template.md)
