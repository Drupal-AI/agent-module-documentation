<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
File Uploader by Uppy plugs the Uppy JavaScript uploader into the File Uploader module, replacing the plain file input with a drag-and-drop Dashboard that shows progress, previews, and optional inline image editing.

---

Drupal's stock file widget is an `<input type="file">` plus a page submit, which gives editors no drag target, no progress indication, no preview, and no way to fix a large upload that fails partway. This module swaps in **Uppy's Dashboard** for any `file` or `image` field: drag-and-drop, a queue of pending files, live progress, thumbnails, and an optional **Image Editor** (crop, rotate, zoom, flip) applied to new uploads before they are sent. Install it with `composer require drupal/file_uploader_uppy` (it pulls in **File Uploader**, `drupal/file_uploader`, which supplies the server side), enable the module, then go to **Manage form display** for the entity type, switch the file/image field's widget to **"File uploader by Uppy"**, and use the gear icon to set options — auto-proceed, progress details, status-bar and informer visibility, thumbnail size, the image editor and its allowed actions, and a light/dark/auto **theme**. Uppy uploads each file via its XHR plugin to the File Uploader endpoint, which saves the file and returns its id; the widget collects those ids so they become the field value on submit. The field's own **allowed extensions, maximum size, and cardinality** (set on the ordinary File/Image field settings) still govern what is accepted — Uppy mirrors them into its client-side hints, and the server enforces them. Interface translations load automatically for the current language via Uppy's locale files, and a `hook_file_uploader_uppy_locale` alter hook lets a custom module add or remap languages.

---

- Add drag-and-drop file uploads to a content type.
- Show live upload progress to editors.
- Preview images before they are saved.
- Let editors crop, rotate, zoom, or flip an image before upload.
- Upload several files into one field at once.
- Replace the stock file/image widget with a modern uploader.
- Give a document-library workflow a friendlier upload UI.
- Improve the media upload experience for authors.
- Auto-start uploads as soon as files are dropped.
- Show or hide progress details in the status bar.
- Hide the cancel button for a simpler interface.
- Enlarge a single-file preview for photo fields.
- Set custom thumbnail dimensions for previews.
- Choose a light, dark, or auto Dashboard theme.
- Restrict the image editor to specific actions (e.g. crop only).
- Upload from a mobile device with a touch-friendly UI.
- Localize the uploader UI to the site's language.
- Add or remap an Uppy locale from a custom module.
- Reduce support requests about the upload experience.
- Handle a batch of photographs in a gallery field.
- Theme the uploader wrapper via the `file_uploader_uppy` template.
