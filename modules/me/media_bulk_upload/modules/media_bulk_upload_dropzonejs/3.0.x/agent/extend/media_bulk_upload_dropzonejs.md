# How the DropzoneJS integration works

No configuration. Enable `media_bulk_upload_dropzonejs` (with `media_bulk_upload` and contrib
`dropzonejs` installed) and every bulk upload form switches to DropzoneJS automatically.

## Route override

`MediaBulkUploadDropzoneJsRouteSubscriber` (an `event_subscriber` service) alters the
`media_bulk_upload.upload_form` route, replacing its `_form` default with
`Drupal\media_bulk_upload_dropzonejs\Form\MediaBulkUploadDropzoneJsForm`. There is no per-form or
per-config toggle — the swap is global once enabled.

## Form subclass

`MediaBulkUploadDropzoneJsForm extends MediaBulkUploadForm`. In `buildForm()` it calls the parent,
then:

- sets `$form['file_upload']['#type'] = 'dropzonejs'`;
- copies the parent-computed allowed extensions to `#extensions`;
- sets `#disable_form_buttons = '.button.form-submit'` (submit disabled until upload finishes);
- adds a `#dropzone_description`.

`validateForm()` requires at least one dropped file (`file_upload.uploaded_files`), then runs each
file through `hook_file_validate`; files with validation errors are reported and deleted from disk.

## Turning DropzoneJS paths into files

DropzoneJS returns uploaded file **paths**, not saved file IDs, under
`$file_ids['uploaded_files']`. The submodule implements the parent's
`hook_media_bulk_upload_file_ids_alter()` to create permanent `file` entities from those paths
(owned by the current user) and replace `$file_ids` with the new file IDs. The parent
`MediaBulkUploadForm::submitForm()` then batches those files into media entities exactly as with the
plain widget. (See the parent's hooks doc for the alter signature.)
