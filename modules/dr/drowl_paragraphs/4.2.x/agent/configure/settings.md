<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DROWL Paragraphs configuration

## Global settings form
- Route: `/admin/config/system/drowl-paragraphs` (`drowl_paragraphs_settings`).
- Permission: **access drowl_paragraphs settings** (restrict access — trusted roles only).
- Stores config `drowl_paragraphs.settings`, notably slideshow defaults:
  - layout section width, autoplay, auto height, navigation arrows, navigation dots, infinite, center mode, controls-outside.
  - visible elements per breakpoint: `visible_elements_sm` / `_md` / `_lg`.

## Per-paragraph settings field
- Field type **DrowlParagraphsSettingsItem** (widget `DrowlParagraphsSettingsDefaultWidget`, formatter `DrowlParagraphsSettingsDefaultFormatter`) lets an individual paragraph carry display settings that override/supplement the global defaults.

## Submodules (enable what you need)
- `drowl_paragraphs_types` — base paragraph types.
- `drowl_paragraphs_type_layout_slideshow` — slideshow/carousel layout paragraph.
- `drowl_paragraphs_type_countdown`, `_markup`, `_score`, `_block_content`.
- `drowl_paragraphs_type_layout_restricted_access` — access-restricted layout section.
- `drowl_paragraphs_styles_ui` — manage paragraph styles.

## Build stack
Relies on Layout Paragraphs + Field Group + Foundation Sites + DROWL Layouts for a Foundation-based page-building experience.
