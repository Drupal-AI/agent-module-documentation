Simple Media Bulk Upload adds a drag-and-drop form (backed by DropzoneJS) at `/admin/content/media/bulk-upload` that turns many uploaded files into individual Media entities in one pass, then walks you through editing each new item's fields.

---

The module provides one main form (`BulkUploadForm`) on the route `simple_media_bulk_upload.bulk_upload` (`/admin/content/media/bulk-upload`, permission `dropzone upload files`). You pick a **media type** (only media types whose source field is file-based — file, image, video file, audio file, etc. — and that you have permission to create are offered) and drag files onto a DropzoneJS widget; accepted extensions and max file size are read from that media type's source-field settings. On submit it creates a `file` entity and a `media` entity per uploaded file, moves each file to the source field's configured upload location, and redirects you to the edit form of the first new media item, passing the remaining IDs in a `bulk_upload_ids` query parameter. A companion `hook_form_alter` on the media edit form (`BulkUploadFormHelper::processSubmissionRedirectForBulkUpload`) then chains you through editing each remaining item in turn. A settings form (`simple_media_bulk_upload.config_form`, `/admin/config/media/simple-media-bulk-upload`, permission `administer simple media bulk upload`) exposes a single `max_files` value (config `simple_media_bulk_upload.settings:max_files`, default 30; 0 = unlimited). An action link "Bulk upload" is added to the media collection (`/admin/content/media`) and the Media Library page. The module depends on `dropzonejs`; required fields on a media type are intentionally not validated at upload time (you fill them in during the per-item edit pass).

---

- Upload dozens of images into the Image media type in a single drag-and-drop.
- Bulk-import a folder of PDFs as Document media entities.
- Seed a fresh Media Library with many assets quickly.
- Let editors mass-upload video files without creating each media item by hand.
- Pre-select a media type via the `?media_type=` query parameter to skip the type picker.
- Cap how many files can be dropped at once via the `max_files` setting.
- Remove the file-count cap entirely by setting `max_files` to 0.
- Add a "Bulk upload" action link to the media admin listing for editors.
- Add the same action to the Media Library modal/page for in-context uploads.
- Enforce a media type's own allowed extensions and max size during bulk upload.
- Upload first, then fill in required alt text / fields per item in the guided edit pass.
- Give a photographer role a fast path to publish shoots as media entities.
- Restrict who can bulk upload using the `dropzone upload files` permission.
- Migrate a batch of legacy files into managed Media entities.
- Populate an audio library by dropping many MP3s at once.
- Bulk-add downloadable assets (spec sheets, brochures) to a product site.
- Let a marketing team drop a campaign's worth of images in one go.
- Chain through editing each newly created item using the built-in redirect flow.
- Use DropzoneJS's progress UI for large multi-file uploads.
- Keep uploads scoped to file-based media types only (the form hides non-file types).
