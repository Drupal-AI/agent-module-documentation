<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bulk-upload many files via DropzoneJS and turn each into a media entity of the appropriate bundle.

---

Two routes: the upload form `UploadMediaForm` at `/media/upload` (permission **`upload media`**) and the config form `MediaUploadConfigurationForm` at `/admin/config/media/upload` (permission **`administer media_upload configuration`**). The admin form maps each of the video/image/document/audio buckets to a media bundle + file-reference field, and pulls the allowed extensions and max size from that field's settings (stored read-only into `media_upload.settings`), plus total and single-file size limits. The upload form renders a `dropzonejs` element whose `#extensions` is the union of configured extensions. On submit (`UploadMediaForm::submitForm`), for each uploaded temp file it parses name+extension with `FILENAME_REGEX`, resolves the bundle via `getBundleForFile()` (extension must be in the configured allow-list, else "File extension is not allowed"), enforces per-bundle and total size limits, writes the bytes with `FileRepository::writeData(...EXISTS_REPLACE)` into the field's configured `uri_scheme`+`file_directory`, then creates and saves a media entity. Security: the route requires the `upload media` permission (not anonymous) and DropzoneJS permissions; extension is validated against the admin-configured allow-list derived from the media field. Hardening caveat: the final write uses the (DropzoneJS-sanitised) filename and does not additionally call `file_munge_filename()`, so safety rests entirely on the media field's allowed-extensions list - do not permit executable/HTML extensions on those fields.

---

- Let editors drag-and-drop dozens of files and create media entities in one action.
- Auto-route each file to the right media bundle (image/video/document/audio) by extension.
- Enforce a per-file size limit and a total-batch size limit.
- Reuse the allowed extensions already configured on the target media field.
- Bulk-seed a media library from a folder of assets.
- Replace an existing file of the same name (EXISTS_REPLACE) during re-upload.
- Restrict upload access with the `upload media` permission (plus DropzoneJS permissions).
- Restrict configuration with the `administer media_upload configuration` permission.
- Configure which media bundles accept uploads at `/admin/config/media/upload`.
- Name each media entity after the uploaded file's base name.
- Warn per-file when size is exceeded while still importing the valid ones.
- Store files under the target field's configured scheme and directory (with token replacement).
- Speed up migrations of many binary assets into Drupal media.
- Provide a single upload page instead of adding media one form at a time.
- Report counts of uploaded vs skipped files after submission.
- Support image, document, video and audio buckets independently.
