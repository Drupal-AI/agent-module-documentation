<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# NBSP — agent index

A CKEditor 5 plugin + text-format filter for inserting non-breaking spaces (`&nbsp;`). No
settings page, no configure route, no permissions, no Drush. All state lives in the standard
`editor.editor.<format>` (toolbar) and `filter.format.<format>` (filters) config entities.
Requires core `editor` + `ckeditor5`.

- **Enable it on a format (toolbar button + filter + allowed tag), config locations, recipes** →
  [configure/enable.md](configure/enable.md)

Key facts:
- CKEditor 5 toolbar item id: **`nbsp`** (label "Non-breaking space"); shortcut **Ctrl+Space**;
  ckeditor5 plugin id `nbsp.Nbsp`; inserts a `<nbsp>` element.
- Filter id: **`nbsp_cleaner_filter`** (title "Cleanup NBSP markup"); converts `<nbsp>` and
  legacy `<span class="nbsp">` to a real UTF-8 non-breaking space; irreversible transform.
- If "Limit allowed HTML tags" is enabled on the format, add `<nbsp>` to allowed tags.
