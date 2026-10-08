<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Uppy provides a Drupal field widget that replaces the standard file/image upload control with the Uppy JavaScript uploader and a resumable TUS transfer.
---
The module adds a single field widget plugin, `uppy_widget` (`UppyWidget`, extending core `FileWidget`), selectable for `file` and `image` fields under "Manage form display". It renders the Uppy dashboard (or drag-drop) in place of the core upload input and, for the default TUS uploader, streams the file in chunks; `js/uppy_integration.js` then calls back to `tus/upload-complete/{uploadKey}` to obtain the saved file's `fid` and populate the field. Widget settings (auto-proceed, file source, uploader, chunk size) are stored per field-instance and passed to the JS via `drupalSettings`.

Because it extends core `FileWidget`, the widget still carries core's server-side upload validators — the configured max file size and the field's allowed extensions are passed through (`file_validate_size`, `file_validate_extensions`) and are also mirrored into Uppy's client-side `restrictions` (max size, max number of files, allowed file types). **Note that this module itself ships no routing.yml, controller, or upload endpoint**: the `tus/upload-complete/{uploadKey}` route and the actual server-side file persistence are provided by a separate TUS server component, so the real access control and validation on the received bytes live outside this module. The Uppy restrictions configured here are client-side conveniences and must not be treated as a security boundary on their own.

Setup: enable the module, edit a content type's form display, switch a file/image field's widget to "Uppy file uploader", and tune the chunk size / source / auto-proceed options. Ensure the TUS upload endpoint the JS posts to is provided and access-controlled by your TUS server setup.
---
- Replace the core upload control on a file field with Uppy.
- Replace the core upload control on an image field with Uppy.
- Offer a drag-and-drop dashboard for uploads.
- Use the drag-drop-only source instead of the full dashboard.
- Upload large files resumably via the TUS uploader.
- Tune the chunk size (bytes) for chunked transfers.
- Start uploads automatically without a button press (auto-proceed).
- Enforce the field's max file size through the widget.
- Enforce the field's allowed extensions through the widget.
- Limit the number of files to the field's cardinality.
- Show a nicer upload progress UI to editors.
- Configure the widget per content type via Manage form display.
- Read widget settings in JS from drupalSettings['uppy'].
- Populate the field's fid after a completed TUS upload.
- Keep uploads working across flaky connections (resumable).
- Pair with a TUS server component that persists the bytes.
- Review per-instance widget settings summaries in the display UI.
- Swap back to the core widget by changing the form display.
