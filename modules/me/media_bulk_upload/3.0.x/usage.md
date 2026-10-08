Media Bulk Upload lets editors upload many files at once and turns each into a media entity, matching every file to a media type by its extension based on a reusable bulk-upload configuration.

---

Media Bulk Upload adds a `media_bulk_config` configuration entity: each config picks a set of media types, an optional media form mode, and an upload location, and exposes a bulk upload form at `/media/bulk-upload/{config}`. The form (`MediaBulkUploadForm`) presents a multi-value `managed_file` element whose allowed extensions and maximum file size are derived from the selected media types' source (file/image) fields. On submit it runs a Batch: each uploaded file is validated (extension, per-type max file size, and image resolution for image types), moved from the temporary upload location into the media type's target directory, and saved as a new media entity of the type whose file-extensions match. When several selected types share an extension, the file is assigned to one of them automatically. Access is governed by a static `administer media_bulk_upload configuration` permission for the admin UI plus a dynamic per-configuration `use {id} bulk upload form` permission for each form. A landing route (`/media/bulk-upload`) lists the configs the user may use, redirecting straight to the form when only one exists. A `MediaTypeManager` service groups media types by extension and reports each type's target field, allowed extensions, max size, and settings; a `MediaSubFormManager` embeds the chosen media form mode so shared metadata fields can be set for all uploads at once. A submodule swaps the upload widget for DropzoneJS, and the submit handler fires a `hook_media_bulk_upload_file_ids_alter` alter so integrations can rewrite the list of uploaded file IDs.

---

- Let editors upload dozens of images at once and auto-create image media entities.
- Bulk-import a folder of PDFs as document media in one operation.
- Create a mixed image/video/document upload form that routes each file to the right media type by extension.
- Seed a fresh media library quickly during a site build or migration.
- Give a photo team a dedicated upload form limited to image media types.
- Set shared metadata (e.g. a common name or field value) across every file uploaded in a batch.
- Restrict which roles may use a specific bulk-upload form via its per-config permission.
- Expose multiple bulk-upload configurations, each scoped to a different set of media types.
- Auto-redirect users to the only upload form they can access from `/media/bulk-upload`.
- Configure the temporary upload location (e.g. `temporary://`, `private://`, `public://`) per configuration.
- Enforce per-media-type maximum file size on upload.
- Enforce min/max image resolution on uploaded images.
- Reject files whose extension is not allowed by any selected media type.
- Use a custom media form mode to enrich the upload form with only the fields shared by all selected types.
- Fall back to the default media form when a chosen form mode is missing on a type.
- Process large uploads reliably through Drupal's Batch API.
- Move uploaded files into each media type's configured target directory automatically.
- Add a "Bulk upload media" entry under Content › Media when Admin Toolbar Extra Tools is present.
- Manage bulk-upload configurations at Admin › Configuration › Media › Bulk upload media.
- Export bulk-upload configurations as configuration between environments.
- Swap the plain file widget for a DropzoneJS drag-and-drop uploader (submodule).
- Alter the set of uploaded file IDs before media creation via `hook_media_bulk_upload_file_ids_alter`.
- Look up which media types accept a given file extension via the `MediaTypeManager` service.
- Determine a media type's target field, allowed extensions, and max size programmatically.
- Provide non-admin contributors a self-service media upload workflow without the full media admin.
