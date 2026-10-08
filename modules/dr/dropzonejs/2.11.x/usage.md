DropzoneJS provides the Drupal integration for the DropzoneJS JavaScript library, adding a drag-and-drop file upload area (with image previews and AJAX uploads) as a reusable `dropzonejs` form element.

---

DropzoneJS wraps the open-source DropzoneJS library so Drupal forms can offer modern drag-and-drop, multi-file uploads instead of the plain HTML file input. It exposes a `#type => 'dropzonejs'` render/form element that developers place in any form; the element handles client-side file selection, size/extension limits, optional client-side image resizing (via the exif-js library), and posts each file asynchronously to the `dropzonejs.upload` route. Server-side, an `UploadHandler` service streams the incoming file into a configurable temporary scheme (appending a `.txt` extension for security until the real extension is validated), and a `DropzoneJsUploadSave` service turns temporary uploads into validated Drupal `file` entities. Global behavior — temporary upload scheme, legacy filename transliteration, and upload timeout — is stored in the `dropzonejs.settings` config object. The module also hooks into Media Library, swapping the add form for image, video, audio and generic file media sources so uploads there use Dropzone. It requires the actual DropzoneJS library to be present in the site's `libraries/` directory (installed via Composer or manually). It ships an `eb_widget` submodule that turns the element into an Entity Browser widget. All uploads are gated by the `dropzone upload files` permission.

---

- Add a drag-and-drop upload zone to a custom form via the `dropzonejs` element.
- Let editors upload many files at once with visual thumbnails.
- Replace the default Media Library add form with a Dropzone uploader for images.
- Provide Dropzone uploads for video, audio and generic file media sources.
- Upload large files asynchronously without a full page submit.
- Enforce a maximum file size on the client before upload begins.
- Restrict accepted file extensions on a per-element basis.
- Limit the number of files a user may drop in one go.
- Resize images in the browser before upload to save bandwidth (client-side resize).
- Generate client-side thumbnails with contain or crop methods.
- Store incoming uploads in a temporary stream wrapper of your choice (public/private/temporary).
- Set an upload timeout for slow connections.
- Transliterate uploaded filenames to ASCII (legacy option) for safe file systems.
- Gate all Dropzone uploads behind a dedicated permission.
- Build a custom media-creation workflow that reacts to the media-entity-create event.
- Turn Dropzone into an Entity Browser widget with the bundled eb_widget submodule.
- Programmatically convert an uploaded temp file into a validated Drupal file entity.
- Add extra file validators (size, extension) when saving uploaded files in code.
- Override the upload area's prompt text and "Select files" button label.
- Theme the drop zone appearance via the `dropzonejs` template.
- Point the JS library discovery at a custom `libraries/dropzone` build (Dropzone 5 or 6).
- Offer a friendlier upload UX than core's file field on content forms.
- Collect multiple media assets in a single content-authoring step.
- Sanitize uploaded filenames through core's file-sanitization event.
- Support decoupled or AJAX-heavy forms that need chunked file streaming.
