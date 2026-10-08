<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Upload - agent index

Bulk DropzoneJS upload -> media entities, one bundle per file type. Depends on `dropzonejs` + `media`.

Routes/perms:
- `/media/upload` (`UploadMediaForm`, perm `upload media`) - the bulk upload form.
- `/admin/config/media/upload` (`MediaUploadConfigurationForm`, perm `administer media_upload configuration`).

Flow (`src/Form/UploadMediaForm.php::submitForm`): parse ext via `FILENAME_REGEX` -> `getBundleForFile()`
(extension must be in the configured per-bundle allow-list) -> size checks -> `FileRepository::writeData()`
into the field's scheme/dir -> create+save media.

Security: route is permission-gated (not anon); extensions validated against the media field's allowed list.
Caveat: no `file_munge_filename()` on final write, so relies on the field's allowed-extensions being safe
(no php/html/svg). Version dir `3.0.x`.
