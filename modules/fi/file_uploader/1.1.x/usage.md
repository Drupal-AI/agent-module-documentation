File Uploader is a JavaScript file-upload framework for Drupal. It supplies a `file_uploader` form element (extending core managed file), a `FileUploaderWidgetBase` field-widget base class, and a single XHR endpoint that saves uploads as managed files — the pieces an integration module needs to wire a third-party uploader (such as Uppy) to Drupal file and image fields.

---

Drupal's core managed-file element does a full form round-trip per attachment, which is fine for one file but poor for a drag-and-drop area handling many files with per-file progress. Rebuilding that per project means an XHR endpoint plus the access and validation glue to keep it correct. File Uploader packages that glue: the `file_uploader` render element publishes a `drupalSettings.file_uploader[<id>]` payload (provider, field name, endpoint URL, extension/size limits and existing-file previews) that a client-side uploader binds to, and the `/file-uploader/upload` route saves each posted file with `file_save_upload()` using the field's own validators and destination, returning the new file id. Integrators subclass `FileUploaderWidgetBase` (adding the `@FieldWidget` annotation and a `#upload_provider`), ship a `window.DrupalFileUploader[<provider>]` client with a `<provider>/widget` library, and can adjust the element and its settings through `hook_file_uploader_element_alter()` or a per-provider `file-uploader--<provider>.html.twig` template. The module is core-only and defines no settings page, permissions, drush commands or config schema — configuration is per-field on the widget settings form.

---

- Build a drag-and-drop upload area for a file or image field.
- Upload multiple files over XHR with per-file progress.
- Replace a full form submit on every file attachment.
- Give editors a modern multi-file upload experience.
- Integrate a third-party JS uploader (Uppy, etc.) with Drupal.
- Provide a `file_uploader` render element to a custom form.
- Extend `FileUploaderWidgetBase` to create a new uploader widget.
- Reuse one upload framework across several integration modules.
- Save uploaded files as managed files and get back their fids.
- Enforce the field's allowed extensions and size on async uploads.
- Show existing field files as previews in the uploader.
- Add an image-style preview URL to existing images via the alter hook.
- Auto-start uploads by setting an uploader option in an alter hook.
- Theme the uploader per provider with a template suggestion.
- Expose custom uploader options to the client via widget settings.
- Add extra upload methods by overriding `uploadMethods()`.
- Upload large files without a page reload.
- Improve upload UX on mobile devices.
- Handle many attachments in a single form.
- Reduce upload abandonment with responsive feedback.
- Build a chunked or resumable uploader on top of the framework.
- Provide a documentation link on the widget settings form.
- Bind a custom JavaScript uploader to a Drupal-managed endpoint.
- Standardise upload handling across a multisite or platform build.
