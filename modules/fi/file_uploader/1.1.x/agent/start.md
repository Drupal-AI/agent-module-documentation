<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Uploader (file_uploader) — agent index

A JavaScript file-upload **framework** for Drupal. It ships a `file_uploader` form/render element
(extends core `ManagedFile`), a `FileUploaderWidgetBase` field-widget base class that integration
modules extend, and one XHR endpoint (`/file-uploader/upload`) that saves an uploaded file as a
managed file. It is not a finished widget — enabling it alone gives you building blocks; the actual
uploader UI comes from an integration module (e.g. `file_uploader_uppy`) that registers a
`window.DrupalFileUploader[<provider>]` client and a `<provider>/widget` library.

- Dependencies: core only (`file` module implied by extending `FileWidget`/`ManagedFile`). Core requirement `^9 || ^10 || ^11`.
- Configure route: none — no settings page. Per-field config lives on the field widget settings form.
- Provides: a form element, a field-widget base class, a theme hook, and an alter hook. No permissions, no drush, no config schema, no custom plugin manager.

Solution docs:
- **Use / theme the render element, or call the XHR endpoint** → [api/element.md](api/element.md)
- **Build an integration by extending the widget base** → [fields/widget.md](fields/widget.md)
- **Alter the element/upload settings; theme hooks it implements** → [hooks/element-alter.md](hooks/element-alter.md)
- **Template, theme suggestion, library and drupalSettings shape** → [theme/file-uploader.md](theme/file-uploader.md)

Key facts:
- Form element: `#type` `file_uploader` (`Drupal\file_uploader\Element\FileUploader`, `@FormElement("file_uploader")`).
- Widget base: `Drupal\file_uploader\Plugin\Field\FieldWidget\FileUploaderWidgetBase` (extends `Drupal\file\Plugin\Field\FieldWidget\FileWidget`).
- Route: `file_uploader.xhr` → path `/file-uploader/upload`, controller `FileUploaderController::upload`, access `FileUploaderController::access`, plus `_csrf_token: "TRUE"`.
- Theme hook: `file_uploader` (template `templates/file-uploader.html.twig`); suggestion `file_uploader__<upload_provider>`.
- Alter hook: `hook_file_uploader_element_alter(&$element, &$settings, $form_state)` (module + theme variants).
- Library: `file_uploader/widget` (`public/js/widget.js`); the element attaches `<upload_provider>/widget`.
- Key-value collection: `file_uploader` (stores per-render upload options keyed by an HMAC).
- `drupalSettings.file_uploader[<element_id>]` carries `provider`, `name`, `options` (incl. `xhr`, `validators`) and `values`.
