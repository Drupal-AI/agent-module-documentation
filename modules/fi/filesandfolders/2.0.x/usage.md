<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Files and Folders provides a hierarchical file/folder management UI built on nodes: `folder` and `file` content types organized by a parent-folder reference, with a folder tree, an AJAX file browser, uploads with automatic thumbnail generation (images, PDFs, Office docs via Imagick/LibreOffice), and role-based folder visibility.

It exposes a `/files-and-folders` interface (and a block), plus many AJAX endpoints for listing, creating, renaming, moving, deleting, downloading, and uploading items.

---

- Requires core node/views/file/image/field/field_ui/user/datetime/options; Drupal 9 or 10.
- Enable with `drush en filesandfolders` (machine name `files_and_folders`).
- Configure at `admin/config/files-and-folders/settings` (permission: "administer site configuration") — storage scheme (public/private), custom directory, layout, icon size.
- Grant the module's permissions (access, create/edit/delete own/any folder & file content, view private/public, manage root folders, options).
- Browse at `/files-and-folders`; place the Files and Folders block where needed.
- Folder access is role-based via each folder's `field_authorized_roles`; thumbnail generation for Office docs shells out to LibreOffice (`soffice`) and Imagick.

---

- Organize files into a nested folder hierarchy.
- Upload files through an AJAX interface into a chosen folder.
- Auto-generate thumbnails for images, PDFs, and Office documents.
- Browse a collapsible folder tree.
- Search files/folders by title.
- Create root folders and subfolders with authorized roles.
- Rename, move, and delete files/folders via AJAX.
- Download files through a controller route.
- Mark items public or private (visibility field).
- Restrict folder visibility to specific roles.
- Switch list/grid layout and icon size (saved to config).
- Show file-type icons and human-readable sizes (Twig extensions).
- Embed the manager as a block.
- Calculate folder sizes recursively.
- Manage per-user vs any-user edit/delete permissions.
- Provide an alternative to the core file browser for site editors.
