File Field Replace adds a per-field "Handle Existing Files" setting to any file/image field. When an editor uploads a file whose name already exists in the field's upload directory, the field can be configured to overwrite the existing file in place instead of Drupal's default behavior of renaming the new file (`logo_0.png`, `logo_1.png`, ...). Because the file keeps the same name and URI, existing links and image embeds keep working, and image-style caches are flushed on replace.

---

The module implements `hook_form_FORM_ID_alter()` on the field config edit form (`field_config_edit_form`) to inject a third-party-settings radios control, "Handle Existing Files", on every field whose item list is a `FileFieldItemList` (core File, Image, and any field built on them). The three options map directly to core's `FileSystemInterface` constants: "Rename the new file" (`EXISTS_RENAME`, the core default), "Replace the existing file" (`EXISTS_REPLACE`), and "Prevent the file from being uploaded" (`EXISTS_ERROR`). The chosen value is stored as `third_party_settings.file_field_replace.replace` on the field config. At widget render time `hook_field_widget_single_element_form_alter()` reads that setting; if it is anything other than Rename, it swaps the field's `managed_file` render element to the module's `managed_file_plus` element (a subclass of core `ManagedFile`) and points the element's value callback at the module. On submit, the custom value callback calls `file_managed_plus_file_save_upload()` — a copy of core `file_managed_file_save_upload()` that forwards the configured replace mode into `_file_save_upload_from_form()`, so the field's normal upload validators (allowed extensions, max size, image dimensions) still run. When the mode is Replace, the module also calls `image_path_flush()` on the file URI so cached image-style derivatives regenerate from the new bytes. The module ships no routes, permissions, services, config schema, or Drush commands; it only depends on core `file`. Note the in-form warning: Replace overwrites a same-named file even when a different file field references it, so use it where filenames are known to be unique per field/upload directory.

---

- Overwrite an image on an image field in place so every embed and image-style thumbnail updates without a new URL.
- Replace a PDF or document attached to a node without generating `document_0.pdf`, `document_1.pdf` duplicates.
- Keep a stable file URL for a downloadable asset that editors update periodically.
- Refresh a logo, banner, or hero image across the site by re-uploading the same filename.
- Prevent duplicate/renamed uploads from accumulating in a field's upload directory.
- Auto-flush image-style derivatives after replacing a source image (built-in `image_path_flush` on replace).
- Configure a field to reject an upload entirely when a same-named file already exists (Error mode) to enforce unique filenames.
- Set the per-field policy on a core Image field (media image source field, article image, etc.).
- Set the per-field policy on a core File field (attachments, brochures, spec sheets).
- Give one field Replace behavior while other file fields keep core's default Rename behavior.
- Maintain predictable, human-readable filenames for assets referenced from custom templates or CSS.
- Let editors correct a wrong upload by re-uploading the correct file under the same name.
- Keep third-party integrations that hardcode a file URL working after content updates.
- Update seasonal or campaign creative at a fixed URL by replacing the underlying file.
- Apply Replace on a base-field file definition on a custom entity type (only fields with third-party settings support get the option).
- Avoid orphaned renamed copies when re-uploading revised versions of the same document.
- Enforce "no silent renames" on a strict media library where filenames are curated.
- Replace a font/CSS/JS asset stored through a file field while keeping its reference intact.
- Update an OpenGraph/social share image at the same URL by overwriting the file.
- Provide editors a governed replace workflow through the normal entity edit form rather than a separate admin tool.
