<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The conversion route and access rules

## Route

```
file_to_media.add_form
  path: /file/to-media/{file}/{media_type}
  controller: \Drupal\file_to_media\Controller\FileToMedia::fileToMediaForm
  requirement: _permission: 'access files overview'
  parameters: file -> entity:file, media_type -> entity:media_type
  options: _admin_route: TRUE
```

`FileToMedia::fileToMediaForm(FileInterface $file, MediaTypeInterface $media_type)`:

1. Checks create access to the media type (`AccessDeniedHttpException` if denied).
2. Checks the file is publicly downloadable (`isPublicDownloadable()` = `$file->access(
   'download', User::load(0))`) — throws Access Denied for a private file.
3. Gets the media type's source field definition; if the field is not a file field or its
   `file_extensions` do not include the file's extension → `NotFoundHttpException`.
4. Creates a media entity `['bundle' => <type>, 'name' => <filename>, <source_field> =>
   <fid>]` and returns its entity add-form (`entity.form_builder`).

The editor then completes any remaining fields and saves — a normal media add-form,
pre-filled with the file.

## Compatibility helper (`FileToMediaAccessTrait`)

| Method | Rule |
|---|---|
| `hasCreateAccessToMediaType($type)` | media access handler `createAccess($type)`. |
| `sourceFieldIsCompatible($fieldDefinition, $extension)` | source item class is (a subclass of) `FileItem` **and** the extension is in the field's `file_extensions` setting. |
| `isPublicDownloadable($file)` | `$file->access('download', anonymous)` — true only for public files. |

## Views field (`ToMedia`)

The `@ViewsField("file_to_media")` handler reuses the same trait to build a `#type =>
dropbutton` with one link per compatible media type, pointing at `file_to_media.add_form`.
It additionally hides the button when `file.usage` already reports a `media` usage for the
file (so a file is not converted twice).

## Programmatic conversion

There is no dedicated service/API. To convert in code, mirror the controller: create a media
entity with the source field set to the file id and save it, e.g.

```php
$media = \Drupal::entityTypeManager()->getStorage('media')->create([
  'bundle' => $media_type_id,
  'name' => $file->getFilename(),
  $source_field_name => $file->id(),
]);
$media->save();
```

or link the user to `Url::fromRoute('file_to_media.add_form', ['file' => $fid, 'media_type'
=> $type_id])` to use the built-in form.
