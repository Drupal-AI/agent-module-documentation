<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File-upload AJAX endpoints (custom_paragraphs)

Source: `custom_paragraphs.routing.yml`, `src/Controller/RepeatableFileUploadController.php`
(extends `ControllerBase`; `create()` injects `file_system` and `file_url_generator`). Both routes
are `methods: [POST]`, `_permission: "access content"`. The front-end JS posts to them with
`FormData` and an `X-Requested-With: XMLHttpRequest` header (`uploadFilesToDrupal`,
`fetchFilesByFids`).

## Upload — `custom_paragraphs.repeatable_file_upload`

Path `/custom-paragraphs/repeatable-file-upload` → `RepeatableFileUploadController::upload()`.

Request (POST body):
- `files[]` — the uploaded file(s).
- `upload_location` — destination stream URI/directory; required (400 `"Upload location is missing."`
  if empty). Passed to `FileSystem::prepareDirectory(..., CREATE_DIRECTORY | MODIFY_PERMISSIONS)`.
- `multiple` — `"1"`/`"0"`; if not `"1"` and more than one file is posted → 400.
- `accept` — comma-separated extension/MIME rules; when non-empty each file is checked by
  `matchesAcceptRules()` (matches `.ext` / bare `ext` by extension, `type/*` by MIME prefix, or
  exact `type/subtype`).

Per file: destination is `upload_location . '/' . getClientOriginalName()`, de-duplicated with
`getDestinationFilename(..., EXISTS_RENAME)`; bytes read with `file_get_contents(getRealPath())` and
written with `FileSystem::saveData(..., EXISTS_RENAME)`; a `File` entity is created, set permanent
(`status => 1`), and saved.

Response JSON: `{"status":"success","files":[{"fid":int,"filename":string,"uri":string,"url":absolute}]}`
on success, or `{"status":"error","message":...}` with HTTP 400/500 on failure.

## Restore — `custom_paragraphs.repeatable_file_restore`

Path `/custom-paragraphs/repeatable-file-restore` → `RepeatableFileUploadController::restore()`.

Request (POST body): `fids[]` — managed file ids. Empty/non-array → 400 `"No file IDs provided."`.
Loads with `File::loadMultiple(array_map('intval', $fids))` and returns the same
`{fid,filename,uri,url}` shape for each loaded file. Used by the JS to re-hydrate a saved form's
file previews (`restorePrefilledFilesFromServer` → `fetchFilesByFids`).

## Operating it

The endpoints are consumed automatically by the `RepeatableFieldGroup` widget; a file field must
declare an `upload_location` (the JS refuses to upload without one). Uploaded files persist as
permanent managed `file` entities — reconcile/clean them with your own submit-handler logic (the
module does not attach usages or delete on form abandon).
