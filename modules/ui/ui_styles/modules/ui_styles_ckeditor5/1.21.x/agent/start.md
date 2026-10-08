<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UI Styles CKEditor 5 — agent index

Adds two CKEditor 5 toolbar buttons — **UI Styles (block)** and **UI Styles (inline)** — that
apply UI Styles CSS classes to a block element or an inline `<span>` in rich text. Configured
per text format on the CKEditor 5 toolbar; no route/permission/settings page of its own.

- **Toolbar items, enabling styles per format, and where enabled_styles is stored** →
  [configure/ckeditor5-styles.md](configure/ckeditor5-styles.md)

Key facts:
- CKEditor 5 plugins `ui_styles_ckeditor5_uiStylesBlock` / `..._uiStylesInline` (extend
  `UiStylesBase`); toolbar items `UiStylesBlock` / `UiStylesInline`.
- Enabled styles stored in `editor.editor.<format>` →
  `settings.plugins.ui_styles_ckeditor5_uiStyles{Block,Inline}.enabled_styles` (list of style
  plugin ids). Schema `ui_styles_ckeditor5_ckeditor5_plugin`.
- Requires `ckeditor5` + `ui_styles`.
