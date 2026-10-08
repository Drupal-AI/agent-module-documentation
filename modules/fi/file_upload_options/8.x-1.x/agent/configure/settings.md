<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form & config

Config object `file_upload_options.settings` (no schema file shipped). UI at
`/admin/config/media/file-upload-options` (route `file_upload_options.settings`, form
`\Drupal\file_upload_options\Form\SettingsForm`, permission `administer file upload options`).

## Config structure

```
file_upload_options.settings:
  upload_option:
    <entity_type>.<bundle>.<field_name>: <int>   # e.g. node.article.field_image: 1
  custom_fields:
    <machine_name>: <int>                         # e.g. my_custom_file: 0
```

`<int>` is one of the core `FileSystemInterface` file-exists values:

| Value | UI label | Effect on a same-named upload |
|---|---|---|
| `-1` | Current behaviour | Leave core default intact (effectively rename). |
| `0` | Rename the new file | `EXISTS_RENAME` (core default): `x.jpg` → `x_0.jpg`. |
| `1` | Replace the existing file | `EXISTS_REPLACE`: overwrites the existing file in place. |
| `2` | Prevent the file from being uploaded | `EXISTS_ERROR`: upload fails. |
| `99` | Remove this setting | Custom-fields select only; `submitForm()` clears the key. |

## Form behaviour (`SettingsForm`)

- `buildForm()` calls `FileUploadService::getSupportedFields()` to enumerate **every file and image
  field on the site**, grouped by entity type into a `details` element per entity type. Each field
  becomes a `select` named `upload_option__<entity_type>_<bundle>_<field>` (dots replaced with
  underscores) defaulting to the stored value or `EXISTS_RENAME`.
- A **Custom fields** `details` section lists any `custom_fields` entries (each with the extra
  `99 = Remove this setting` option) and an **Add custom field** textfield to register a field by
  machine name (`maxlength` 128). New custom fields default to `EXISTS_RENAME` (0).
- `submitForm()` writes `upload_option.<field_id>` for each supported field and
  `custom_fields.<name>` for each custom field (clearing entries set to `99`), then saves.
- The select `#description` warns: *"Note that the Replace option will replace a file with the same
  name even if that file is being used/referenced by another file field. Use at your own risk."*

## How custom (code-defined) fields get registered

When a form containing a `managed_file`/`image` element is rendered outside an entity context,
`file_upload_options_process_custom_fields()` (in the `.module`) finds those elements via
`file_upload_options_get_file_fields()` and writes `custom_fields.<name> = 0` if not already
present. They then appear on the settings form for configuration.

## Read current config (read-only)

```
drush config:get file_upload_options.settings
```

## Notes

- No default config is shipped; the object is created on first save / first custom-field discovery.
- There is no per-field UI on the field's own form-display; all configuration lives on this one
  central form.
