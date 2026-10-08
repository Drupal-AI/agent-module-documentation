<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Textarea File Drag'n'Drop — configuration

**Settings form:** `/admin/config/media/textarea-file-drag`
(`TextareaFileDragSettingsForm`, permission `administer site configuration`).

Config object `textarea_file_drag.settings`:
- `allowed_extensions` — space-separated extension allowlist. Default:
  `jpg jpeg png gif webp svg zip rar 7z xls xlsx doc docx pdf txt`.
  Matched case-sensitively against `UploadedFile::getClientOriginalExtension()`.
- `upload_path` — destination stream wrapper path, default `public://inline`.

**Permission:** grant `dragndrop files to textarea` only to trusted roles — it
both enables the drop zone (`hook_element_info_alter`) and authorises the
`/ajax/textarea-file-drag` upload endpoint.

**Notes:**
- Files are moved straight into the public filesystem; no managed `file` entity
  is created, so they are not tracked/garbage-collected by Drupal.
