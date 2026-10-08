<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Ckeditor5 HTML Embed — agent index

Adds an **HTML embed** button to CKEditor 5 (wraps CKEditor's `HtmlEmbed` feature) so editors can
embed raw HTML snippets. **No PHP, no configure route, no permissions, no Drush, no config schema.**
Configuration is entirely per-text-format editor config. Depends on core `ckeditor5`.

- **Add the button to a text format, config location, allowed elements, filter/security notes** →
  [configure/enable.md](configure/enable.md)

Key facts:
- Toolbar item id: **`htmlEmbed`** (label "HTML Embed"). CKEditor JS plugin: `htmlEmbed.HtmlEmbed`.
- Enabled by adding `htmlEmbed` to a format's toolbar; stored at
  `editor.editor.<format>` → `settings.toolbar.items[]`.
- Produces elements `<div>` and `<div class="raw-html-embed">`; `showPreviews` is `false`.
- The module's CKEditor 5 plugin definition id (Drupal side) is `ckeditor_html_embed_html_embed`.
