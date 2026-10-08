<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DROWL Paragraphs (drowl_paragraphs) — agent index

**Paragraphs UX/UI enhancements: a per-paragraph settings field, global layout/slideshow defaults, and many ready-made paragraph-type submodules.**

- **Version:** 4.2.x (4.2.57)
- **Core:** ^10.3 || ^11
- **Depends:** paragraphs, layout_paragraphs, field_group, foundation_sites, drowl_layouts, twig_tweak, responsive_background_image, breakpoint, field
- **Route:** `drowl_paragraphs_settings` `/admin/config/system/drowl-paragraphs` (`_form` DrowlParagraphsSettingsForm).
- **Permission:** `access drowl_paragraphs settings` (restrict access: TRUE).
- **Field:** `DrowlParagraphsSettingsItem` field type + widget + default formatter.
- **Submodules:** drowl_paragraphs_types, ..._type_layout_slideshow, ..._type_countdown, ..._type_markup, ..._type_score, ..._type_block_content, ..._type_layout_restricted_access, ..._styles_ui.

**Security:** Single admin config route gated by `access drowl_paragraphs settings` (restrict-access). No anonymous, mutating, or callback endpoints; no TLS/credential handling. No security findings.

See [configure/settings.md](configure/settings.md)