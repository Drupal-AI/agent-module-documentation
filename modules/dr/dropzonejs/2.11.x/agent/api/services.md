# Services & events

Two services (`dropzonejs.services.yml`) plus an events namespace. No plugin type is
defined by this module; the `dropzonejs` render element is the main form surface.

## `dropzonejs.upload_handler` — `UploadHandlerInterface`

Streams a raw request upload to the temporary scheme. Used by the
`dropzonejs.upload` controller; rarely called directly.

- `getFilename(UploadedFile $file): string` — sanitizes name, appends `.txt` (security; the
  real extension is validated later in the element `valueCallback`).
- `handleUpload(UploadedFile $file): string` — writes the stream to
  `{tmp_upload_scheme}://…`, returns the temp URI. Throws `UploadException` on error.

## `dropzonejs.upload_save` — `DropzoneJsUploadSaveInterface`

Turns a temporary upload into a Drupal `file` entity. This is what most integrations call
after reading the element's `uploaded_files` value.

```php
$save = \Drupal::service('dropzonejs.upload_save');
$file = $save->createFile(
  $tmp['path'],            // temporary:// URI from the element value
  'public://uploads',      // destination (stream wrapper URI)
  'png jpg pdf',           // space-separated valid extensions
  \Drupal::currentUser(),  // owner (AccountProxyInterface)
  ['file_validate_size' => [8388608, 0]] // optional extra validators
);
// $file is a temporary, UNSAVED file entity (or FALSE). Caller saves + setPermanent().
$file->setPermanent();
$file->save();
```

`validateFile($file, $extensions, $additional_validators)` returns an array of error
messages (FileExtension + FileNameLength are always applied).

## Events — `Drupal\dropzonejs\Events\Events`

Dispatched by the Media Library integration / eb_widget media flows. Subscribe to alter the
media entity before it is saved.

- `Events::MEDIA_ENTITY_CREATE` (`dropzonejs.media_entity_create`) — fired when a media
  entity is created, before save.
- `Events::MEDIA_ENTITY_PRECREATE` (`dropzonejs.media_entity_precreate`) — before the entity
  is shown in the inline-entity-form widget.

Both carry a `DropzoneMediaEntityCreateEvent` with getters/setters for the media entity,
file, form, form state and Dropzone element.
