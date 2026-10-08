# file_field_replace — configuring per-field replace behavior

There is **no settings form and no `configure` route** (`data.json.configure` is `null`). The module
ships no config objects of its own — it stores a single value in the **third-party settings of each
file/image field's `field_config`** entity.

## Where the setting appears

On the field settings edit form of any file-based field — path
`/admin/structure/types/manage/{bundle}/fields/{field_id}` (and the equivalent for media types,
taxonomy, users, etc.). Added by `hook_form_field_config_edit_form_alter()` to any field whose item
list is a `FileFieldItemList` (core **File** and **Image** fields, and fields built on them) that
implements `ThirdPartySettingsInterface`.

The control is a `radios` element titled **"Handle Existing Files"** with three options, mapping 1:1
to core `\Drupal\Core\File\FileSystemInterface` constants:

- **Rename the new file** — `EXISTS_RENAME` (`0`), the core default; appends `_0`, `_1`, ... to keep
  the new upload's name unique.
- **Replace the existing file** — `EXISTS_REPLACE` (`1`); overwrites the same-named file in place,
  keeping filename and URI. Also flushes image-style derivatives via `image_path_flush()`.
- **Prevent the file from being uploaded** — `EXISTS_ERROR` (`2`); blocks the upload when a
  same-named file already exists.

Default when unset: **Rename** (`EXISTS_RENAME`, `0`).

## What gets stored

On the `field_config` entity:

```yaml
third_party_settings:
  file_field_replace:
    replace: 1   # FileSystemInterface: RENAME=0, REPLACE=1, ERROR=2
```

At widget render, `hook_field_widget_single_element_form_alter()` reads this; if `replace` is
anything other than `EXISTS_RENAME` it swaps the field's `managed_file` render element to
`managed_file_plus` and installs `file_field_replace_field_widget_value_callback`. So the behavior
takes effect automatically on every entity form that uses that field — no per-form work needed.

## Setting it programmatically

```php
$field = \Drupal\field\Entity\FieldConfig::loadByName('node', 'article', 'field_attachment');
$field->setThirdPartySetting('file_field_replace', 'replace', \Drupal\Core\File\FileSystemInterface::EXISTS_REPLACE);
$field->save();
```

## Who can change it

There is **no module-specific permission**. Changing the setting requires core field-administration
access for the entity type (e.g. `administer node fields`), because it lives on the field settings
form. Uploading/replacing at content-edit time uses the field's normal entity/field edit access;
the module adds no access logic of its own.

## Notes / caveats

- Upload validators are preserved: saves go through `_file_save_upload_from_form()`, so allowed
  extensions, max size, and image dimension limits still apply to the replacement upload.
- Warning shown in the UI: **Replace overwrites a same-named file even if a different file field
  references it.** Filenames are only unique per upload directory, so use Replace where that is safe.
- The option only appears on fields whose definition supports third-party settings; a base-field
  file definition on a custom entity type may not expose it.
