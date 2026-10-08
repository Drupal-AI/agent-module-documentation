# API: validation service & upload wiring

## Service

- id `file_mime_validator`, class `Drupal\file_mime_validator\Service\FileMimeValidator`
  (`file_mime_validator.services.yml`).
- Constructor arguments: `@config.factory`, `@logger.factory`, `@string_translation`.
- The module also declares the logger channel service `logger.channel.file_mime_validator`
  (channel name `file_mime_validator`), used for the messages below.

## How it is invoked

`file_mime_validator.module` implements `hook_file_validate()`:

```php
function file_mime_validator_file_validate(File $file) {
  $errors = [];
  if (\Drupal::hasService('file_mime_validator')) {
    $errors = \Drupal::service('file_mime_validator')->checkRealMime($file);
  }
  return $errors;
}
```

A returned non-empty array of error strings marks the upload invalid; an empty array accepts it.
The hook receives the `File` entity while it is still the temporary upload (its URI is the raw
temp path, and `getMimeType()` is the filename/extension-derived guess set by core's upload
handler).

## Methods

### `checkRealMime(File $file): array`

Returns `[]` to accept, or a one-element array holding a `TranslatableMarkup` error to reject.
Steps:

1. `$mimeByFilename = $this->getFileType($file->getMimeType())` — category of the entity's stored
   (extension-derived) MIME type.
2. Content-based detection, run only when the file URI is under `/tmp/`:
   `$mimeByFileinfo = (substr($file->getFileUri(), 0, 5) == '/tmp/') ? (new FileinfoMimeTypeGuesser())->guessMimeType($file->getFileUri()) : 'NOTTMPDIR';`
   Detection uses Symfony `FileinfoMimeTypeGuesser` — PHP `finfo` / libmagic reading the actual
   file bytes, not the browser-supplied Content-Type.
3. If `$mimeByFilename === $this->getFileType($mimeByFileinfo)` (same category) → return `[]`.
4. Else if `$mimeByFilename == "no file type found"` → log an error and return `[]`.
5. Else if `$mimeByFileinfo != 'NOTTMPDIR'` (content detection actually ran) → log an error and
   return the rejection message
   `There was a problem with this file. The uploaded file must be of type @extension but the real seems to be @real_extension.`.
6. Otherwise → return `[]`.

The comparison is by category (one of `text` / `image` / `compression` / `audio` / `video`),
not by exact MIME string. Both the reject path and the "no file type found" path write to the
`file_mime_validator` logger channel.

### `getFileType(string $mime): string`

Returns `text`, `image`, `compression`, `audio`, or `video` when `$mime` is present in the
matching `file_mime_validator.settings` list, otherwise `"no file type found"`. It loads the five
comma-separated lists from config and checks `in_array($mime, ...)` against each; the last
matching category wins.
