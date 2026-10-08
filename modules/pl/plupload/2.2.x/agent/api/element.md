# The `plupload` Form API element

Defined by `\Drupal\plupload\Element\PlUploadFile` (`@FormElement("plupload")`). Use it like
any render element in a form array.

## Minimal usage

```php
$form['upload'] = [
  '#type' => 'plupload',
  '#title' => $this->t('Upload files'),
  '#upload_validators' => [
    'FileExtension' => ['extensions' => 'zip'],
  ],
];
```

If you omit `#upload_validators`, defaults are added in the process callback:
`FileExtension => 'jpg jpeg gif png txt doc xls pdf ppt pps odt ods odp'`.

## Supported properties

| Property | Purpose |
|---|---|
| `#upload_validators` | Array passed to core `file.validator`. Key `FileExtension` → `['extensions' => 'zip png ...']`; also supports `FileSizeLimit`, etc. Used for **server-side** validation. |
| `#plupload_settings` | Raw settings handed to the Plupload JS runtime (e.g. `url`, `filters`, `chunk_size`, `max_file_size`, `init`). Sensible defaults (upload URL + extension filter) are filled in automatically. |
| `#autoupload` | `TRUE` → start uploading as soon as files are added (binds `Drupal.plupload.filesAddedCallback`). |
| `#autosubmit` | With `#autoupload`, submit the form when upload completes (binds `Drupal.plupload.uploadCompleteCallback`). |
| `#submit_element` | CSS selector of the button to click when uploads finish. |
| `#event_callbacks` | Map of Plupload event → JS callback name, merged into `settings.init`. |
| `#description` | Rendered through `file_upload_help` with the validators, so the "Allowed types / max size" hint shows automatically. |

## The submitted value (what you get back)

The element's value callback returns an **array of file descriptors**, one per uploaded file.
`$form_state->getValue('upload')` (or `getValue(['upload'])`) yields:

```php
[
  0 => [
    'name'    => 'archive.zip',              // sanitized + transliterated final filename
    'tmpname' => 'abc123.tmp',               // temp file name written by the chunk handler
    'status'  => 'done',                     // 'done' on success
    'tmppath' => 'temporary://abc123.tmp',   // full URI of the finished temp file
  ],
  // ...
]
```

- `status` is `'done'` when the browser finished sending all chunks. Validate it:
  ```php
  foreach ($form_state->getValue('upload') as $f) {
    if ($f['status'] !== 'done') {
      $form_state->setErrorByName('upload', $this->t('Upload of %n failed.', ['%n' => $f['name']]));
    }
  }
  ```
- The element does **not** create `file` entities and does not call `file_save_upload()`.
  You must move/save the files yourself in the submit handler.

## Saving the uploaded files (typical submit handler)

```php
$destination = $this->config('system.file')->get('default_scheme') . '://my-dir';
\Drupal::service('file_system')->prepareDirectory(
  $destination, FileSystemInterface::CREATE_DIRECTORY | FileSystemInterface::MODIFY_PERMISSIONS
);
foreach ($form_state->getValue('upload') as $f) {
  $uri = \Drupal::service('stream_wrapper_manager')
    ->normalizeUri($destination . '/' . $f['name']);
  // Move the finished temp file to its destination.
  \Drupal::service('file_system')->move($f['tmppath'], $uri, FileSystemInterface::EXISTS_RENAME);
  // Optionally wrap it in a managed File entity:
  // $file = File::create(['uri' => $uri]); $file->save();
}
```

See the working example in the `plupload_test` submodule
(`\Drupal\plupload_test\PluploadTestForm`), route `/plupload-test`.

## Security notes (built into the element)

- Filenames are sanitized via a `FileUploadSanitizeNameEvent` and directory components are
  stripped (`basename`), preventing path traversal into other stream locations.
- Files matching `\.(php|pl|py|cgi|asp|js)` are renamed with a trailing `.txt` unless
  `system.file:allow_insecure_uploads` is TRUE — the same protection core applies.
- The upload route requires a CSRF token (`_csrf_token: 'TRUE'`) and permission
  `access content`.
