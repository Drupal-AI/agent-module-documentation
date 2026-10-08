<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Upload Options (file_upload_options) — agent index

Configures, **per file/image field**, what happens when an uploaded file has the **same name as an
existing file**: rename the new file, replace (overwrite) the existing one, reject the upload, or
leave core's behaviour. Package `Media`. Version **8.x-1.x** (installed 8.x-1.1).
Core `^8 || ^9 || ^10 || ^11`. No hard dependencies.

**Scope — read this first.** This module changes **only** the file-exists (duplicate-filename)
behaviour. It does **NOT** alter allowed extensions, max size, upload destination, per-role limits,
validators, or the widget UI. (An earlier version of this doc wrongly described those; they are not
features of this module.)

## The four options

Stored in config object `file_upload_options.settings`, keyed
`upload_option.<entity_type>.<bundle>.<field_name>` (and `custom_fields.<machine_name>` for
code/non-entity fields). Values are core `\Drupal\Core\File\FileSystemInterface` constants:

| Value | Label in UI | Meaning |
|---|---|---|
| `-1` | Current behaviour | Leave core's default (rename) untouched. |
| `0` | Rename the new file | `EXISTS_RENAME` — core default; `x.jpg` becomes `x_0.jpg`. |
| `1` | Replace the existing file | `EXISTS_REPLACE` — overwrites the same-named file in place. |
| `2` | Prevent the file from being uploaded | `EXISTS_ERROR` — upload fails with an error. |
| `99` | Remove this setting | Custom-fields only; clears the config entry. |

## How it works (mechanism)

- `hook_element_info_alter` (`file_upload_options.module`) overrides the `managed_file` element's
  `#value_callback` -> `FileUploadService::valueCallback`.
- `hook_form_alter` + `hook_inline_entity_form_entity_form_alter` walk the form and, for each
  **supported** file/image field, set a per-widget-delta `#value_callback` ->
  `FileUploadService::value`. "Supported" = every file/image field discovered by
  `FileUploadService::getSupportedFields()` (via `entity_field.manager` field maps).
- Those callbacks (copies of core `FileWidget::value` / `ManagedFile::valueCallback`) route uploads
  through `file_upload_options_file_managed_file_save_upload()`, which reads the configured option
  for the field id and calls core `_file_save_upload_from_form($element, $form_state, NULL, $replaceOption)`.
- Non-entity / code-defined fields: auto-registered into `custom_fields` (default `0`) when their
  form is first viewed; configurable under "Custom fields".
- **REST**: `hook_rest_resource_alter` swaps core `file:upload` for
  `FileUploadOptionsResource` (`Plugin/rest/resource/`). See [rest/upload.md](rest/upload.md).
- **filefield_paths**: `hook_filefield_paths_process_file` sets `$settings['replace']` from the
  same config.
- Install weight is set to `-10` (`file_upload_options.install`) so it runs before filefield_paths etc.

## Files / API

- Settings form + config keys → [configure/settings.md](configure/settings.md)
- REST file:upload override → [rest/upload.md](rest/upload.md)
- Service: `file_upload_options.file_upload_service`
  (`src/Services/FileUploadService.php`) — `getSupportedFields()`, `getConfig()`, static
  `value()` / `valueCallback()`.
- Permission: `administer file upload options` (`restrict access: TRUE`).
- Route/UI: `file_upload_options.settings` → `/admin/config/media/file-upload-options`.
- No config schema shipped (no `config/schema/`), no submodules, no Drush commands.

## Gotcha

The **Replace** option overwrites a same-named file **in place**, even when another field/entity
references that file — the settings form itself warns "Use at your own risk." It is an admin-only,
per-field choice (an uploader cannot pick it), and filenames are still munged by core, so the
overwrite is confined to the field's configured directory and the core-sanitised filename.
