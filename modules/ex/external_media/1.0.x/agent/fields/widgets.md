# Field widgets & the `external_media` form element

The module ships two Field API widgets and one form-element `#type`. Nothing new
is stored on the entity: picked files become ordinary managed **`file`** entities
referenced by the core `file`/`image` field, exactly like a normal upload.

## Widgets

| Widget id | Class | Field types | Extends |
|---|---|---|---|
| `external_media_file_widget` | `Plugin\Field\FieldWidget\ExternalMediaFile` | `file` | core `FileWidget` |
| `external_media_image_widget` | `Plugin\Field\FieldWidget\ExternalMediaImage` | `image` | `ExternalMediaFile` (this module) |

Select the widget on *Manage form display* for any File/Image field.

### Widget settings (Manage form display → gear icon)

| Setting | Widget | Default | Effect |
|---|---|---|---|
| `buttons_style` | file + image | `inline` | `inline` = list every enabled service beside the generic button; `dropdown` = one *Choose file…* split button revealing services. |
| `visible_widgets` | file + image | `[]` | Checkbox list of services to show on this field. Empty = all the user is permitted to use. **Overrides role permissions** for this field. |
| `preview_image_style` | image only | `thumbnail` | Image style used for the in-form preview. |

Plus the inherited core `FileWidget` `progress_indicator` setting.

## The `external_media` form element (`#type`)

`src/Element/ExternalMediaFile.php` (`#[FormElement('external_media')]`) extends core
`ManagedFile`. Reuse it in custom forms to add service buttons to any file input:

```php
$form['attachment'] = [
  '#type' => \Drupal::moduleHandler()->moduleExists('external_media') ? 'external_media' : 'managed_file',
  '#upload_location' => 'public://uploads',
  '#upload_validators' => ['FileExtension' => ['extensions' => 'pdf png jpg']],
];
```

It attaches libraries `file/drupal.file` and `external_media/external_media.core`,
themes itself with `external_media_element`, and builds the service buttons from the
enabled `ExternalMedia` plugins the current user may use.

## How a picked file is turned into a managed file

1. The vendor JS (per-provider `js/*.js`) opens that service's picker; on success it
   appends `"<plugin_id>::::<remote_ref>"` items (joined by `|`) into a hidden
   textfield rendered by `processManagedFile()` named `external_urls[<parents>]`.
   The generic *Choose file…* link just clicks the hidden native file input.
2. On submit, `ExternalMediaFile::valueCallback()` reads `external_urls`, splits each
   `plugin_id::::remote_ref`, and calls
   `plugin.manager.external_media` → `createInstance($plugin_id)->getFile($remote_ref, $destination)`.
3. `getFile()` returns either `source` (a URL to download) or `source_data` (raw bytes).
   - URL → `retrieveFile()` fetches it with `\Drupal::httpClient()->get($url)` and saves
     it (`file.repository:writeData`). Replaces the removed core `system_retrieve_file()`.
   - bytes → `writeFileData()` saves them directly.
4. `validateFile()` runs the field's upload validators (`file.validator`) on the saved
   file — external files never pass through `file_save_upload()`, so validators
   (extension, size, image, dimensions) are applied here; rejected files are deleted.
5. Valid file ids are merged into `fids`; `massageFormValues()` maps them to `target_id`.

Each bundled provider constrains what `getFile()` will fetch:

| Plugin id | `getFile()` behavior |
|---|---|
| `dropbox_chooser` | Returns `source` only if the URL starts with `https://dl.dropboxusercontent.com/1/view/`. |
| `box_picker` | `<url>@@@<name>`; fetches only if url starts with `https://dl.boxcloud.com/d/1/`. |
| `onedrive_picker` | `<url>@@@<name>`; fetches only if url starts with `https://graph.microsoft.com/v1.0/me/drive/`. |
| `google_drive` | `<id>@@@<name>@@@<token>`; GETs `https://www.googleapis.com/drive/v2/files/<id>?alt=media` with `Authorization: Bearer <token>`, returns the body as `source_data`. |

The image widget adds `FileIsImage`, optional `FileImageDimensions`, an `image/*`
accept attribute, alt/title fields, and a preview via `preview_image_style`.
