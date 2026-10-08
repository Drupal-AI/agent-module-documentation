<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ColorsHelper service, tokens, cron, install (dsfr4drupal_colors)

## Service `dsfr4drupal_colors.helper.colors`

`src/Helper/ColorsHelper.php` implements `ColorsHelperInterface`
(`src/Helper/ColorsHelperInterface.php`). Registered in `dsfr4drupal_colors.services.yml` with
`@file_system`; uses `UseCacheBackendTrait` + `StringTranslationTrait`.

### Constants (`ColorsHelperInterface`)

- `LIBRARY_PATH = 'libraries/dsfr/dist/'` — where the DSFR asset library must live.
- `CLASS_THEME_LIGHT = 'dsfr4drupal-colors-theme-light'`, `CLASS_THEME_DARK = 'dsfr4drupal-colors-theme-dark'`.
- `COLOR_ORDER` — fixed family ordering (blue, red, green, … grey, then system colors last).

### Key methods

- `getColorCssVariable($color)` → `--<color>`.
- `getColorCssValue($color)` → `var(--<color>)`.
- `getColorsAvailable()` — parses the DSFR core CSS, sorts, and **caches** under cid
  `dsfr4drupal_colors:colors`. Returns `hex => name`.
- `getColorsOptions()` — `name => name` options (for selects/checkboxes).
- `getColorsOptionsByGroups()` — options grouped into `primary` / `neutral` / `system` /
  `illustrative` per `getGroups()` (each group has label, description, `group_colors` prefixes).
- `getCssCorePath()` / `getCssSchemePath()` → `libraries/dsfr/dist/core/core.css` /
  `scheme/scheme.css`.
- `generateCssColorsFile()` — writes `public://dsfr4drupal-colors.css` (`FileExists::Replace`) with
  `:root, .theme-light { --name: hex; }` and `:root[data-fr-theme=dark], .theme-dark { … }` blocks.
  This file is the `dsfr4drupal_colors/colors` library's stylesheet.

### Palette parsing (private)

`parseCoreFile()` / `parseSchemeFile()` `file_get_contents` the **fixed** library paths above,
extract the `:root { … }` (and `:root[data-fr-theme=dark]`) block, then `findColors()` regex-matches
`--<name>: <#hex>;` declarations (excluding `hover`/`active`). `sortColors()` / `sortColorVariants()`
regroup and order by the DSFR token convention `color-name-variant-hint-state`. No request/user
input feeds any of these paths.

## Hooks — `src/Hook/Dsfr4drupalColorsHooks.php`

`.module` delegates each hook to this service class (wrapped with `#[LegacyHook]`); the class uses
`#[Hook(...)]` attributes.

- `help` — help text on `help.page.dsfr4drupal_colors`.
- `token_info` + `tokens` — token type `dsfr4drupal_color_field` with tokens `color`
  (variable name), `color_variable_name` (`--name`), `color_variable_css` (`var(--name)`). Consumed
  by the CSS formatter's token integration.
- `content_export_field_value_alter` — includes `dsfr4drupal_color_field_type` values in
  single_content_sync exports (`['color' => $field->color]`).
- `cron` — calls `generateCssColorsFile()` so the palette CSS stays in sync after a DSFR library
  upgrade, with no manual re-import.

## Install / requirements — `dsfr4drupal_colors.install`

- `hook_install()` → `generateCssColorsFile()` (creates `public://dsfr4drupal-colors.css` at enable).
- `hook_requirements($phase='runtime')` → errors if `getCssCorePath()` (the DSFR library core CSS)
  is missing under the Drupal root, pointing to the DSFR releases page. Uses
  `DeprecationHelper::backwardsCompatibleCall` for 11.2 severity enum vs. legacy constant.
