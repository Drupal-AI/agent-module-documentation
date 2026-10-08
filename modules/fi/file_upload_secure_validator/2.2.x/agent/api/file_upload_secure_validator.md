<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How validation works & the validator service

## Automatic validation (no configuration needed)

The module registers an event subscriber (`FileValidationSubscriber`) on core's
`\Drupal\file\Validation\FileValidationEvent`. Any file that passes through Drupal's file
validation pipeline — file fields, media uploads, or programmatic `File` validation — is
inspected automatically. On a mismatch the subscriber adds a `ConstraintViolation` to the
event, which rejects the upload. There is nothing to enable per field.

## The algorithm (`FileUploadSecureValidator::validate()`)

Service id: `file_upload_secure_validator`
Class: `Drupal\file_upload_secure_validator\Service\FileUploadSecureValidator`
Method: `validate(\Drupal\file\Entity\File $file): array` — returns an array of
`TranslatableMarkup` error messages (empty array = file OK).

Steps:
1. `$mimeByFilename = $file->getMimeType();` — MIME type derived from the file's extension.
2. `$mimeByFileinfo = (new \Symfony\Component\Mime\FileinfoMimeTypeGuesser())->guessMimeType($file->getFileUri());`
   — MIME type sniffed from the actual bytes. A missing file throws
   `InvalidArgumentException`, which is caught and returned as an error message.
3. If the two MIME types are identical → return `[]` (pass, early exit).
4. Otherwise load `mime_types_equivalence_groups` from `file_upload_secure_validator.settings`
   and pass (return `[]`) if BOTH MIME types appear in the same group
   (`array_diff([$mimeByFilename, $mimeByFileinfo], $group)` is empty).
5. Otherwise log the disagreement to the `file_upload_secure_validator` logger channel and
   return one error: *"There was a problem with this file. The uploaded file is of type
   @extension but the real content seems to be @real_extension"*.

Note: `FileValidationSubscriber::onFileValidate()` only adds a violation when `validate()`
returns exactly one message (`count(...) == 1`).

## Calling it from custom code

```php
$errors = \Drupal::service('file_upload_secure_validator')->validate($file);
if ($errors) {
  // $errors[0] is a TranslatableMarkup describing the mismatch.
}
```

Guard for the extension: on servers without `fileinfo` the service is removed by
`FileUploadSecureValidatorServiceProvider`, so `\Drupal::hasService('file_upload_secure_validator')`
is `FALSE` — check before calling in code that must run on such hosts.

## Constructor dependencies

`__construct(LoggerChannelFactoryInterface $logger_factory, TranslationInterface $translator, ConfigFactoryInterface $config_factory)`
— wired in `file_upload_secure_validator.services.yml` as
`['@logger.factory', '@string_translation', '@config.factory']`.
