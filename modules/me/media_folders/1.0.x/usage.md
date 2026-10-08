<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Folders gives Drupal's media a Windows-Explorer-style folder UI: a taxonomy-backed folder tree with drag-and-drop move/upload, thumbnail/list views, in-folder search, plus a field widget, a field formatter, a CKEditor 5 integration, and a bulk "Add to folder" action.

---

Folders are terms in a dedicated `media_folders_folder` taxonomy vocabulary (installed as config; the structure is logical only — it does not move the physical files). The browser lives at
`/admin/content/media-folders` (`MediaFoldersController::fileExplorer`, gated by core `access media overview`) with many AJAX sub-routes for navigating folders, searching, load-more paging, previewing a media item, uploading, and moving items between folders. Uploaded files are auto-assigned to a Media bundle based on file extension (configurable per extension), using smart-upload logic in `MediaFoldersUiActions`. Create/edit/delete of folders and media is protected by custom access callbacks that delegate to real entity permissions — folder ops check `administer taxonomy` or `<op> terms in media_folders_folder`, and media ops check the standard `create/update/edit <bundle> media` permissions (`MediaFoldersUiBuilder::hasTermPermission()` / `hasMediaCreateAccess()` / `canEditMedia()`). A `media_folders_widget` field widget (for `entity_reference` fields to media) and a `media_folders` field formatter let editors pick and display media through the folder browser; a CKEditor 5 plugin (`MediaFolders`, toggleable via the `disable_ckeditor` setting) embeds media from folders in rich text; and an `AddToFolder` action (derived per folder, plus `system.action.media_add_to_folder_action`) bulk-files media into a folder. Settings at `/admin/config/media-folders` cover default view mode, sort order, page size, thumbnails, CKEditor toggle, and per-extension → bundle mapping; a sync form (`/admin/config/media-folders/sync`, gated by `administer modules`) reconciles existing media into folders. The module's own permission, `access media folders configuration`, only gates the settings form.

---

- Browse all media in a familiar folder tree instead of the flat media list.
- Organise media into nested folders backed by the `media_folders_folder` vocabulary.
- Drag media items between folders to reorganise them.
- Drag files from the desktop onto a folder to upload them.
- Auto-assign uploaded files to the right Media bundle based on file extension.
- Configure which Media bundle each file extension maps to on upload.
- Switch between thumbnail and list view modes in the browser.
- Change the default sort order (e.g. newest first) of items in folders.
- Search for media within a folder using the in-folder search filter.
- Page through large folders with load-more.
- Preview a media item's details in an AJAX dialog.
- Create, rename (edit), and delete folders from the UI.
- Bulk "Add to folder" selected media via a media action.
- Let editors pick media through the folder browser using the `media_folders_widget` field widget.
- Display an entity-reference-to-media field through the `media_folders` formatter.
- Embed media from folders directly in CKEditor 5 rich text.
- Disable the CKEditor 5 integration via the `disable_ckeditor` setting when not wanted.
- Set the number of files shown per "page" in the browser (`pager_limit`).
- Show or hide image thumbnails in the browser.
- Sync/reconcile existing media into the folder structure from the sync form.
- Restrict folder create/edit/delete to users with the matching taxonomy permissions.
- Keep media create/edit gated by standard per-bundle media permissions.
- Give asset managers a lightweight DAM-style organisation layer over core Media.
- Configure the media edit form mode used per bundle inside the browser.
