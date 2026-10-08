<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Temporary Validator — mechanism, enabling, and behaviour

Source: `file_temporary_validator.module`, `src/Service/FileTemporaryValidator.php`,
`src/Plugin/Validation/Constraint/DuplicateUploadValidatorConstraint{,Validator}.php`,
`config/schema/file_temporary_validator.schema.yml`, `file_temporary_validator.services.yml`.

## Install / enable

`drush en file_temporary_validator`. Core `^10 || ^11`; requires core **`file`**. There is **no
settings form and no permission** — the module does nothing until you enable it on an individual
file field.

## Enabling it on a field (the only configuration)

`hook_form_field_config_edit_form_alter()` runs on any field-config edit form whose field class is
(an instance of) `Drupal\file\Plugin\Field\FieldType\FileFieldItemList` — i.e. core file/image
fields. It adds a single checkbox:

- Title *"Enable File Temporary Validator?"*, stored as the third-party setting
  `enabled` under the `file_temporary_validator` namespace (`#parents =>
  ['third_party_settings', 'file_temporary_validator']`, `#tree => TRUE`).

So the config lives on the **field config entity** as a third-party setting, not in a dedicated
config object. Schema is `field.field.*.*.*.third_party_file_temporary_validator` with one boolean
key `enabled` (`config/schema/file_temporary_validator.schema.yml`). To enable in code/config:
set `third_party_settings.file_temporary_validator.enabled: true` on the field.

Path in the UI: *Manage fields* → edit a file field → tick the box → save.

## Attaching the validator to the widget

`hook_field_widget_single_element_form_alter()` fires per widget element. It acts only when
`$element['#type']` is `managed_file` or `managed_file_plus`, and only if the field's
`getThirdPartySettings('file_temporary_validator')['enabled']` is truthy. It then **prepends** an
entry to `$element['#upload_validators']`:

- Core **`< 10.2.0`**: `['file_temporary_validator_validate' => []]` — the legacy procedural
  callback style.
- Core **`>= 10.2.0`**: `['duplicate_upload_validator' => []]` — the constraint-plugin style that
  core's file-validation now expects.

Both resolve to the same duplicate check; the version branch only matches the API core exposes.

## The duplicate query (the heart of it)

`FileTemporaryValidator::getFileDuplications(FileInterface $file): ?FileInterface`:

```
$query = file_storage->getQuery()
  ->accessCheck(FALSE)
  ->condition('status', FileInterface::STATUS_PERMANENT, '<>')   // temporary files only
  ->condition('filename', $file->getFilename());                 // same name
if ($file->id()) { $query->condition('fid', $file->id(), '<>'); } // not itself
$fids = $query->range(0, 1)->execute();                          // first match
return $fids ? file_storage->load(reset($fids)) : NULL;
```

Key points, all from source:

- **Filename match only** — no hashing, no content/size comparison. Cost is one indexed entity
  query regardless of file size.
- `status <> STATUS_PERMANENT` means it only flags **leftover temporary files** (the ones core
  would suffix), never a properly attached permanent file.
- `accessCheck(FALSE)` is used so the lookup is not filtered by file access — it is a
  name-collision check, not a content read; only the filename and location are ever surfaced.

`checkTemporaryFileViolation()` is a thin wrapper returning `[buildDuplicateViolation(...)]` when a
duplicate is found; the legacy procedural callback `file_temporary_validator_validate()` calls it
via the `file_temporary_validator` service.

## The error message and its access-gated link

`FileTemporaryValidator::buildDuplicateViolation(FileInterface $current, FileInterface $duplicate)`
returns a `TranslatableMarkup`:

- Placeholders `@file_location` = the uploaded file's URI, `@file_name` = the duplicate's label
  (both `@`-placeholders, auto-escaped by the translation system).
- If the current user has permission **`access files overview`**, it adds a `:duplicate_url`
  placeholder built with `Url::fromRoute('view.files.page_1', ['filename' => $duplicate->getFilename()], …)`
  (opens in a new tab) so the editor can jump to the Files admin view filtered to that filename and
  delete the stuck temp file. Without that permission the message is the same text minus the link.

The constraint validator
(`DuplicateUploadValidatorConstraintValidator::validate()`) unpacks the same `TranslatableMarkup`
into `context->buildViolation($message, $parameters)->addViolation()` so core file validation reports
it as a normal upload error and the file is rejected.

## Operating notes

- The module **never deletes files** — it detects and links; deletion is the editor's manual action
  in the Files view (needs `access files overview` to even see the link).
- If uploads are unexpectedly blocked, look for orphaned temporary files (same filename, status not
  permanent) that cron has not yet cleared; deleting them clears the collision.
- No cron, queue, or background behaviour of its own. Turn it off per field by unticking the box.
