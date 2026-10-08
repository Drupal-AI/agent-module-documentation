<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
IMCE Rename Plugin adds a "Rename" toolbar button to the IMCE file browser so users can rename files and folders directly from the IMCE UI, gated by two new IMCE folder permissions (`rename_files`, `rename_folders`).

---

The module is a single IMCE plugin (`@ImcePlugin(id="rename")`, class `Rename`) plus a small JS file. It plugs into IMCE (the file browser used by CKEditor/file fields) rather than adding any Drupal admin page of its own — it has no configure route (`configure: null`), no settings form, and no `permissions.yml`. Instead it declares two **IMCE** permissions through the plugin's `permissionInfo()` — `rename_files` and `rename_folders` — which appear as per-folder checkboxes on each IMCE profile at `/admin/config/media/imce`. When a user has either permission, `buildPage()` attaches the `imce_rename_plugin/drupal.imce.rename` JS library, which adds a **Rename** toolbar button (shortcut Ctrl+Alt+W) and a "New name" form; submitting it sends the `rename` operation to `opRename()`. Server-side it validates permissions and the predefined path, sanitizes the new name (transliterate, crop to 50 chars, spaces→dashes, strip non-`\w_-` characters, fall back to a timestamp when empty), re-appends the original file extension, and uses `file.repository`'s `move()` for files (updating/creating the file entity) or PHP `rename()` for folders (also rewriting matching `file_managed.uri` rows and invalidating their cache tags). Renaming into an existing name is refused. It works on any IMCE-managed scheme (e.g. `public://`), not only images despite the description.

---

- Let editors rename an uploaded image file from the IMCE browser instead of re-uploading it.
- Give content authors a Rename button in the CKEditor "Browse" (IMCE) dialog.
- Rename a folder in IMCE and automatically fix the stored URIs of all files inside it.
- Grant only trusted roles the `rename_files` permission per folder via an IMCE profile.
- Allow renaming folders but not files (or vice versa) by toggling the two permissions independently.
- Clean up messy uploaded file names (spaces, punctuation, uppercase) via the built-in name sanitizer.
- Enforce filesystem-safe names by transliterating non-ASCII characters on rename.
- Cap overly long file names at 50 characters automatically on rename.
- Rename files under a user-specific IMCE folder (e.g. `users/user[user:uid]`).
- Prevent accidental overwrites — renaming to an existing name is rejected with an error message.
- Provide keyboard-driven renaming in IMCE with the Ctrl+Alt+W shortcut.
- Keep file entities in sync after a rename (the file entity is moved/updated, not orphaned).
- Rename media/library assets stored in `public://` through the file browser.
- Restrict renaming to a specific predefined path/profile so users can't rename outside their sandbox.
- Rename files on any stream wrapper IMCE exposes, not just images.
- Let site builders offer rename without granting full file-management/admin rights.
- Rewrite `file_managed` URIs after a folder rename so links to those files keep working.
- Invalidate cache tags for affected files after a folder rename so caches don't serve stale paths.
- Replace a bespoke rename script by using this ready-made IMCE operation.
- Offer a friendlier filename to end users (dashes instead of spaces) automatically.
- Rename profile/avatar images in a per-user IMCE folder.
