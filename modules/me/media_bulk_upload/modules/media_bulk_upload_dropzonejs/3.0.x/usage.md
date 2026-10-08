Media Bulk Upload: DropzoneJS swaps the plain multi-file upload widget on the Media Bulk Upload form for a DropzoneJS drag-and-drop uploader, giving editors a smoother way to add many files at once.

---

This submodule integrates the [DropzoneJS](https://www.drupal.org/project/dropzonejs) module with Media Bulk Upload. A route subscriber (`MediaBulkUploadDropzoneJsRouteSubscriber`) rewrites the `media_bulk_upload.upload_form` route to use `MediaBulkUploadDropzoneJsForm`, a subclass of the parent `MediaBulkUploadForm`. The subclass changes the `file_upload` element from a `managed_file` to a `dropzonejs` element, passes the parent-computed allowed extensions to the widget, disables the submit button until upload completes, and validates that at least one file was dropped, running each file through `hook_file_validate` and deleting any file that fails. Because DropzoneJS returns file *paths* rather than saved file IDs, the submodule implements `hook_media_bulk_upload_file_ids_alter` to create permanent `file` entities from those paths and hand their IDs back to the parent form's media-creation batch. It requires both `media_bulk_upload` and the contrib `dropzonejs` module, adds no configuration or permissions of its own, and reuses the parent configuration entity, routes, and per-config permissions.

---

- Give editors a drag-and-drop area instead of a standard file input on the bulk upload form.
- Upload large batches of media with client-side chunking/queueing from DropzoneJS.
- Keep the parent form's extension and file-size restrictions while using the nicer widget.
- Disable the submit button until all files finish uploading, preventing premature submits.
- Reuse existing `media_bulk_config` configurations unchanged — no reconfiguration needed.
- Validate dropped files through `hook_file_validate` and auto-delete invalid ones.
- Show a "Click or drop your files here" drop zone on `/media/bulk-upload/{config}`.
- Convert DropzoneJS uploads into permanent file entities before media creation.
- Provide a modern upload UX on sites that already standardize on DropzoneJS.
- Enable only on environments where the DropzoneJS library/module is installed.
- Route all existing bulk upload forms through the DropzoneJS widget via a route subscriber (no per-form toggle).
- Let contributors upload media without touching the full media admin, using drag-and-drop.
- Preserve the parent's per-media-type extension matching and batch processing.
- Surface per-file validation errors inline when a dropped file is rejected.
- Swap back to the plain widget simply by uninstalling this submodule.
