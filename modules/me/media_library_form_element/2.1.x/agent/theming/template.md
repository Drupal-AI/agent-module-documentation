# Theming

## Theme hook
`media_library_element` (declared in `media_library_form_element_theme()`), default template
`templates/media-library-element.html.twig`. Render element key: `element`.

Preprocess `template_preprocess_media_library_element()` sets:
- `attributes`, `wrapper_attributes` — element/wrapper HTML attributes.
- `prefix`, `suffix` — `#field_prefix` / `#field_suffix`.
- `title_display` — `#title_display` (e.g. `invisible` adds `visually-hidden` to the legend).
- `required` — required flag.
- `legend.title` / `legend.attributes` — the fieldset legend built from `#title`.

Override by copying `media-library-element.html.twig` into your theme.

## Asset library
`media_library_form_element/media_library_form_element` (in
`media_library_form_element.libraries.yml`) attaches `assets/js/media_library.form-element.js`
and depends on core `drupal.dialog.ajax`, `sortable`, `once`, `jquery`, and
`media_library/style`. It is attached automatically by the element; no manual `#attached`
needed.
