<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor CodeMirror — agent index

Adds syntax highlighting to CKEditor 5's **Source** view via CodeMirror 5. One CKEditor 5
plugin (`ckeditor_codemirror_source_editing`), configured **per text format**. No settings
page (`configure` is unset), no permissions, no Drush, no services, no new plugin types.

- **Enable it on a text format, every settings key, drush recipes** →
  [configure/text-format.md](configure/text-format.md)
- **Required JS libraries, runtime option mapping, CKEditor 4 → 5 upgrade** →
  [api/libraries-and-runtime.md](api/libraries-and-runtime.md)

Key facts:

- Config lives in `editor.editor.<format>` →
  `settings.plugins.ckeditor_codemirror_source_editing` with keys `enable`, `mode`, `options`.
- The plugin has `conditions: {plugins: {ckeditor5_sourceEditing}}` — the format's
  `settings.toolbar.items` **must contain `sourceEditing`** or the tab never appears and the
  plugin never loads.
- Needs CodeMirror **5** at `/libraries/codemirror` and
  `@cdubz/ckeditor5-source-editing-codemirror` at `/libraries/ckeditor5-source-editing-codemirror`;
  `hook_requirements()` flags them on `/admin/reports/status`.
