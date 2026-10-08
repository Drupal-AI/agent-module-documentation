<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Select & configure the Plupload widgets

No settings form — enable by choosing the widget on a core **File** or **Image** field's
*Manage form display*.

## Widgets

| Widget id | Field type | Settings |
|---|---|---|
| `plupload_file_widget` | `file` | none |
| `plupload_image_widget` | `image` | `preview_image_style` (image style for the upload preview) |

Set on `core.entity_form_display.<entity>.<bundle>.<mode>`:

```php
$fd = \Drupal::service('entity_display.repository')->getFormDisplay('node', 'article', 'default');

// File field:
$fd->setComponent('field_document', ['type' => 'plupload_file_widget']);

// Image field with a preview style:
$fd->setComponent('field_image', [
  'type' => 'plupload_image_widget',
  'settings' => ['preview_image_style' => 'thumbnail'],
]);

$fd->save();
```

Read back: `drush cget core.entity_form_display.node.article.default content.field_image`.

## Behavior

The widget's `process()` builds a `#type => plupload` element:

- `#autoupload => TRUE`, `#autosubmit => TRUE` — uploads start on selection and the form
  auto-submits when complete.
- `#upload_validators` — the field's normal validators (extensions, size).
- `#plupload_settings`:
  - `runtimes: html5,flash,silverlight,html4`
  - `chunk_size` = `PluploadWidgetTrait::getChunkSize()` (from PHP `upload_max_filesize` /
    `post_max_size`, minus a small margin) — enables **chunked** uploads of large files.
  - `max_file_size` = `getMaxFileSize()`.
  - `max_file_count: 1`.
- JS callbacks `FilesAdded` / `UploadComplete` from `assets/js/plupload_widget.js` (library
  `plupload_widget/plupload_widget`, plus `plupload/plupload`).

## Notes

- Only the **widget** changes; the field storage and display formatter are untouched.
- Because chunk/size limits come from PHP ini, raising `upload_max_filesize` / `post_max_size`
  raises the effective per-chunk and max sizes.
