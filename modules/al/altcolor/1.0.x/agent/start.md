<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alternative Color (altcolor) — agent index

A modern replacement for the removed core **Color module**. A theme that ships a
`THEME.colors.yml` becomes recolorable: the module adds a **Color scheme** section (with a live
front-page preview iframe) to that theme's settings form, stores the chosen colors in the theme's
**`third_party_settings.altcolor.colors`**, and on every request writes them as
`--color-<name>: <value>;` onto the `<html>` element's `style` attribute so they override the
theme's CSS defaults. Package: none. **No dependencies** beyond core. **No routes, no permissions,
no Drush, no config-install objects** of its own. Core `^10 || ^11`. License GPL-2.0-or-later.
Version 1.0.1 (version-dir 1.0.x).

## What it provides (from source)

- **Plugin type `altcolor:ThemeColors`** — `AltColorPluginManager` (`src/Plugin/AltColorPluginManager.php`,
  service `altcolor.manager`) uses a `YamlDiscovery('colors', …)` over all theme directories, so
  each theme's `THEME.colors.yml` is one plugin. Definitions carry `colors` (configurable variable
  names + labels) and `schemes` (named palettes). Plugin object: `ThemeColors`
  (`getColors()`, `getSchemes()`). See [plugins/theme-colors.md](plugins/theme-colors.md).
- **Theme settings integration** — `AltColorFormHooks::formSystemThemeSettingsAlter`
  (`#[Hook('form_system_theme_settings_alter')]`) embeds `ColorForm` (`src/Form/ColorForm.php`,
  form id `altcolor_settings`) into `system_theme_settings`, and a prepended submit handler moves
  the values into `third_party_settings`. See [config/settings.md](config/settings.md).
- **Color injection** — `AltColorPreprocessHooks::preprocessHtml` (`#[Hook('preprocess_html')]`)
  builds the `--color-*` style string; `AltColorHooks::themeRegistryAlter` re-orders it to run last
  so it wins over the theme's own preprocess. See [config/settings.md](config/settings.md).
- **Preview theme negotiator** — `ColorPreviewThemeNegotiator`
  (`src/Theme/ColorPreviewThemeNegotiator.php`, service `theme.negotiator.altcolor_preview`,
  priority 9999) forces the settings page's theme when the front page is loaded inside the preview
  iframe. See [plugins/theme-colors.md](plugins/theme-colors.md).
- **Alter hook** — `hook_altcolor_alter_colors($theme, &$colors, CacheableMetadata &$cm)` lets
  themes/modules add derived colors. See [api/alter-colors.md](api/alter-colors.md).

## Config

- Config schema only: `theme_settings.third_party.altcolor` (a `colors` sequence of `color_hex`),
  in `config/schema/altcolor.schema.yml`. Values live in each theme's own settings, not a module
  config object. Full detail in [config/settings.md](config/settings.md).

## Notes

- Procedural wrappers in `altcolor.module` are `#[LegacyHook]` shims that delegate to the OOP
  `src/Hook/*` services; the `#[Hook]` attributes are authoritative on Drupal 11.
- Requires a theme that defines `THEME.colors.yml`; without one the module adds nothing to the UI
  or the page. Test fixtures in `tests/themes/` show the file format.
