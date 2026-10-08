<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EPT Accordion — agent index

Ships an "Accordion/FAQ" Paragraph type (jQuery UI Accordion). Depends on `ept_core`, `paragraphs`,
`jquery_ui_accordion`. No config page (`configure` null), no permissions, no Drush, no own config
schema — the Paragraph types and their fields (default config) are the deliverable.

- **The two Paragraph types, their fields, and every `ept_settings_accordion` widget option (styles, collapsible, active, heightStyle, responsive)** → [configure/paragraph.md](configure/paragraph.md)

Key facts:
- Paragraph types: `ept_accordion` (wrapper) + `ept_accordion_section` (each item).
- Widget `ept_settings_accordion` (extends `ept_core`'s `EptSettingsDefaultWidget`) on the
  `ept_settings` field; passes options to `drupalSettings` → `js/jquery_ui_accordion/jquery_ui_accordion.js`.
- Style presets load libraries `text_only` / `plus_minus_left` / `plus_minus_right`.
- Global colors/breakpoints come from EPT Core (`/admin/config/content/ept-...` → `ept_core.settings`).
- Uninstall leaves Paragraph types in place by design (see `hook_uninstall`).
