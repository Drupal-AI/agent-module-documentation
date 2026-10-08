<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor TextIndent

CKEditor 4 plugin that toggles a first-line text-indent on paragraphs.


## What & when

- Use it to let editors indent the first line of paragraphs (typographic paragraph indent).
- Adds a toolbar button and, optionally, a keyboard shortcut (default Tab) to toggle `text-indent` on `<p>`.
- Targets the legacy CKEditor 4 editor.

---

## Install & configure

- `composer require drupal/ckeditor_textindent` then `drush en ckeditor_textindent -y` (needs `ckeditor` and `system >= 8.1`).
- In a text format's CKEditor settings, add the **Text Indent** button.
- Set the indentation amount in the plugin settings (default `2em`; the JS default is `50px` if unset).
- Allow `p{text-indent}` (inline style) in the text format so the indent survives filtering.
- No permissions or routes.

---

## Usage & behaviour

- Toggle a first-line indent on the current paragraph(s) with the button or the configured key.
- Apply consistent typographic indentation across body content.
- The command `ident-paragraph` sets/removes `text-indent` via `node.setStyle`/`removeStyle`.
- Button state reflects whether the current paragraph is already indented (TRISTATE on/off).
- The indent key defaults to `tab`; it can be changed via `indentationKey` config (or disabled).
- The indent size is configurable per format via the settings textfield.
- Ships language files for en, pt-br, zh-hans.
- Works on selected ranges spanning multiple paragraphs.
- Output is an inline `style="text-indent:…"` on `<p>` — allow it in the format's filter.
- No server-side data stored beyond the produced HTML.
- Useful for prose-heavy content and print-like styling.
- Compatible with other CKEditor 4 plugins.
- Plugin id is `textindent`; the module is disabled-by-default at the editor level until added to a toolbar.
- Styling beyond the inline indent is left to the theme.
- The plugin is contextual (only relevant inside paragraphs).
