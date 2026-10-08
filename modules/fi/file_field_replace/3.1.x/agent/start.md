# file_field_replace — agent start

Adds a per-field **"Handle Existing Files"** setting to file/image fields so an upload whose
filename already exists can **overwrite the existing file in place** (same name, same URI) instead
of core's default rename. Purely a field-config setting + widget swap — **no routes, no
permissions, no services, no config schema, no Drush, no submodules**. Depends only on core `file`.

How it works (from source, `file_field_replace.module` + `src/Element/ManagedFilePlus.php`):
- `hook_form_field_config_edit_form_alter` adds a `radios` control on any `FileFieldItemList` field,
  stored as `third_party_settings.file_field_replace.replace`. Options are core
  `FileSystemInterface` constants: `EXISTS_RENAME` (default), `EXISTS_REPLACE`, `EXISTS_ERROR`.
- `hook_field_widget_single_element_form_alter`: when `replace !== EXISTS_RENAME`, swaps the field's
  `managed_file` element to the module's `managed_file_plus` element (subclass of core `ManagedFile`)
  and its own value callback.
- Uploads are saved via `file_managed_plus_file_save_upload()` — a copy of core
  `file_managed_file_save_upload()` that forwards the replace mode into `_file_save_upload_from_form()`,
  so the field's normal validators (extensions, size, image dimensions) still run. On Replace it also
  calls `image_path_flush()` to regenerate image-style derivatives.

- Where the setting lives, how to enable it per field, and stored config → [configure/file_field_replace.md](configure/file_field_replace.md)

Caveat (from the module's own UI text): Replace overwrites a same-named file even if another file
field references it — use where per-field upload-directory filenames are unique.
