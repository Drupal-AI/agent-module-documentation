# Upload flow, endpoint reuse, and the delete path

This element does not define its own routing or upload controller. It reuses the **`dropzonejs`
core** upload endpoint and layers the webform save logic on top. The lifecycle:

## 1. Client → temporary upload (dropzonejs core)

The rendered widget attaches `dropzonejs/integration` (core) and `webform_dropzonejs/integration`
(this module). As files are dropped, Dropzone POSTs them to the core route **`dropzonejs.upload`**,
which is gated by the core permission **`dropzone upload files`**. Core's upload handler writes each
stream to the temporary scheme configured at `dropzonejs.settings.tmp_upload_scheme` and returns a
sanitized filename with a **`.txt` extension appended** (a dropzonejs-core safety measure for the
temporary file). The accumulated temp filenames are stored client-side and submitted in a
`;`-separated hidden field named **`uploaded_files`** scoped to the element.

## 2. `valueCallback` — read the submitted temp files (`Element/WebformDropzonejs.php:144`)

On webform submission the render element's `valueCallback`:

1. Reads `uploaded_files` from user input and `explode(';', …)`.
2. Reads `tmp_upload_scheme` from `dropzonejs.settings`.
3. For each name: strips the appended `.txt` with `self::fixTmpFilename($name)` (inherited from the
   `dropzonejs` core element), then dispatches a core
   `Drupal\Core\File\Event\FileUploadSanitizeNameEvent($name, self::getValidExtensions($element))` to
   sanitize the filename, and `@rename()`s the temp file from its `.txt` name to the sanitized name
   within the temp scheme (unlinking a colliding target first).
4. Builds `#value['uploaded_files']` as a list of `['path' => tmp://sanitized, 'filename' => sanitized]`.

`getValidExtensions($element)` (inherited from the `dropzonejs` core element) returns the element's
advertised extension list, derived from `#upload_validators` / `#extensions`.

## 3. `validateManagedFile` — temp → permanent (`Plugin/WebformElement/WebformDropzonejs.php:43`)

The plugin's `validateManagedFile` (an `#element_validate` handler contributed by
`WebformManagedFileBase`) turns the temporary uploads into permanent files:

```php
$destination_path = $element['#upload_location'];
foreach ($element['#value']['uploaded_files'] as $dropzone_file) {
  $file_name = $destination_path . '/' . $dropzone_file['filename'];
  if ($file_data = file_get_contents($dropzone_file['path'])) {
    if ($final_file = \Drupal::service('file.repository')
        ->writeData($file_data, $file_name, FileSystemInterface::EXISTS_RENAME)) {
      $fids[] = $final_file->id();
      $files[] = $final_file;
      unlink($dropzone_file['path']);   // remove the temp file
    }
  }
}
```

It then sets the submission value: a single fid when `#multiple` is empty, otherwise the array of
fids; `NULL` when no files. `#files` is populated for downstream webform processing. `writeData`
uses `EXISTS_RENAME`, so a name collision in the destination yields `name_0`, `name_1`, ….

## 4. Re-showing and deleting existing files

- **Re-show (edit):** `processDropzoneJs` loads each `#default_value` fid and pushes
  `{id, path (uri), name, size, accepted, is_image}` into
  `drupalSettings.webformDropzoneJs[elementId].files`; the JS re-emits them onto the Dropzone
  instance and, when `file_directory` is non-empty, makes each preview open
  `file_directory + '/' + fileName` in a new window. `file_directory` is derived from
  `#upload_location` by replacing `private://` → `/system/files/` and the `_sid_` token → the
  submission id.
- **Delete:** when a user removes a previously-attached file, the JS appends a hidden
  `deleted_dropzone_files[]` input carrying that fid. On validate, `validateManagedFile` reads
  `deleted_dropzone_files` from the request; any listed fid that was in `#default_value` is deleted
  via the `file` storage and dropped from the value.

## 5. Display / theming

- Theme hook `webform_element_dropzonejs` (template `templates/webform-element-dropzonejs.html.twig`)
  renders a submitted value as `{{ file_link }}`. Its preprocess
  `template_preprocess_webform_element_dropzonejs` loads webform's theme include and delegates to
  `template_preprocess_webform_element_managed_file`, so the value renders like a standard webform
  managed-file value.
- The input widget itself renders through the `dropzonejs` core theme (`#theme => 'dropzonejs'` set
  in `getInfo`), wrapped in a `form_element`.

## Machine-name quick reference

| Thing | Value |
|---|---|
| Reused route | `dropzonejs.upload` (dropzonejs core) |
| Reused permission | `dropzone upload files` (dropzonejs core) |
| Temp scheme config | `dropzonejs.settings` → `tmp_upload_scheme` |
| Default extensions config | `webform.settings` → `file.default_managed_file_extensions` |
| Submit field (uploads) | `uploaded_files` (`;`-separated temp filenames) |
| Submit field (deletes) | `deleted_dropzone_files[]` (fids) |
| drupalSettings | `webformDropzoneJs[elementId].files`, `.file_directory` |
| Save service | `file.repository`::`writeData(..., EXISTS_RENAME)` |
