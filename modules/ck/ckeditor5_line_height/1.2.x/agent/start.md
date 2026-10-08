<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor5 Line Height — agent index

Adds a **Line Height** dropdown to CKEditor 5. One CKEditor 5 plugin, no settings route, no
permissions, no services, no Drush. Its only persistent state is per-text-format editor config.

- **Add the button, set the allowed values, and where they are stored** →
  [configure/line-height.md](configure/line-height.md)

Key facts:
- Toolbar item id: `lineHeight`. CKEditor 5 plugin id: `ckeditor5_line_height_line_height`.
- Config lives in the editor entity: `editor.editor.<format>` →
  `settings.toolbar.items[]` must contain `lineHeight`, and
  `settings.plugins.ckeditor5_line_height_line_height.line_height_options` holds the value list.
- Default options: `0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5`. Values `>= 10` are dropped on save.
- Requires core `ckeditor5`. Only works on text formats that use the CKEditor 5 editor.
