<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Folders — agent index

Folder-tree UI for Media, backed by the `media_folders_folder` taxonomy vocabulary. Browser at
`/admin/content/media-folders`. Depends on `taxonomy`, `media_library`, `user`. Config UI
`media_folders.configuration` (`/admin/config/media-folders`).

- **Settings keys, the vocabulary, sync form, routes** → [configure/settings.md](configure/settings.md)
- **Permissions + the custom access model for folder/media ops** →
  [permissions/permissions.md](permissions/permissions.md)
- **Field widget, formatter, CKEditor 5 plugin, and the bulk action** →
  [plugins/plugins.md](plugins/plugins.md)

Key facts:
- Folders = taxonomy terms; the tree is logical only (files are not physically moved).
- Browsing routes require core `access media overview`; create/edit/delete use `_custom_access`
  callbacks that delegate to real entity permissions (taxonomy + per-bundle media).
- Own permission `access media folders configuration` gates only the settings form; the sync form
  requires `administer modules`.
- Uploads auto-map to a Media bundle by file extension (configurable per extension).
