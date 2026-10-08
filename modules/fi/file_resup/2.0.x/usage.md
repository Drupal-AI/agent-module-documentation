<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
File Resumable Upload adds chunked, resumable, drag-and-drop uploading to Drupal's standard `managed_file` file-field widgets, so users can upload very large files (beyond PHP's per-request post/upload limits), select multiple files at once, and resume an interrupted upload where it left off.

---

The module attaches to any file-type field widget via `hook_field_widget_complete_form_alter`; you turn it on per field by ticking *Enable resumable upload* in the field's "Resumable Upload Settings" (stored as `file_resup` third-party settings on the `field_config`). When enabled it injects a hidden `resup` element plus a JS library (`js/resup.js` + `js/file-resup.js`, built on `core/drupal.progress`) that slices each selected file into fixed-size chunks (default 2 MB, from `file_resup.default_chunk_size` config) and streams them to the `file-resup/upload` route. That controller (`UploadController`) handles a GET "initialise/resume" call (which reconstructs the target entity form to read its `#upload_validators` and `#upload_location`, validates filename/extension/size/scheme, creates a `file_resup` tracking entity, and returns how many chunks already landed) and POST "append chunk" calls (which lock and append each chunk to a temp file under `<scheme>://file_resup_temporary/`, guarded by an auto-written `.htaccess`). When the real entity form is finally submitted, `FileFormAlterBase::saveUpload()` verifies completeness, re-runs core file validators, renames executable extensions to `.txt`, moves the assembled file to the field's real destination, and creates the `file` entity. Per-field options include a *Maximum upload size* override and *Start upload on files added* (auto-upload); a global *Prevent Duplicates* setting makes repeat uploads of the same name reuse the existing file. A submodule, `file_resup_media_library`, brings the same behaviour to the Media Library "Add media" upload form.

---

- Let editors upload multi-gigabyte video/archive files that exceed PHP's `upload_max_filesize`/`post_max_size`.
- Resume a large upload after a dropped connection or browser refresh instead of restarting.
- Add drag-and-drop, chunked uploading to an existing file field without changing the field type.
- Enable resumable upload on a specific Article/media file field via its *Resumable Upload Settings*.
- Upload multiple files into a multi-value file field in one drag-and-drop action.
- Cap per-field uploads with a *Maximum upload size* larger than the site's PHP limit.
- Auto-start uploading as soon as files are dropped (no separate "Upload" click).
- Show a live progress bar during chunked uploads via `core/drupal.progress`.
- Reduce memory pressure on the web server by never buffering a whole large file in one request.
- Tune the chunk size (e.g. smaller chunks on flaky networks) via `file_resup.default_chunk_size`.
- Reuse a previously uploaded identical file name instead of re-uploading (Prevent Duplicates).
- Bring resumable/chunked upload to the Media Library add form (via `file_resup_media_library`).
- Keep uploads inside the field's configured storage scheme (public/private) and destination directory.
- Enforce the field's own extension allow-list on resumable uploads (rejected early on init).
- Automatically neutralise executable uploads (`.php`, `.pl`, `.py`, `.cgi`, `.asp`, `.js`) by appending `.txt`.
- Support very large stored file sizes via the `big`-int `filesize` column added in an update hook.
- Store in-progress uploads in a private, `.htaccess`-protected temporary directory until finalised.
- Give anonymous or authenticated users a consistent large-file upload UX across content forms.
- Restrict the number of files a widget accepts based on the field's cardinality.
- Localise/reuse the standard core file-upload help text and validators for the enhanced widget.
