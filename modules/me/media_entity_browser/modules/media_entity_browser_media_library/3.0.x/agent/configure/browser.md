# Configure the Media Library-styled browser

Installs (from `config/install`):
- `entity_browser.browser.media_entity_browser_media_library` — the browser.
- `views.view.media_entity_browser_media_library` — the backing View (Media Library look).

Not visible until wired into an Entity Embed button (WYSIWYG). Manage via Entity Browser's UI
at `/admin/config/content/entity_browser`.

Runtime glue (`media_entity_browser_media_library.module`):
- `hook_preprocess_views_view` — for View id `media_entity_browser_media_library`, attaches
  core `media_library/view` + `media_entity_browser_media_library/view` libraries.
- `hook_form_alter` — on `views_exposed_form` for that View, adds
  `_media_library_views_form_media_library_after_build` to fix the exposed filter submit button.

For media reference fields use core's Media Library field widget instead of this browser.
