<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# IMCE Rename Plugin — agent index

Adds a **Rename** button to the [IMCE](https://www.drupal.org/project/imce) file browser so users
can rename files and folders. It is one IMCE plugin (`@ImcePlugin(id="rename")`) plus a JS file.
No Drupal admin page of its own (`configure: null`), no `permissions.yml`, no config schema, no
Drush. It depends on `imce`.

- **The rename plugin: operation, name sanitization, file vs folder handling, JS button** →
  [plugins/rename-plugin.md](plugins/rename-plugin.md)
- **The two IMCE permissions (`rename_files`, `rename_folders`) and how to grant them per folder** →
  [permissions/rename-permissions.md](permissions/rename-permissions.md)

Key facts:
- Permissions are **IMCE folder permissions**, stored on each IMCE profile at
  `imce.profile.<id>.conf.folders[N].permissions.rename_files` / `.rename_folders` (booleans),
  configured under *Configuration → Media → IMCE* (`/admin/config/media/imce`).
- The Rename button/JS is only attached when the user has `rename_files` or `rename_folders`.
- New names are transliterated, cropped to 50 chars, spaces→dashes, non-`\w_-` stripped; the
  original extension is re-appended for files.
