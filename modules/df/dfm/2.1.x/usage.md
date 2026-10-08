<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drupella File Manager (DFM) is an Ajax, drag-and-drop file manager exposed at `/dfm/{scheme}` that lets permitted users browse, upload, rename, move, copy, delete, resize and crop files within a stream-wrapper scheme, with integrations for CKEditor 5, BUEditor and file/image field widgets.
---
DFM solves in-site file management and media picking without leaving Drupal. Access to `/dfm/{scheme}` is decided by `Dfm::access()`, which grants the file manager only if the current user has a `dfm_profile` config entity assigned to one of their roles for that scheme (user 1 always gets the built-in `admin` profile). A profile defines allowed folders and per-folder permissions (browse/upload/delete/etc.), upload extensions, size limits and quota; role→profile→scheme mappings and options like folder merging live in `dfm.settings`, managed at `/admin/config/media/dfm` (permission `administer dfm`). The actual filesystem operations are performed by a bundled PHP library under the module's `library/` directory (loaded via `require_once` in `Dfm::userFm()`); the Drupal side registers plugin hooks in `DfmDrupal` that keep `file_managed` records, quotas and node/block body references in sync on upload/delete/rename/move/copy/resize.

Operational and security notes: DFM constrains where users can act. Folder paths are checked by `Dfm::regularPath()`, whose regex rejects backslashes and any current/parent-directory (`.`/`..`) segments, guarding against path traversal in profile folder configuration; an optional chroot-jail collapses a profile to a single top directory. Uploads run Drupal file validators and honor the core `allow_insecure_uploads` setting; DB operations use parameterized queries with `escapeLike`. Granting a profile to the anonymous/authenticated role directly exposes file operations to those users. The typical setup task is: create a profile with the folders and permissions you want, then map it to a role and scheme in the settings form.
---
- Browse files in the public scheme at `/dfm/public`.
- Upload files via drag-and-drop into an allowed folder.
- Restrict which file extensions users may upload per profile.
- Set an upload size limit and a per-user disk quota.
- Rename or move files and folders from the UI.
- Copy files within the managed folders.
- Delete files (with file-usage checks to avoid breaking references).
- Resize or crop images in place.
- Create a "member" profile granting limited folder access.
- Create an "admin" profile with full folder access.
- Map a role to a profile for a specific stream-wrapper scheme.
- Give different roles different profiles per scheme.
- Enable the DFM image/link buttons in a CKEditor 5 text format.
- Use DFM as the file browser for BUEditor image/link dialogs.
- Add a "Select file" link to a file/image field widget via DFM.
- Restrict a profile to a single directory using the chroot jail.
- Merge folder permissions across multiple role profiles.
- Serve absolute file URLs by enabling the abs_urls option.
- Attach DFM to matching textareas via the textareas setting.
- Keep node/block body file references updated on move/rename.
- Localize the DFM UI using Drupal translation strings.
- Auto-create managed file entities for files added outside Drupal.
- Audit profile folder rules so users only reach intended directories.
- Duplicate a profile to derive a new one quickly.
