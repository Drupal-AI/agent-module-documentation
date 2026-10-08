<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Stylesheet generator and previews

To preview styles (in the library page and the CKEditor 5 iframe) UI Styles can emit a CSS
file containing **only** the rules that target declared style-option classes.

## Route / service

- Route `ui_styles.stylesheet` → path **`/ui_styles/stylesheet`**
  (`StylesheetController::generateStylesheet`, permission `access content`). A
  `page_cache_request_policy` (`AllowGeneratedStylesheet`) keeps it cacheable.
- Service `ui_styles.stylesheet_generator` →
  `Drupal\ui_styles\Service\StylesheetGenerator` (`StylesheetGeneratorInterface`).

```php
$css = \Drupal::service('ui_styles.stylesheet_generator')->generateStylesheet();
$css = \Drupal::service('ui_styles.stylesheet_generator')->generateStylesheet('.preview'); // prefix selectors
```

## How it works

1. For every installed theme, collect that theme's style options
   (`getDefinitionsForTheme()` → each option becomes a selector `.<class>`).
2. Load the CSS file contents of that theme's declared `libraries` (recursively following
   library dependencies) via the library discovery service.
3. Parse each CSS file with `sabberworm/php-css-parser` and **drop every selector that is not
   one of the style-option classes** (`cleanBlockFromUnwantedSelectors`). Optionally prefix
   the kept selectors with a container selector.
4. Scan the surviving rules for `var(--x)` usage and re-extract just the `:root`/variable
   declarations that define those custom properties (`generateCssVariables`), including
   `ui_skins` CSS-variable settings when that module is present.

The result is a compact stylesheet with the visual definitions of exactly the classes UI
Styles offers — nothing else — so previews render correctly without loading a whole theme.

## Notes

- Styles whose classes are **not** backed by CSS in a theme library will appear in the
  selector but produce no preview rules (the class is still applied to real output).
- `previewed_with` / `previewed_as` on a definition/option control how the library page wraps
  the preview sample; see [../plugins/define-styles.md](../plugins/define-styles.md).
- The `ui_styles_library` submodule renders these previews on `/admin/appearance/ui/styles`.
