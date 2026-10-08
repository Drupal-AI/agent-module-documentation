Media Entity File Replace adds a "Replace file" widget to media edit forms so content editors can swap the underlying source file of any file-based media entity (Document, Image, Audio, Video, etc.) while keeping the original filename and path intact.

---

Drupal core's media edit form lets you reference a different file, but it does not offer a true in-place replacement: the old file usually stays and the URL changes. This module solves that by adding an extra "Replace file" pseudo-field to the "Manage form display" of any media type whose source is a file field. Once enabled, editors editing an existing media entity see a file upload with two options: overwrite the original file (keeping the same filename and extension, so existing links and embeds keep working) or upload a new file that replaces the reference (using the new filename). When overwriting, the module copies the uploaded file over the original on disk, re-saves the file entity to recalculate metadata such as size, and flushes any image style derivatives so thumbnails regenerate. It enforces that an overwrite uses the same file extension as the original, since web servers set content-type from the filename. It also plays nicely with content translation, skipping cases where a replacement could clobber the default-language file. The feature is implemented entirely through form alters and hooks — there is no configuration UI, no permissions, and no config schema of its own.

---

- Replace a PDF attached to a Document media entity without changing its URL.
- Update a logo image while keeping every existing embed pointing at the same file.
- Overwrite an outdated policy document so bookmarked links keep resolving.
- Swap a corrupted source file on an existing media entity in place.
- Upload a corrected spreadsheet over the original, preserving the filename.
- Keep SEO and inbound links stable by never changing a media file's path.
- Enable the "Replace file" widget only on the media types where editors need it.
- Overwrite an image and have its image-style derivatives regenerated automatically.
- Replace a file but choose a new filename when a rename is actually desired.
- Give non-technical editors a one-click file swap instead of deleting and re-adding media.
- Maintain a stable canonical URL for downloadable assets like brochures.
- Update audio or video source files for existing media entities.
- Ensure a replacement keeps the same extension to avoid broken content-type headers.
- Replace files on translated media without overwriting the default-language version.
- Refresh a frequently updated report file (e.g. weekly export) in place each week.
- Correct a wrong file that was uploaded to a media entity after publication.
- Preserve file metadata and usage tracking while changing the actual bytes.
- Hide the core file widget's remove/upload buttons to steer editors to safe replacement.
- Provide a consistent replacement workflow across Document, Image, Audio and Video types.
- Avoid orphaned duplicate files that accumulate when re-uploading through the core widget.
