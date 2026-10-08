# Plupload Integration — agent index

Adds one Form API element, `#type => 'plupload'`, wrapping the Plupload JS library for
chunked / multi-file / drag-and-drop uploads. **No configure route** (`configure: null`),
no permissions of its own, no Drush, no plugin types. Only persistent config is
`plupload.settings:temporary_uri`. Uploads hit the CSRF-protected route
`plupload.upload` (`/plupload-handle-uploads`, permission `access content`).

- **Use the `plupload` element on a form: properties and the value array your submit
  handler receives** → [api/element.md](api/element.md)
- **The one setting (`temporary_uri`) and the upload route** →
  [configure/settings.md](configure/settings.md)

Key facts:
- The element does **not** save `file` entities. After submit,
  `$form_state->getValue('<key>')` is an array of `['name','tmpname','status','tmppath']`
  descriptors; your submit handler copies/saves them.
- Class: `\Drupal\plupload\Element\PlUploadFile` (`@FormElement("plupload")`).
- Server-side validation via `#upload_validators` (core `FileValidator`,
  e.g. `FileExtension`); default extensions if none supplied:
  `jpg jpeg gif png txt doc xls pdf ppt pps odt ods odp`.
- Demo: submodule `plupload_test` → `/plupload-test`.
