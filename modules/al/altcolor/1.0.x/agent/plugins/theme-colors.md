<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# altcolor — the ThemeColors plugin type & preview negotiator

## Making a theme recolorable: `THEME.colors.yml`

The manager discovers one plugin per theme via `YamlDiscovery('colors', $theme_directories)`, so a
theme opts in simply by shipping `THEME.colors.yml`. Format (from
`tests/themes/test_theme_altcolor1/test_theme_altcolor1.colors.yml`):

```yaml
test_theme_altcolor1:
  colors:
    base:   { label: 'Base color' }
    text:   { label: 'Text color' }
    accent: { label: 'Accent color' }
  schemes:
    aqua_depths:
      label: 'Aqua depths'
      colors: { base: '#f0f8ff', text: '#1e3a5f', accent: '#4a90b8' }
    arctic_stream:
      label: 'Arctic stream'
      colors: { base: '#f8fcff', text: '#0f2027', accent: '#2c7da0' }
```

- `colors` — the configurable variables (key = variable name, `label` = admin label). At least one
  is **required** or `processDefinition()` throws `PluginException`.
- `schemes` — optional named palettes. Each scheme's `colors` keys must **match** the `colors` keys
  (else `PluginException`), and every scheme value must be a 7-char hex (`/^#[a-fA-F0-9]{6}$/`) or
  `processDefinition()` throws. `label`/`label_context` are registered as translatable.

## Plugin manager — `AltColorPluginManager`

`src/Plugin/AltColorPluginManager.php` (service `altcolor.manager`, also aliased to
`AltColorPluginManagerInterface`; extends `DefaultPluginManager`, cache bin `altcolor` on
`@cache.discovery`, tagged `plugin_manager_cache_clear`).

- `defaults`: `colors => []`, `schemes => []`, `class => Drupal\altcolor\Plugin\ThemeColors`.
- `providerExists()` = `themeHandler->themeExists()` (providers are themes, not modules).
- `getColorDefinitionsByTheme($theme)` — indexes every definition by its `provider` (theme), then
  walks the **theme inheritance chain** (`array_reverse(baseThemeExtensions) + activeTheme`) so a
  base theme's palette is inherited and a sub-theme can override it. Returns a `ThemeColors`
  instance built from the resolved definition's own `provider`, or `NULL`.
- `getColorDefinitionsForActiveTheme()` — same for the current active theme.
- `clearCachedDefinitions()` — also clears the per-theme static cache; called on theme
  install/uninstall.

## Plugin object — `ThemeColors`

`src/Plugin/ThemeColors.php` implements `ThemeColorsInterface` (extends core `PluginBase`):

- `getColors(): array` → `pluginDefinition['colors'] ?? []`
- `getSchemes(): array` → `pluginDefinition['schemes'] ?? []`

These feed both the settings form (fields + scheme select) and the preprocess injection.

## Preview theme negotiator — `ColorPreviewThemeNegotiator`

`src/Theme/ColorPreviewThemeNegotiator.php` (service `theme.negotiator.altcolor_preview`, tag
`theme_negotiator` **priority 9999**). Lets the settings page's preview iframe render the front page
in the theme being edited rather than the site's default front-end theme.

- `ColorForm::buildForm()` stashes the edited theme in the private tempstore under
  `"<uid>:preview_theme"` (bin `altcolor`).
- `applies()` returns TRUE only when **all** hold: query `altcolor_preview == '1'`, request header
  `Sec-Fetch-Site == 'same-origin'`, `Sec-Fetch-Dest == 'iframe'`, and the stored `preview_theme`
  resolves to an existing theme (`themeHandler->themeExists`). It intentionally does not re-check
  the admin permission — access was already enforced on the settings page that renders the iframe,
  and the tempstore value is per-user.
- `determineActiveTheme()` returns that theme name.

Because the tempstore key is the current user's id, one admin's preview selection cannot affect
another user's rendering.
