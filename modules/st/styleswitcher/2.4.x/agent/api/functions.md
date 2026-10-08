# Public functions, hooks, and the ParamConverter

The module has no injectable "public API service"; its reusable logic lives in procedural helpers in
`styleswitcher.module` plus a ParamConverter service. Styles are plain arrays
`{name, label, path, weight, status, is_default, _i, theme}`, not entities.

## Helper functions (styleswitcher.module)

| Function | Returns | Purpose |
| --- | --- | --- |
| `styleswitcher_style_load($name, $theme, $type = '')` | array\|null | Load one style by machine name for a theme. With `$type` (`theme`/`custom`) the name is prefixed. Returns NULL if no such defined style — this is the validation gate used by the ParamConverter and cookie resolution. |
| `styleswitcher_style_load_multiple($theme, array $filter = [])` | array | All styles for a theme (custom + theme-provided, merged with per-theme settings), optionally filtered by property (e.g. `['status' => TRUE]`). Statically cached. |
| `styleswitcher_custom_styles()` | array | Admin-defined styles from `styleswitcher.custom_styles` (or the default blank style). |
| `styleswitcher_theme_styles($theme, $original = NULL)` | array | Styles declared in the theme's (and base themes') `.info.yml` `styleswitcher:` key. |
| `styleswitcher_styles_settings($theme)` | array | Per-theme weight/status/is_default from `styleswitcher.styles_settings`. |
| `styleswitcher_default_style_key($theme)` | string | Resolve the default style key (admin default → theme default → blank). |
| `styleswitcher_theme_default_style_key($theme, $key = NULL)` | string\|null | Get/statically-set the theme-declared default key. |
| `styleswitcher_sort($a, $b)` | int | `uasort` callback: by `weight`, then insertion index `_i`. |
| `_styleswitcher_style_name($label)` | string | Transliterate a label to `[a-z0-9_]` machine name. |

Deprecated: constant `STYLESWITCHER_COOKIE_EXPIRE` — use `DefaultController::COOKIE_EXPIRE` instead.

## Hooks implemented

| Hook | Effect |
| --- | --- |
| `hook_page_attachments` | Attaches library `styleswitcher/dynamic-css` to every page. |
| `hook_css_alter` | Rewrites the placeholder `styleswitcher.active.css` asset to the `styleswitcher.css/{theme}` route, group `CSS_AGGREGATE_THEME`, `weight = PHP_INT_MAX`, so the chosen stylesheet wins. |
| `hook_theme` | Registers `styleswitcher_admin_item` (template `styleswitcher-admin-item.html.twig`, admin-only). |
| `hook_themes_uninstalled` | Removes `styleswitcher.styles_settings` entries for uninstalled themes. |

## ParamConverter

Service `styleswitcher.param_converter` = `\Drupal\styleswitcher\ParamConverter\StyleswitcherStyleConverter`
(tagged `paramconverter`). Applies to route params typed `styleswitcher_style` (the `{style}` param on
the edit/delete/switch routes). `convert()` calls `styleswitcher_style_load($value, $theme, $type)`;
a value that matches no defined style yields NULL → core raises a 404. This is why the switch route
and the edit/delete routes cannot be pointed at an arbitrary style name.

## Drupal 7 migrations

`migrations/` ships migrate-drupal source plugins: `d7_styleswitcher_settings`,
`d7_styleswitcher_styles_settings`, `d7_styleswitcher_custom_styles`, `d7_styleswitcher_block`
(state: `migrations/state/styleswitcher.migrate_drupal.yml`). Migrate only from the latest stable
7.x-2 release (see README).
