<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor TextIndent — agent start

Legacy CKEditor 4 plugin (`@CKEditorPlugin` id `textindent`). Requires `ckeditor` + `system`. Toggles inline
`text-indent` on `<p>` via command `ident-paragraph`; button + optional key (default Tab).

- Per-format setting `plugins.textindent.indentation` (default `2em`; JS fallback `50px`). Allow `p{text-indent}` in the format.
- Output is inline style filtered by the text format (no raw HTML path). Lang files en/pt-br/zh-hans.
- No routes/permissions. Key files: `src/Plugin/CKEditorPlugin/TextIndent.php`, `js/plugins/textindent/plugin.js`.
- See ../usage.md.
