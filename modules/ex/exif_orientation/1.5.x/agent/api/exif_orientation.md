# Hooks implemented & the reusable validator

The module is a single procedural `.module` file. It defines **no services** and **no plugin
types**; it works by implementing two core hooks and exposing one reusable validator function.

## Hooks it implements

- `hook_file_presave(EntityInterface $entity)` — calls `_exif_orientation_rotate()` on the
  saved file. This is what makes rotation automatic for every file save/upload.
- `hook_field_widget_single_element_form_alter(&$element, FormStateInterface $form_state, $context)`
  — when a file/image widget already carries the `file_validate_image_resolution` upload
  validator, it **prepends** `exif_orientation_validate_image_rotation` so orientation is
  fixed *before* any resize can strip the EXIF data.

## Reusable function

```php
/**
 * Upload validator: rotates the file per its EXIF Orientation, returns [] (no errors).
 *
 * @param \Drupal\file\FileInterface $file
 * @return array  Always an empty array.
 */
exif_orientation_validate_image_rotation(FileInterface $file);
```

Use it as a file-field `#upload_validators` entry on a custom widget:

```php
$element['#upload_validators']['exif_orientation_validate_image_rotation'] = [];
```

## Rotating a file manually

There is no public service to call, but any save of an image file entity triggers the
rotation via `hook_file_presave()`:

```php
$file = \Drupal\file\Entity\File::load($fid);
$file->save(); // hook_file_presave() → _exif_orientation_rotate() runs.
```

`_exif_orientation_rotate()` itself is a private helper (leading underscore) and is not part
of the public API. Internally it uses the `file_system`, `stream_wrapper_manager` and
`image.factory` core services and PHP's `exif_read_data()`.
