# Theming — how Gin Toolbar overrides the toolbar

Gin Toolbar has no config of its own; it works entirely through hooks in `gin_toolbar.module`.
Everything is gated by `_gin_toolbar_gin_is_active()` (true only when Gin/a Gin subtheme is the
active admin or default theme) and the `access toolbar` / `access navigation` permission.

## Theme hooks it defines (`hook_theme`)
| Hook | Template | Purpose |
|---|---|---|
| `navigation` | `templates/navigation/navigation--gin.html.twig` | Gin sidebar navigation (skipped if core Navigation module is on) |
| `menu_region__top` / `menu_region__middle` / `menu_region__bottom` | `templates/navigation/menu-region--*.html.twig` | Regions of the Gin navigation |
| `container__administration_menu` | `templates/container--administration-menu.html.twig` | Admin menu container (suggested via `hook_theme_suggestions_container_alter`) |

## Template overrides (`hook_theme_registry_alter`)
Re-points these core theme hooks at this module's `templates/` dir: `toolbar`, `toolbar__gin`,
`menu__toolbar`, `navigation` (unless Navigation module active), `navigation__gin`, `top_bar`.

## Libraries attached (`hook_page_attachments_alter`)
Always attaches Gin's `gin_base`, `gin_accent`, `gin_init`; conditionally `gin_custom_css`
(when `public://gin-custom.css` exists). Then, based on Gin's `classic_toolbar` setting, one of
`gin_classic_toolbar`, `gin_horizontal_toolbar`, `navigation`, or `gin_toolbar`; `core_navigation`
when the Navigation module is enabled. Dark/accent/focus/high-contrast values are pushed to
`drupalSettings.gin` and a `gin-setting-darkmode` JSON `<script>` in the head.

## Preprocess / alter behavior
- `preprocess_html`: sets `data-gin-accent` / `data-gin-focus` attributes, `gin--high-contrast-mode`
  and `gin--<variant>-toolbar` / `gin--navigation` classes; injects the new navigation structure.
- `preprocess_toolbar`: adds the lazy-built `user_picture`, moves the search tab to the start and
  the user tab to the end, exposes the current entity's edit URL and the admin content URL.
- `preprocess_menu` / `preprocess_menu__toolbar`: adds `gin_id` per item, moves config & help to the
  end, sets the logo/icon path.
- `library_info_alter`: injects Gin styling deps into core `drupal.dialog`, `ckeditor`,
  `drupal.ajax`, `media_library`, and `workbench` libraries.
- `toolbar_alter`: bumps the user tab weight to 1000 and sets `GinToolbar::preRenderTray` as the
  admin tray pre-render callback.
- `ckeditor_css_alter`: adds Gin's `variables`/`accent`/`ckeditor` CSS to CKEditor.
- `form_alter`: wraps node preview forms in `.gin-layout-container`.
- `requirements_alter`: removes core's `toolbar` requirement warning.

## Active-trail render callback
`src/Render/Element/GinToolbar.php` (`GinToolbar::preRenderTray`, a `TrustedCallbackInterface`)
rebuilds the administration tray with active-trail info, using the
`gin_toolbar.active_trail` service (`src/Menu/GinToolbarActiveTrail.php`) and honoring
Admin Toolbar's `menu_depth` (default 4) when that module is installed.
