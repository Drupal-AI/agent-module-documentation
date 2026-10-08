<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Filelist formatter (filelist_formatter) — agent index

**A field formatter that renders a file field as an HTML `ul`/`ol` list, optionally with each file's size.**

- **Version:** 2.0.x (2.0.1)
- **Core:** ^11
- **Dependency:** file
- **Formatter id:** `filelist_formatter` (label "List") — `src/Plugin/Field/FieldFormatter/FileListFormatter.php`, extends `FileFormatterBase`.
- **Settings:** `filelist_formatter_type` (ul|ol), `filelist_formatter_class` (CSS classes), `filelist_formatter_filesize` (bool).
- **Render:** each file as `#theme => file_link` inside an `item_list`; size via `ByteSizeMarkup`.
- **Hooks:** `help` via `src/Hook/FilelistFormatterHooks.php` (attribute-based).

**Security:** display-only formatter, no routes/permissions/state; file access stays governed by core File. Class setting is `Html::escape`d in the summary.
