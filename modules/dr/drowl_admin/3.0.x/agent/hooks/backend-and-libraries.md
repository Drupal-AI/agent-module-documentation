<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# drowl_admin — hooks & CSS libraries

Everything the module *does* at runtime lives in `drowl_admin.module` (3 hooks + 1 helper) and the
CSS defined in `drowl_admin.libraries.yml`. There is no config, no route, no service. Install with
`drush en drowl_admin -y` (core `layout_builder` is pulled in as a dependency); nothing to configure
afterward.

## Hooks (`drowl_admin.module`)

### `drowl_admin_page_attachments(&$attachments)`
Runs on every page build; gates on `router.admin_context`->`isAdminRoute()`.
- On any admin route: attaches library `drowl_admin/admin_ckeditor_tweaks` (CKEditor CSS, not
  admin-theme-specific).
- Reads the admin theme from `system.theme` config (`admin`). If empty or the theme does not exist
  (checked via `theme_handler`), it returns early — no theme-specific CSS.
- On admin routes, by lowercased admin theme name: `adminimal` →
  `drowl_admin/admin_theme_overrides_adminimal`; `gin` → `drowl_admin/admin_theme_overrides_gin`.
- On Layout Builder routes (see helper): `claro` → `drowl_admin/layout_builder_claro`; `gin` →
  `drowl_admin/layout_builder_gin`.

### `drowl_admin_toolbar_alter(&$items)`
Attaches two libraries to `$items['administration']`: `drowl_admin/admin_toolbar_fixes` and
`drowl_admin/contextual_links`. (The code comment notes contextual-link CSS is attached here because
a `hook_contextual_links_view_alter`/library approach did not attach reliably — having the toolbar is
treated as a proxy for having contextual links.)

### `drowl_admin_editor_js_settings_alter(&$settings)`
Overrides the CKEditor `full_html` text format's `editorSettings.format_tags` to
`"p;h2;h3;h4;h5;h6;pre"` — i.e. removes the `h1` option from the paragraph-format dropdown for that
format. Client-side editor config only.

### `drowl_admin_is_layout_builder_route()` (helper)
Returns TRUE when the current route name matches `^layout_builder\.([^.]+\.)?` (regex). Used by
`page_attachments` to gate the Layout Builder CSS.

## Requirements check (`drowl_admin.install`)

`drowl_admin_requirements('runtime')` looks up the `drowl_admin/admin_iconset` library via
`library.discovery`. If the library definition is missing it throws. Otherwise it checks that the
iconset CSS file (`/libraries/drowl-admin-iconset/style.css`, resolved under `DRUPAL_ROOT`) exists
and adds a Status Report row `drowl_admin_iconset` — `REQUIREMENT_ERROR` with install instructions
(`composer require npm-asset/drowl-admin-iconset` via the asset-packagist repo) when absent.

## Libraries (`drowl_admin.libraries.yml`) — all CSS

| Library | CSS | Depends on | Attached by |
|---|---|---|---|
| `admin` | `css/drowl_admin.variables.min.css` | `admin_iconset` | (base for the others) |
| `admin_iconset` | `/libraries/drowl-admin-iconset/style.css` (external) | — | via `admin` |
| `admin_ckeditor_tweaks` | `css/drowl_admin.ckeditor_tweaks.min.css` | — | admin routes |
| `admin_theme_overrides_gin` | `css/drowl_admin.theme_overrides.gin.min.css` | core drupal/jquery/once/jquery.once, `admin` | Gin admin routes |
| `admin_theme_overrides_adminimal` | `css/drowl_admin.theme_overrides.adminimal.min.css` | `admin` | Adminimal admin routes |
| `admin_toolbar_fixes` | `css/drowl_admin.toolbar_fixes.min.css` | `admin` | toolbar |
| `contextual_links` | `css/drowl_admin.contextual_links.min.css` | `admin` | toolbar |
| `layout_builder_claro` | `css/drowl_admin.layout_builder.claro.min.css` | `admin` | LB routes (Claro) |
| `layout_builder_gin` | `css/drowl_admin.layout_builder.gin.min.css` | `admin` | LB routes (Gin) |

The `.scss` sources and a `gulpfile.js` build the `.min.css`; there is no shipped JS behavior. The
`admin_iconset` library points at a third-party asset dir that must be installed separately (see the
requirements check above).
