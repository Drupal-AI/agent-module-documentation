<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
File Upload Options lets you choose, per file/image field, what happens when an uploaded file has the same name as an existing file: rename the new one, replace (overwrite) the existing one, or reject the upload.

---

The module solves exactly one problem: **filename collisions on upload**. Core always renames a same-named file (`photo.jpg` becomes `photo_0.jpg`); File Upload Options makes that per-field configurable to instead *replace* the existing file or *reject* the upload. It does **not** touch allowed extensions, file size, upload destination, per-role limits, or the widget UI — only the file-exists behaviour. Every file and image field on the site is discovered automatically and listed on one form at **Admin -> Config -> Media -> File Upload Options** (`/admin/config/media/file-upload-options`, permission `administer file upload options`, `restrict access: TRUE`), grouped by entity type. Each field gets a select with four options that map to core's `FileSystemInterface` constants: **Current behaviour** (`-1`, leave core's default rename intact), **Rename the new file** (`EXISTS_RENAME` = 0, core default), **Replace the existing file** (`EXISTS_REPLACE` = 1), and **Prevent the file from being uploaded** (`EXISTS_ERROR` = 2). Config is stored as `upload_option.<entity_type>.<bundle>.<field_name>`. The mechanism is deliberately non-invasive: it overrides the `managed_file` element `#value_callback` (via `hook_element_info_alter` plus a per-widget `hook_form_alter`) so uploads pass through the module's own save routine, which reads the configured option and hands it to core's `_file_save_upload_from_form()` — no widget or field type is replaced. Fields defined in code or on non-entity forms are auto-registered under **Custom fields** (keyed by machine name, `custom_fields.<name>`) and can then be configured the same way; a "Remove this setting" option clears a custom-field entry. Two integrations extend the same setting beyond the standard widget: a `hook_rest_resource_alter` swaps core's `file:upload` REST resource for `FileUploadOptionsResource`, which honours the option for REST uploads and, on Replace, re-uses the existing file entity that already has the matching URI rather than creating a new one; and `hook_filefield_paths_process_file` feeds the same replace value into filefield_paths. The module installs at weight `-10` so it runs before other file-handling modules. The Replace option's own settings-form note is worth heeding — it overwrites a same-named file even when another field references it, so it is a deliberate, admin-only choice.

---

- Overwrite (replace) a file instead of getting a renamed `_0` copy on re-upload.
- Keep a stable filename/URL across repeated uploads to the same field.
- Reject a duplicate-named upload instead of silently renaming it.
- Preserve core's default rename behaviour explicitly on a per-field basis.
- Configure duplicate handling for a specific content type's image field.
- Apply Replace to a "logo" or "hero image" field so the URL never changes.
- Set duplicate behaviour on a media entity's source file field.
- Configure a file field rendered inside an inline entity form.
- Control duplicate handling for a file field defined in a custom module (via Custom fields).
- Set the file-exists option for a file field on a non-entity custom form.
- Make REST `file:upload` requests replace an existing same-URI file.
- Re-use the existing file entity on a REST upload rather than creating a duplicate entity.
- Feed the replace behaviour into filefield_paths' path processing.
- Standardise duplicate-filename handling across many fields from one settings form.
- Audit which fields are set to Replace before a content migration.
- Prevent accidental filename churn on a document-library field.
- Enforce "no duplicate uploads" (Error) on a field that must stay unique.
- Roll a field back to core behaviour by setting it to Current behaviour.
- Group and review all file/image fields' upload options by entity type.
- Remove a stale custom-field setting for a field that no longer exists.
- Ensure a field's uploaded filename is deterministic for downstream integrations.
