<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VBP Text and Image (vbp_text_and_image) — agent index

Submodule of **varbase_bootstrap_paragraphs**. Adds **one paragraph bundle**, `text_and_image`:
formatted text placed beside a media image, with a selectable column ratio and left/right image
position. Pure installed config + one Twig template + one CSS library — no PHP logic beyond a
`hook_theme()`. Core `~11.4.0`. Depends on
`varbase_bootstrap_paragraphs` (and, transitively, its stack). No own permission, no settings page,
no drush, no plugin types, no config schema.

It reuses the parent's shared styling fields (`bp_background`, `bp_gutter`, `bp_width`,
`bp_classes`, `bp_title`, `bp_title_status`, `bp_image_field`) and the parent's
`hook_preprocess_paragraph`, so width/background/gutter/title behave exactly as documented for the
parent — see [varbase_bootstrap_paragraphs](../../../../10.1.x/agent/start.md) and its
[theme/styling.md](../../../../10.1.x/agent/theme/styling.md).

- **The `text_and_image` bundle: its fields, layout ratios, and template** → [fields/text-and-image.md](fields/text-and-image.md)

Key facts:
- Paragraph type: `text_and_image` (label "Text and image"), library-conversion enabled
  (`paragraphs_library`).
- Own fields: `field_text_content` (`text_long`), `field_image` (entity_reference → media),
  `field_image_position` (`list_string`: `right`/`left`), `text_and_image_style` (`list_string`:
  `paragraph--style--50-50`, `--75-25`, `--66-33`, `--25-75`, `--33-66`).
- Template `paragraph--text-and-image.html.twig`, library `vbp_text_and_image/vbp_text_and_image_default`
  (`css/default.css`), theme hook `paragraph__text_and_image`.
- Install uses Vardot `ModuleInstallerFactory` (imports field/storage config, applies entity
  updates, assigns role permissions from `config/permissions/`).
