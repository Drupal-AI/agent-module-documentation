<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mechanism: theme-registry injection + Claro-hook delegation

All logic lives in `claro_media_library_theme.module`; there is no `src/`, no config, no templates.
The module makes the **active** theme render the media library exactly as **Claro** would, without
copying any Claro asset.

## 1. Bootstrap: make Claro's code available

At file top the module `require_once`s `DRUPAL_ROOT . '/core/themes/claro/claro.theme'` when it
exists; on newer core it instead loads Claro's `ClaroLinkActionTrait`, `Hook/ClaroHooks.php` and
`Hook/ClaroFormHooks.php`. This is needed because Claro's preprocess/alter functions and hook
classes are only autoloaded when Claro is the active theme — here it usually is not.

## 2. `hook_theme_registry_alter()` — register the theme hooks

For each media-library theme hook the module checks `!array_key_exists($hook, $theme_registry)` and,
if a `templateExists()` guard passes, defines the hook with:

- `template` and `path` pointing at Claro's own `.html.twig` (e.g.
  `core/themes/claro/templates/classy/media-library/media-library-item.html.twig`),
- `theme path` set to Claro's path, `type` `theme_engine`,
- an explicit `preprocess functions` chain that includes core's `template_preprocess_*`, the
  `media_library` module's preprocessors, and this module's own delegating callbacks.

Hooks registered: `media`, `media__media_library`, `media_library_wrapper`, `media_library_item`,
`media_library_item__small`, `media_library_item__widget`, `views_view__media_library`,
`views_view_unformatted__media_library`, `views_view_fields__media_library`,
`fieldset__media_library_widget`, `links__media_library_menu`,
`item_list__media_library_add_form_media_list`, `details__media_library_add_form_selected_media`,
`container__media_library_widget_selection`, `container__media_library_content`.

Then `claro_media_library_theme_force_claro_templates()` runs a second pass that
`array_replace()`es a subset of those hooks even when they already exist, forcing `template`,
`path` and `preprocess functions` to Claro's — again gated by `templateExists()`. This handles the
case where the active theme (or another module) already defined the hook against a different
template.

`templateExists($path, $template)` is a thin `file_exists(DRUPAL_ROOT . '/' . $path . '/' .
$template . '.html.twig')`. Paths are built from `theme_handler->getTheme('claro')->getPath()` plus
fixed literals — no request/user input reaches it.

## 3. `hook_library_info_alter()` — attach the CSS

Only for `$extension === 'media_library'`. It appends
`claro_media_library_theme/claro_media_library_theme` (the CSS in
`css/claro_media_library_theme.css`) to the `widget`, `view` and `ui` libraries' `dependencies`.
The CSS is a few static rules: hide `.js-media-library-widget-toggle-weight`, give the add form
bottom margin, size the views table/item attributes, center `.media-library-item__preview` and its
image, and zero out dialog padding/margin.

## 4. Form and views hooks — run Claro's alter/preprocess manually

Because Claro is not the active theme, its `hook_form_alter` / preprocess never fire on their own.
This module bridges that:

- `hook_form_alter()` — only when the form is a media-library Views form
  (`ViewsForm` whose base form id starts with `views_form_media_library`); attaches the library and
  calls Claro's `formAlter`.
- `hook_form_media_library_add_form_alter()` / `_upload_alter()` / `_oembed_alter()` — attach the
  library and call Claro's matching form-alter.
- `hook_views_pre_render()` — calls Claro's `viewsPreRender`.
- Preprocess callbacks (`..._preprocess_media_library_item__small`, `...__widget`,
  `..._preprocess_views_view_fields__media_library`, `..._preprocess_fieldset`,
  `...__media_library_widget`, `..._preprocess_links`, `...__media_library_menu`,
  `..._preprocess_item_list__...`, `..._preprocess_details`) referenced by the registered hooks.

Each delegating function uses the same pattern: if the legacy procedural function exists
(`function_exists('claro_preprocess_...')`) call it; otherwise call
`claro_media_library_theme_invoke_claro_hook()` / `_invoke_claro_form_hook()`, which lazily
instantiate `ClaroHooks` / `ClaroFormHooks` (guarded by `class_exists` + `method_exists`) and invoke
the equivalent OOP method. This makes the module tolerant of both the pre-11.4 procedural hook API
and the 11.4+ hook-class API.

## When it breaks / what to check

- **Still unstyled:** confirm the media library is genuinely opened under a non-Claro active theme,
  that Claro is installed (its template paths must resolve or every `templateExists()` guard fails
  silently), and that core is within `^11.4` — a core minor bump can move template paths or rename
  Claro hook methods and this module will no-op rather than error.
- **After a core update:** the hard-coded Claro template paths and the `ClaroHooks` method names are
  the fragile part; re-verify against the new Claro. The `^11.4` pin is the maintainer's signal that
  each minor needs re-checking.
- **Nothing at all happens:** the module short-circuits cleanly (empty registry entries, no-op
  invokes) when Claro or its hook classes are absent, so a missing/renamed Claro dependency degrades
  to "no styling" rather than a fatal.
