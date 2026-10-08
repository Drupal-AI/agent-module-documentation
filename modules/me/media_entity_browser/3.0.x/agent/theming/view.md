# Grid styling library

Library `media_entity_browser/view` (see `media_entity_browser.libraries.yml`):
- `css/media_entity_browser.view.css` (theme CSS for the thumbnail grid)
- `js/media_entity_browser.view.js`
- deps: `core/jquery`, `core/drupal`, `core/once`

It is attached automatically by a preprocess hook — `media_entity_browser_preprocess_views_view()`
adds the library when the rendered View id is `media_entity_browser`. To restyle the picker,
override these CSS/JS assets in a theme rather than editing the module.

The `media_entity_browser_media_library` submodule works the same way: its
`..._preprocess_views_view()` attaches core `media_library/view` plus its own
`media_entity_browser_media_library/view` library for the View id
`media_entity_browser_media_library`, and a `hook_form_alter` fixes the exposed filter's submit
button by adding `_media_library_views_form_media_library_after_build`.
