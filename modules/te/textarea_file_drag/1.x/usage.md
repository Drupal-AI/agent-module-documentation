<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Textarea File Drag'n'Drop attaches a drop zone to every textarea so files dropped in are AJAX-uploaded and their public URL inserted.
---
`hook_element_info_alter()` adds a `#process` callback that decorates textareas with a `textarea-file-drag` class, the allowed-extensions list, and an upload URL — but only for users holding the `dragndrop files to textarea` permission. The bundled JS posts the dropped file to `/ajax/textarea-file-drag` (`TextareaFileDragController::upload`), gated by the same permission. The controller checks the client extension against the configured allowlist, sanitises the filename (transliterate + strip to `[0-9A-Za-z_.-]` + `FileUploadSanitizeNameEvent`), moves the file into the configured `upload_path` (default `public://inline`), and returns the generated public URL as JSON.

Operational notes: no Drupal `file` entity is created (files land directly in the public filesystem). The upload path is admin-configurable free-text starting with `public://`. Access is controlled by the `dragndrop files to textarea` permission, so grant it only to trusted roles.

Typical setup: enable the module, grant the permission, then tune allowed extensions and the upload path at `/admin/config/media/textarea-file-drag`.
---
- Enable drag-and-drop uploads on comment/body textareas.
- Grant `dragndrop files to textarea` to trusted content editors.
- Restrict allowed extensions on the settings form.
- Change the upload destination path (default `public://inline`).
- Insert an uploaded image URL directly into a plain-text field.
- Attach reference documents (pdf/doc/xls) by dropping them.
- Let editors paste screenshots into a textarea workflow.
- Add drop-upload to a custom form's textarea elements.
- Sanitise uploaded filenames automatically via the event.
- Provide a lightweight alternative to a full media widget.
- Serve uploaded files from the public filesystem.
- Localize the "Extension not allowed" error message.
- Wire the upload endpoint into a custom editor integration.
