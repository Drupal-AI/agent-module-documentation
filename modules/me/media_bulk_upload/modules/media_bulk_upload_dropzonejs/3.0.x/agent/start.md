# media_bulk_upload_dropzonejs — agent start

Submodule of **media_bulk_upload**. Replaces the bulk upload form's file widget with a DropzoneJS
drag-and-drop uploader. Requires `media_bulk_upload` and the contrib `dropzonejs` module. Adds no
config, permissions, or schema of its own — enable it and every `/media/bulk-upload/{config}` form
uses DropzoneJS.

- How it overrides the form + converts uploads to files → [extend/media_bulk_upload_dropzonejs.md](extend/media_bulk_upload_dropzonejs.md)
- Parent module (config entity, permissions, base form) → [../../../../3.0.x/agent/start.md](../../../../3.0.x/agent/start.md)
