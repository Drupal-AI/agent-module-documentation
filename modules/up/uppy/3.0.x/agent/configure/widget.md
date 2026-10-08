<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the Uppy widget

## Enable on a field
1. Enable the module: `drush en uppy -y`.
2. Go to the content type's **Manage form display** (e.g. `/admin/structure/types/manage/article/form-display`).
3. For a `file` or `image` field, set the widget to **Uppy file uploader** (`uppy_widget`).
4. Open the widget's gear to set:
   - **Upload immediately?** (`auto_proceed`) — start upload without a button press.
   - **File sources** (`file_sources`) — `dashboard` (default) or `drag-drop`.
   - **Uploader** (`uploader`) — `tus` (only option; recommended).
   - **Chunk size** (`chunk_size`) — bytes per chunk (default `2000000` = 2MB).

## How it renders (UppyWidget::formElement)
- Extends core `FileWidget`, so `#upload_validators` still include `file_validate_size` (from the field's `max_filesize`) and `file_validate_extensions` (the field's allowed extensions).
- Builds a per-instance id `{entityType}-{fieldName}-{delta}` and passes settings to JS via `drupalSettings['uppy'][id]`, including `entityType`/`entityBundle`/`fieldName` (for TUS), cardinality → `max_number_of_files`, and the allowed extensions → `allowed_file_types` (as `.ext`).
- Adds the `uppy/uppy_widget` library and a `.uppy-widget` container; hides the core file input.

## Upload flow (js/uppy_integration.js)
1. Uppy is initialised with client-side `restrictions` (maxFileSize, maxNumberOfFiles, allowedFileTypes) and `meta` (entityType/entityBundle/fieldName).
2. On TUS completion, the JS derives the upload key from the response URL and POSTs `{fileName}` to `baseUrl + 'tus/upload-complete/' + uploadKey`.
3. The response's `fid` is written into the field's hidden `[fids]` input.

## Operational note
The `tus/upload-complete/{uploadKey}` endpoint is **not** defined by this module — provide and secure it via your TUS server integration. Enforce extension/MIME/size/access checks server-side there; do not rely on Uppy's in-browser `restrictions` alone.
