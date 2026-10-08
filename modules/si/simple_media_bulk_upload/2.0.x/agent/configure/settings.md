# Configuration & routes

## The only setting: `max_files`

Config object **`simple_media_bulk_upload.settings`**, one key:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `max_files` | integer | `30` | Max files droppable per bulk upload. **`0` = no limit.** |

Edited at **`/admin/config/media/simple-media-bulk-upload`** (route
`simple_media_bulk_upload.config_form`, permission `administer simple media bulk upload`).
When `max_files > 0` the upload form shows "Up to N files can be uploaded at once".

```bash
drush cget simple_media_bulk_upload.settings max_files
drush cset simple_media_bulk_upload.settings max_files 50 -y
```

```php
\Drupal::configFactory()->getEditable('simple_media_bulk_upload.settings')
  ->set('max_files', 0)->save();   // 0 = unlimited
```

## The upload form

Route **`simple_media_bulk_upload.bulk_upload`** → `/admin/content/media/bulk-upload`,
permission **`dropzone upload files`** (defined by the `dropzonejs` dependency).

Flow:
1. Pick a media type. Only media types whose **source field is file-based** (FileItem or a
   subclass such as image/video/audio file) and that you can create are listed.
   Pass `?media_type=<machine_id>` to skip the picker.
2. Drag files onto the DropzoneJS widget. Accepted **extensions** and **max file size** come
   from that media type's source-field settings (`file_extensions`, `max_filesize`).
3. Submit → one `file` + one `media` entity created per file, each moved to the source
   field's upload location; you are redirected to the first item's edit form with the rest of
   the new IDs in `?bulk_upload_ids[]=...`.

Required fields on the media type are **not** validated during upload — you complete them in
the guided per-item edit pass (`BulkUploadFormHelper::processSubmissionRedirectForBulkUpload`
adds a submit handler to the media edit form that advances to the next new item).

## Action links

`simple_media_bulk_upload.links.action.yml` adds a **"Bulk upload"** action link on
`entity.media.collection` (`/admin/content/media`) and `view.media_library.page`.
