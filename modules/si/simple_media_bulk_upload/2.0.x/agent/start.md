# Simple Media Bulk Upload — agent index

Drag-and-drop bulk creation of Media entities. One upload form (DropzoneJS) at
`/admin/content/media/bulk-upload` creates one `media` entity per dropped file, then walks you
through editing each. Depends on `dropzonejs`.

- **Settings (`max_files`), routes, and the config form** →
  [configure/settings.md](configure/settings.md)
- **Permissions that gate uploading and administering** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Upload form route: `simple_media_bulk_upload.bulk_upload` (`/admin/content/media/bulk-upload`),
  permission `dropzone upload files` (from the DropzoneJS module).
- Config route: `simple_media_bulk_upload.config_form`
  (`/admin/config/media/simple-media-bulk-upload`), permission `administer simple media bulk upload`.
- Config: `simple_media_bulk_upload.settings` → single key `max_files` (default 30, 0 = unlimited).
- Only **file-based** media types (source field is a FileItem or subclass) are offered.
- Pre-select a type with `?media_type=<id>`; "Bulk upload" action links appear on
  `/admin/content/media` and the Media Library page.
