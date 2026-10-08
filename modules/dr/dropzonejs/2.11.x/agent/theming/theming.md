# Theming

## Theme hook

`hook_theme()` registers one hook (`dropzonejs.module`):

- `dropzonejs` — render element `element`. Default template
  `templates/dropzonejs.html.twig`. Preprocessor `template_preprocess_dropzonejs()`.

Template variables: `attributes`, `dropzone_description` (drop-zone prompt),
`or_text` (localized "or"), `select_files_button_text` (singular/plural "Select file(s)"),
`uploaded_files` (hidden field holding the upload list), `children`.

Override by copying `dropzonejs.html.twig` into your theme. The wrapper `<div>` gets the
element `#id` and any `#attributes['class']`; the module also adds the `dropzone-enable`
class and attaches `dropzonejs/widget` (CSS in `css/dropzone.widget.css`, remove icons in
`icons/`).

## Libraries you can attach/extend

- `dropzonejs/dropzonejs` — the raw JS library (auto path-detected).
- `dropzonejs/integration` — Drupal glue (`js/dropzone.integration.js`).
- `dropzonejs/widget` — widget theme CSS.
- `dropzonejs/media_library` — Media Library integration JS.
- `dropzonejs/exif-js` — registered only when the exif-js library is present (client resize).
