# Templates, theme hooks & CSS libraries

The module's entire job is markup + CSS for core's Media Library when it renders outside the
admin theme. It carries **no configuration** — behaviour is fixed in code.

## CSS libraries it registers (`media_library_theme_reset.libraries.yml`)

| Library | CSS file | When it loads |
|---|---|---|
| `media_library_theme_reset/media_library` | `css/media-library-fixes.css` | Attached to the Media Library **add-form** (`media_library_add_form`). Provides Claro's CSS variables + layout for `.media-library-wrapper`. |
| `media_library_theme_reset/olivero_fixes` | `css/olivero-fixes.css` | Attached **only when `olivero` is in the active theme chain** (exposed-filter spacing fixes). |

On the add-form the module also attaches core's own **`claro/media_library.theme`** library,
so the front-end page pulls in Claro's real media-library stylesheet.

Verify on a live site:
```bash
drush php:eval '$l=\Drupal::service("library.discovery")->getLibraryByName("media_library_theme_reset","media_library"); print $l["css"][0]["data"];'
# => modules/contrib/media_library_theme_reset/css/media-library-fixes.css
```

## Theme hooks it registers (`hook_theme()`)

14 hooks, each a copy of the Claro template so the classes/markup exist regardless of the
active front-end theme. Each declares a `base hook` so it slots into core's theme system:

`container__media_library_content`, `container__media_library_widget_selection`,
`details__media_library_add_form_selected_media`, `fieldset__media_library_widget`,
`item_list__media_library_add_form_media_list`, `links__media_library_menu`,
`media__media_library`, `media_library_item__small`, `media_library_item`,
`media_library_wrapper`, `views_exposed_form__media_library`, `views_view__media_library`,
`views_view_unformatted__media_library`.

The matching `*.html.twig` files ship in the module's `templates/` directory.

## Overriding a template

Copy any of the above `*.html.twig` files from the module's `templates/` directory into your
own theme's `templates/` directory and edit it — your theme's copy wins. (If your active
theme already defines one of these templates, that theme copy is used instead of the
module's.)

## Known issue — Stable 9-based themes

Themes based on **Stable 9** ship their own copies of `media--media-library.html.twig` and
`media-library-wrapper.html.twig`, which shadow this module's versions and drop essential
CSS classes, breaking the layout. Fix: copy those two templates from this module into your
theme's `templates/` directory.

## Runtime class-adding (no template needed)

Beyond templates, the module re-adds Claro's CSS classes at render time via
`hook_form_alter()` (adds `media-library-views-form*` / exposed-filter action classes),
`hook_views_pre_render()` (adds `media-library-view`, `media-library-item__*` classes to the
`media_library` view's page and widget displays), and several `hook_preprocess_*()` hooks
(menu items, grid items, unsaved-item previews, remove buttons, click-to-select checkboxes).
These are internal implementations copied from `claro.theme` — you don't call them.
