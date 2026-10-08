<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Rename — agent index

Lets an admin rename an existing **managed file** (its on-disk name and its `file` entity
filename) via a dedicated rename form, plus optional "Rename" links on file-field widgets and
file operation links. No Drush, no plugins. Persistent state = one config flag
(`file_rename.settings:always_show_widget_link`) plus per-widget `show_rename_link`
third-party settings.

- **Turn the widget "Rename" link on (globally or per field) & where it is stored** →
  [configure/settings.md](configure/settings.md)
- **Who may rename files** (`rename files` permission + permanent-file access rule) →
  [permissions/permissions.md](permissions/permissions.md)
- **How a rename actually happens** — the rename route/form, image-style flush, and the
  `hook_file_prerename` / `hook_file_rename` hooks you can implement →
  [hooks/rename-hooks.md](hooks/rename-hooks.md)

Key facts:
- Rename route/form: `entity.file.rename_form`, path `admin/content/files/rename/{file}`
  (`_entity_form: file.rename` → `Drupal\file_rename\Form\FileRenameForm`).
- Settings form route: `file_rename.settings` (`/admin/config/file_rename/settings`).
- Only **permanent** files are renamable; the extension cannot be changed (fixed suffix).
