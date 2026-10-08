<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor5 highlight — agent start

Thin CKEditor 5 wrapper adding the upstream `highlight.Highlight` plugin (Highlight button, `<mark>` output).
**Deprecated** — successor is `ckeditor5_plugin_pack`. Requires core `ckeditor5`, PHP 8.1, Drupal ^10.1.

- Configured via the text-format toolbar (drag the Highlight button). Allowed elements: `<mark>` + color classes.
- `hook_preprocess_field` attaches theme CSS only when a field's format enables the highlight toolbar item.
- No routes/permissions/settings form. Key files: `ckeditor5_highlight.ckeditor5.yml`, `.libraries.yml`, `.module`,
  `js/ckeditor5_plugins/highlight/src/index.js`.
- See ../usage.md.
