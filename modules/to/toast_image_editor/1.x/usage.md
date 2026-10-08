<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Toast Image Editor embeds the Toast UI Image Editor into Drupal's media edit form so editors can crop, rotate, flip, draw, annotate and filter an image media item in the browser, saving the result as a new media revision.

---

The module bundles the Toast UI Image Editor (and its fabric.js / tui-color-picker / file-saver dependencies) as vendored assets — no CDN or external service — and wires it into the standard media edit form via `hook_form_media_form_alter()`. It appears only on image-source media types that already have a file, and only for users holding the "use toast image editor" permission. When the editor is opened, the current image is loaded by URL; the edited result is captured client-side as a base64 data URL. It is written back to the media's existing source file in one of two ways: submitting the media form carries the data in a hidden `toast_image_editor_data` field (intercepted at `hook_media_presave`), or the editor's own Save button POSTs the data to the `/media/{media}/save-image` JSON route. Either path re-checks the "use toast image editor" permission and the media entity's `update` access, decodes the base64, and overwrites the same source file with `FileExists::Replace` while creating a new media revision (log message "Image edited with Toast Image Editor"), so the original is preserved in revision history. A settings form at `/admin/config/media/toast-image-editor` chooses which toolbar tools appear, the editor width/height, and a light ("white") or dark ("black") theme. Because saving replaces the stored image, restrict "use toast image editor" to trusted media editors.

---

- Crop an image media item to a custom size or aspect ratio without leaving Drupal.
- Rotate an image to 90° steps or an arbitrary angle.
- Flip an image horizontally or vertically.
- Draw freehand lines and marks on an image.
- Add rectangles, circles, and triangles as shape overlays.
- Insert icons and symbols from the built-in icon set.
- Add text labels, captions, or watermarks onto an image.
- Apply masks and image filters (grayscale, sepia, invert, blur, sharpen, etc.).
- Adjust brightness, contrast, tint, and color of an image.
- Edit AI-generated images to fine-tune them before publishing.
- Keep an audit trail: every save creates a new media revision so the original can be rolled back.
- Edit images directly from the Media library edit screen.
- Restrict who can edit images with the "use toast image editor" permission.
- Restrict who can change editor configuration with "administer toast image editor".
- Choose which tools appear in the toolbar to simplify the editor for content teams.
- Set a fixed editor width and height to fit your admin theme.
- Switch the editor between a light and a dark theme.
- Run entirely self-hosted — the editor and its JS dependencies are vendored, no external calls.
- Annotate screenshots or product photos stored as media.
- Provide an in-Drupal alternative to editing images in external software and re-uploading.
- Pair with focal-point or image-crop modules for a fuller media-editing workflow.
- Correct or touch up existing media images site-wide from one consistent interface.
