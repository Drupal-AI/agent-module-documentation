<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Plupload file widget replaces the standard File and Image field widgets with Plupload-powered upload widgets that support chunked, auto-submitting uploads with client-side progress — handy for large files.

---

The module provides two field widgets built on the `plupload` module (which wraps the Plupload
JavaScript upload library): `plupload_file_widget` for core **File** fields and
`plupload_image_widget` for core **Image** fields. Selecting one on *Manage form display* swaps the
default HTML file input for a Plupload element (`#type => plupload`) configured with `#autoupload`
and `#autosubmit`, so files upload immediately and the form submits automatically when done. Uploads
are **chunked**: the widget computes a chunk size and max file size from PHP's `upload_max_filesize`
/ `post_max_size` limits (via `PluploadWidgetTrait::getChunkSize()` / `getMaxFileSize()`), letting
users upload files larger than a single request would allow, with a progress indication and the
field's normal upload validators applied. The runtime list is `html5,flash,silverlight,html4`. The
File widget has no settings; the Image widget adds a single `preview_image_style` setting
(config schema `field.widget.settings.plupload_image_widget`) controlling the thumbnail shown for
uploaded images. The module ships its own JS (`assets/js/plupload_widget.js`, callbacks for
`FilesAdded` / `UploadComplete`) and has no settings form, permission, Drush command, or config of
its own beyond that widget setting. It depends on `drupal/plupload`.

---

- Let editors upload large files that exceed a single POST by chunking the upload.
- Provide a progress bar while uploading big media files.
- Replace the default File field widget with a Plupload uploader on a downloads content type.
- Use a Plupload image widget for large image uploads on an Article.
- Auto-start uploads as soon as a file is selected (no separate Upload click needed).
- Auto-submit the form when the upload completes for a smoother flow.
- Upload video or archive files that would otherwise hit PHP's per-request size limit.
- Show a preview thumbnail of an uploaded image using a chosen image style.
- Apply the field's existing upload validators (extensions, size) through the Plupload widget.
- Give content authors a friendlier, resumable-feeling upload experience.
- Configure the image widget's preview image style per form display.
- Keep the standard File/Image field storage while changing only the upload UI.
- Improve uploads on slow connections by sending files in chunks.
- Use HTML5 upload with graceful fallback runtimes (flash/silverlight/html4).
- Add Plupload uploads to a media/document library content type.
- Swap only the widget (not the formatter) so display is unchanged.
- Reduce timeouts on large uploads by chunking within PHP limits.
- Provide a consistent large-file uploader across multiple content types.
- Let editors upload a single large file per field with client-side handling.
- Standardise the upload experience for File and Image fields site-wide.
- Avoid custom JavaScript for chunked uploads by reusing the Plupload widget.
- Configure the widget entirely through Manage form display (no global settings).
- Upgrade an existing File field to chunked uploads by changing its widget.
- Present a modern uploader UI matching the Plupload library.
